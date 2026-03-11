-- Inventario Pro v2
-- Ejecuta este script en Supabase SQL Editor antes de seed.sql
create extension if not exists pgcrypto;

do $$
begin
  if not exists (select 1 from pg_type where typname = 'app_role') then
    create type public.app_role as enum ('admin', 'editor', 'viewer');
  end if;
end $$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text unique,
  full_name text,
  role public.app_role not null default 'viewer',
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.categorias (
  id uuid primary key default gen_random_uuid(),
  nombre text not null unique,
  created_at timestamptz not null default now()
);

create table if not exists public.productos (
  id uuid primary key default gen_random_uuid(),
  stock_code text unique,
  descripcion text not null,
  presentacion text,
  st_date text,
  unit text,
  cantidad numeric(12,2) not null default 0,
  cantidad_original text,
  detalle_cantidad text,
  pagina integer,
  categoria_id uuid references public.categorias(id) on delete set null,
  min_stock numeric(12,2) not null default 0,
  activo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.movimientos (
  id uuid primary key default gen_random_uuid(),
  producto_id uuid not null references public.productos(id) on delete cascade,
  tipo text not null check (tipo in ('entrada','salida','ajuste')),
  cantidad numeric(12,2) not null,
  stock_anterior numeric(12,2) not null default 0,
  stock_nuevo numeric(12,2) not null default 0,
  nota text,
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_profiles_updated_at on public.profiles;
create trigger trg_profiles_updated_at before update on public.profiles
for each row execute function public.set_updated_at();

drop trigger if exists trg_productos_updated_at on public.productos;
create trigger trg_productos_updated_at before update on public.productos
for each row execute function public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, full_name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1))
  )
  on conflict (id) do update
  set email = excluded.email,
      full_name = coalesce(excluded.full_name, public.profiles.full_name);
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

create or replace function public.current_role()
returns public.app_role
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select role from public.profiles where id = auth.uid()), 'viewer'::public.app_role)
$$;

create or replace function public.is_active_user()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select is_active from public.profiles where id = auth.uid()), false)
$$;

create or replace function public.admin_count()
returns integer
language sql
stable
security definer
set search_path = public
as $$
  select count(*)::integer from public.profiles where role = 'admin'
$$;

create or replace function public.bootstrap_first_admin()
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count integer;
begin
  if auth.uid() is null then
    raise exception 'No hay sesión activa';
  end if;

  select count(*) into v_count from public.profiles where role = 'admin';
  if v_count > 0 then
    raise exception 'Ya existe al menos un admin';
  end if;

  update public.profiles
  set role = 'admin', is_active = true
  where id = auth.uid();

  return 'ok';
end;
$$;

grant execute on function public.current_role() to anon, authenticated;
grant execute on function public.is_active_user() to anon, authenticated;
grant execute on function public.admin_count() to anon, authenticated;
grant execute on function public.bootstrap_first_admin() to authenticated;

alter table public.profiles enable row level security;
alter table public.categorias enable row level security;
alter table public.productos enable row level security;
alter table public.movimientos enable row level security;

-- Profiles
 drop policy if exists "profiles self read" on public.profiles;
create policy "profiles self read" on public.profiles
for select to authenticated
using (id = auth.uid());

drop policy if exists "profiles admin read" on public.profiles;
create policy "profiles admin read" on public.profiles
for select to authenticated
using (public.current_role() = 'admin' and public.is_active_user());

drop policy if exists "profiles admin update" on public.profiles;
create policy "profiles admin update" on public.profiles
for update to authenticated
using (public.current_role() = 'admin' and public.is_active_user())
with check (public.current_role() = 'admin' and public.is_active_user());

-- Categorias
 drop policy if exists "categorias read active users" on public.categorias;
create policy "categorias read active users" on public.categorias
for select to authenticated
using (public.is_active_user());

drop policy if exists "categorias write editors admins" on public.categorias;
create policy "categorias write editors admins" on public.categorias
for all to authenticated
using (public.current_role() in ('admin','editor') and public.is_active_user())
with check (public.current_role() in ('admin','editor') and public.is_active_user());

-- Productos
 drop policy if exists "productos read active users" on public.productos;
create policy "productos read active users" on public.productos
for select to authenticated
using (public.is_active_user());

drop policy if exists "productos insert editors admins" on public.productos;
create policy "productos insert editors admins" on public.productos
for insert to authenticated
with check (public.current_role() in ('admin','editor') and public.is_active_user());

drop policy if exists "productos update editors admins" on public.productos;
create policy "productos update editors admins" on public.productos
for update to authenticated
using (public.current_role() in ('admin','editor') and public.is_active_user())
with check (public.current_role() in ('admin','editor') and public.is_active_user());

drop policy if exists "productos delete admins" on public.productos;
create policy "productos delete admins" on public.productos
for delete to authenticated
using (public.current_role() = 'admin' and public.is_active_user());

-- Movimientos
 drop policy if exists "movimientos read active users" on public.movimientos;
create policy "movimientos read active users" on public.movimientos
for select to authenticated
using (public.is_active_user());

drop policy if exists "movimientos insert editors admins" on public.movimientos;
create policy "movimientos insert editors admins" on public.movimientos
for insert to authenticated
with check (
  public.current_role() in ('admin','editor')
  and public.is_active_user()
  and created_by = auth.uid()
);

drop policy if exists "movimientos delete admins" on public.movimientos;
create policy "movimientos delete admins" on public.movimientos
for delete to authenticated
using (public.current_role() = 'admin' and public.is_active_user());

create index if not exists idx_profiles_role on public.profiles(role);
create index if not exists idx_productos_categoria_id on public.productos(categoria_id);
create index if not exists idx_productos_stock_code on public.productos(stock_code);
create index if not exists idx_productos_descripcion on public.productos(descripcion);
create index if not exists idx_movimientos_producto_id on public.movimientos(producto_id);
create index if not exists idx_movimientos_created_by on public.movimientos(created_by);
create index if not exists idx_movimientos_created_at on public.movimientos(created_at desc);
