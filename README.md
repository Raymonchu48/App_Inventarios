# Inventario Pro v2

Versión renovada de la app de inventario para GitHub Pages + Supabase.

## Qué añade
- interfaz clara y menos oscura
- login y registro con Supabase Auth
- roles `admin`, `editor`, `viewer`
- activación/bloqueo de usuarios
- panel de administración de permisos
- políticas RLS en base de datos
- botón de bootstrap para convertir al primer usuario en admin inicial

## Pasos de despliegue
1. Crea un proyecto en Supabase.
2. En SQL Editor ejecuta `schema.sql`.
3. Después ejecuta `seed.sql`.
4. Activa Email/Password en Authentication > Providers.
5. Rellena `config.js` con `SUPABASE_URL` y `SUPABASE_ANON_KEY`.
6. Sube esta carpeta a GitHub y publica con GitHub Pages.
7. Registra tu primer usuario.
8. En la app pulsa **Convertirme en admin inicial**.
9. Desde **Administración** asigna roles a otros usuarios.

## Reglas de acceso
- `admin`: puede todo, incluida la gestión de usuarios y borrado de productos.
- `editor`: puede crear/editar productos y registrar movimientos.
- `viewer`: solo lectura.

## Archivos principales
- `index.html`
- `styles.css`
- `app.js`
- `schema.sql`
- `seed.sql`
- `data.json`

## Nota
Si tienes confirmación de email obligatoria en Supabase, el usuario deberá verificar el correo antes de iniciar sesión.
