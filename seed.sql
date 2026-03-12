-- Carga inicial generada desde el Excel del inventario
begin;
insert into public.categorias (nombre) values ('Aguas y zumos') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Café e infusiones') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Cervezas') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Despensa y condimentos') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Destilados') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Espumosos') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Fruta y verdura') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Leches y bebidas vegetales') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Licores y aperitivos') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Otros') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Refrescos y mixers') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Siropes y mixers') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Suministros') on conflict (nombre) do nothing;
insert into public.categorias (nombre) values ('Vinos y aperitivos') on conflict (nombre) do nothing;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.032', 'Pimienta Negra Molida', 'Packet 910 gr', '31-08-25', 'Packet', 0.5, '0.5', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.407', 'Sal Fina', 'Packet 1 kg', '31-08-25', 'Packet', 0.5, '0.5', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.536', 'Salsa Tabasco', 'Each 60 ml', '31-07-25', 'Each', 0, '-', '-', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.550', 'Ketchup Heinz', 'Each 39 gr (80ud por caja)', '00-00-00', 'Each', 0, 'NO', 'NO', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.551', 'Mayonesa Heinz', 'Each 30 gr', '00-00-00', 'Each', 0, 'NO', 'NO', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0110.702', 'Aceite Aubocassa 250ml', '1l+1', '31-08-25', 'Liter', 3.0, '3', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.026', 'Sacarina sobre', '', '31-07-25', 'Box', 1.0, '1', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.227', 'Azucar Blanquilla Sobre', 'Blanco 5.5gr (caja 10kg)', '31-08-25', 'Box', 2.5, '2.5', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.814', 'Café Nespresso LunFo Prof', 'Each Unidad', '31-08-25', 'Each', 400.0, '400', '', 1, 120, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.818', 'Te Dammann Darjeeling 1*24', 'Caja * 24 saquitos', '31-08-25', 'Box', 1.0, '1', '', 1, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.836', 'Café Nespresso Desca Prof', 'Unidad', '31-08-25', 'Each', 200.0, '200', '', 1, 60, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.837', 'Café Nespresso Ristr Prof', 'Unidad', '31-08-25', 'Each', 200.0, '200', '', 1, 60, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.838', 'Café Nespresso Legge Prof', 'Unidad', '31-08-25', 'Each', 300.0, '300', '', 1, 90, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.867', 'Café Lavazza Gold Selecti', 'GOLD SELECTION 1 KG', '31-08-25', 'Kg', 500.0, '500 g', 'g', 2, 150, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.875', 'Te T''estim Menta-Pol 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.881', 'Te T''estim Te verd 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.882', 'Te T''estim Te negro 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 1.0, '1', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.883', 'Te T''estim Te rojo 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.884', 'Te T''estim Rooiboos 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 1.0, '1', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0111.886', 'Te T''estim Manzanil 1*12', 'Caja * 12 saquitos', '31-08-25', 'Box', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Café e infusiones'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0112.358', 'Caramelos Menta', 'Packet 1kg', '31-08-25', 'Kg', 3.5, '3.5 kg', 'kg', 2, 1, c.id
from public.categorias c where c.nombre = 'Despensa y condimentos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0112.831', 'Leche de Soja', 'Each 1 L', '31-08-25', 'Each', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Leches y bebidas vegetales'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0112.919', 'Macedonia Lata 1.485 gne', '', '30-06-25', 'Each', 0, '-', '-', 2, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0120.013', 'Leche Entera Gallega', '1 litro', '31-08-25', 'Liter', 2.0, '2', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Leches y bebidas vegetales'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0120.058', 'Leche de Avena', 'Bio Barista 1 Lt', '31-08-25', 'Each', 1.0, '1', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Leches y bebidas vegetales'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0120.059', 'Leche de Almendra', 'Sin Azucar', '31-08-25', 'Each', 1.0, '1', '', 2, 1, c.id
from public.categorias c where c.nombre = 'Leches y bebidas vegetales'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0150.027', 'Fru Limas', 'Kg', '31-05-25', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0150.028', 'Fru Limon', 'Kg', '31-07-25', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0150.048', 'Fru Naranja', 'Kg', '31-07-25', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0150.400', 'Veg Pepino Nacional', 'Kg', '31-05-25', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0150.948', 'Veg Hierbabuena Manojo', 'Bunch', '30-09-24', 'Bunch', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Fruta y verdura'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0151.266', 'Pure Fruta+Monin Fruta de', 'Litro', '00-00-00', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Otros'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0151.267', 'Pure Fruta+Monin Mango', 'Litro', '31-05-24', 'Kg', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Otros'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.002', 'Coca Cola Reg Vid', 'Bot. 0.35ml', '31-08-25', 'Bottle', 100.0, '100', '', 3, 30, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.003', 'Coca Cola 237ml Reg Vid', '', '30-03-17', 'Bottle', 0, '-', '-', 3, 1, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.004', 'Coca Cola 237ml Zer Vid', '', '30-05-17', 'Bottle', 5.0, '5', '', 3, 1, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.011', 'Coca Cola Zero Vid', '350 ml', '31-08-25', 'Bottle', 91.0, '91', '', 3, 27, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.013', 'Fanta Limon Vid', '350 ml', '31-08-25', 'Bottle', 174.0, '174', '', 3, 52, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.015', 'Fanta Naranja Vid', '350 ml', '31-08-25', 'Bottle', 86.0, '86', '', 3, 25, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.018', 'Fever Tree Ginger Beer', 'Bottle 200 ml Caja 24 ud', '31-08-25', 'Bottle', 67.0, '67', '', 4, 20, c.id
from public.categorias c where c.nombre = 'Cervezas'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.019', 'Fever Tree Soda', '', '31-08-25', 'Bottle', 31.0, '31', '', 4, 9, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.020', 'Fever Tree Tonica', 'Bottle 200 ml Caja 24 ud', '31-08-25', 'Bottle', 189.0, '189', '', 4, 56, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.024', 'Nestea Limon Vid', '300 ml', '31-08-25', 'Bottle', 13.0, '13', '', 4, 3, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.029', 'Sprite Vid', '350 ml', '31-08-25', 'Bottle', 91.0, '91', '', 4, 27, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.035', 'Fever Tree Tonica Light', '', '30-06-24', 'Bottle', 34.0, '34', '', 4, 10, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.041', 'Fanta Limón 237ml Reg Vid', '', '00-00-00', 'Bottle', 42.0, '42', '', 4, 12, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.042', 'Coca Cola Crist Light 0.2', '237 cl', '00-00-00', 'Bottle', 58.0, '58', '', 4, 17, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.043', 'Sprite 237cl', '', '00-00-00', 'Bottle', 18.0, '18', '', 4, 5, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0251.045', 'Appletiser', '0.275 ml (Caja 24 ud)', '00-00-00', 'Bottle', 0, '-', '-', 4, 1, c.id
from public.categorias c where c.nombre = 'Refrescos y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0252.102', 'Zumo Granini Cramberry', 'Bottle 1 L', '31-08-25', 'Bottle', 3.0, '3', '', 4, 1, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0252.105', 'Zumo Granini Manzana', 'Bottle 1L', '31-08-25', 'Bottle', 1.0, '1', '', 4, 1, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0252.121', 'Zumo Granini Naranja 1L', 'Bottle 1L', '31-08-25', 'Bottle', 16.0, '16', '', 4, 4, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0253.026', 'Agua Font Major 0.33cl', 'Bottle 33 cl Pet Box 35ud', '31-08-25', 'Bottle', 96.0, '96', '', 4, 28, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0253.110', 'Agua S.Pellegrino3/4 c/g', 'Bottle 750 ml', '31-08-25', 'Bottle', 3.0, '3', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0253.113', 'Agua Solan de Cabras 0.75', '12 unidades por caja', '31-08-25', 'Bottle', 133.0, '133', '', 5, 39, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0253.114', 'Agua Solan Gas 0.75 ml', '12 unidades por caja', '31-08-25', 'Bottle', 300.0, '300', '', 5, 90, c.id
from public.categorias c where c.nombre = 'Aguas y zumos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0257.001', 'Estrella Damm Barril', '30 L', '31-08-25', 'Each', 2.0, '2', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Cervezas'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0257.210', 'Estrella Damm Botella', 'Bottle 330 ml', '31-08-25', 'Bottle', 31.0, '31', '', 5, 9, c.id
from public.categorias c where c.nombre = 'Cervezas'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0257.211', 'Estrella Damm s/Alcoh', 'Bot 330 ml', '31-08-25', 'Bottle', 29.0, '29', '', 5, 8, c.id
from public.categorias c where c.nombre = 'Cervezas'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0258.002', 'Campari 1Lt', '', '31-07-25', 'Bottle', 5.0, '5', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0258.022', 'Vermouth Muntaner Tinto', 'Bottle 750 ml', '31-08-25', 'Bottle', 0, '-', '-', 5, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0258.027', 'Aperol', 'Bottle 1 L', '31-08-25', 'Bottle', 9.0, '9', '', 5, 2, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.505', 'Vino Abadia Del Robl Tint', '', '00-00-00', 'Bottle', 2.0, '2', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.565', 'Vino Ribas Crianza', '', '31-08-25', 'Bottle', 6.0, '6', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.678', 'Vino Petalos del Bierzo', 'J.Palacios', '31-08-25', 'Bottle', 23.0, '23', '', 5, 6, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.686', 'Vino Natureo Syrah Tinto', 'Sin Alcohol', '31-08-25', 'Bottle', 20.0, '20', '', 5, 6, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.901', 'Vino Finca Martelo', '', '31-08-25', 'Bottle', 4.0, '4', '', 5, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.915', 'Vino Ava vi negre', '2016', '00-00-00', 'Bottle', 5.0, '5', '', 6, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.931', 'Vino Secret del Priorat', '', '31-08-25', 'Bottle', 6.0, '6', '', 6, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0261.932', 'Vino Intramurs de Poblet', 'Tinto', '31-08-25', 'Bottle', 37.0, '37', '', 6, 11, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.599', 'Vino Natureo Muscat Blanc', 'Sin Alcohol', '31-08-25', 'Bottle', 12.0, '12', '', 6, 3, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.604', 'Vino Albariño Fefiñ2014', '', '31-08-25', 'Bottle', 25.0, '25', '', 6, 7, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.674', 'Vino Ava Blanc', '2022', '31-07-25', 'Bottle', 24.0, '24', '', 6, 7, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.713', 'Vino Pedro Escudero', 'Valdelagunde', '30-06-25', 'Bottle', 25.0, '25', '', 6, 7, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.729', 'Vino Son de Prades', '', '31-08-25', 'Bottle', 19.0, '19', '', 6, 5, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.730', 'Vino A Telleira', '', '31-08-25', 'Bottle', 33.0, '33', '', 6, 9, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.736', 'Vino Jean Leon Vinya Gigi', 'Chardonnay Eco', '31-08-25', 'Bottle', 31.0, '31', '', 6, 9, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0262.994', 'Vino Supernova Blanco', '', '00-00-00', 'Bottle', 3.0, '3', '', 6, 1, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0263.027', 'Vino Son Grau Rosado', '', '31-08-25', 'Bottle', 38.0, '38', '', 6, 11, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0263.029', 'Vino Panoramico Clarete', '', '30-04-25', 'Bottle', 14.0, '14', '', 6, 4, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0263.038', 'Vino Sericis Pinot noir', 'Viñas Viejas Rosado', '31-08-25', 'Bottle', 95.0, '95', '', 6, 28, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0263.040', 'Vino Natureo Rosado', 'Garnacha Syrah Sin Alcoho', '31-08-25', 'Bottle', 16.0, '16', '', 6, 4, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0263.041', 'Vino Arzuaga Rose Eco', '2024', '30-06-25', 'Bottle', 22.0, '22', '', 7, 6, c.id
from public.categorias c where c.nombre = 'Vinos y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.052', 'Champ Billecart Brut', 'Reserve', '31-08-25', 'Bottle', 12.0, '12', '', 7, 3, c.id
from public.categorias c where c.nombre = 'Espumosos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.113', 'Cava Chamcalet', '', '31-08-25', 'Bottle', 50.0, '50', '', 7, 15, c.id
from public.categorias c where c.nombre = 'Espumosos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.126', 'Cava Coquet (5+1)', 'Mestres 2018', '31-07-25', 'Bottle', 20.0, '20', '', 7, 6, c.id
from public.categorias c where c.nombre = 'Espumosos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.127', 'Cava Mestres Gran Re Rosé', 'Mestres', '31-08-25', 'Bottle', 0, '-', '-', 7, 1, c.id
from public.categorias c where c.nombre = 'Espumosos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.128', 'Lyre''s Cava', 'XDRINKS', '17-11-24', 'Bottle', 12.0, '12', '', 7, 3, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0264.302', 'Vino Espumoso Natureo', 'Sparkling Sin Alcohol', '31-08-25', 'Bottle', 0, '-', '-', 7, 1, c.id
from public.categorias c where c.nombre = 'Espumosos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.061', 'Whiskey Bourbon Bulleit', 'Bottle 70 cl', '31-08-25', 'Bottle', 3.0, '3', '', 7, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.065', 'Whiskey J.Daniel''s', 'Bottle 70 cl', '31-08-25', 'Bottle', 46.0, '46', '', 7, 13, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.066', 'Whiskey J.Walker Blak', 'Bottle 70 cl', '31-08-25', 'Bottle', 7.0, '7', '', 7, 2, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.068', 'Whiskey Jameson', 'Bottle 70 cl', '31-08-25', 'Bottle', 0.6, '0.6', '', 7, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.079', 'Whiskey Glenfiddi 12yo', 'Bottle 70 cl', '31-08-25', 'Bottle', 13.0, '13', '', 7, 3, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.081', 'Whiskey Dewar''s', 'Bottle 70 cl BACARD', '31-08-25', 'Bottle', 3.4, '3.4', '', 7, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0267.104', 'Whiskey J.Walker Red', 'Bottle 70 cl', '31-08-25', 'Bottle', 3.0, '3', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.001', 'Vodka Absolut', 'Bottle 70 cl', '31-08-25', 'Bottle', 5.5, '5.5', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.004', 'Vodka Belvedere Vodka', 'Bottle 70cl', '31-08-25', 'Bottle', 9.0, '9', '', 8, 2, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.053', 'Gin Bombay Sapphire', 'Bottle 70 cl', '31-08-25', 'Bottle', 3.0, '3', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.054', 'Gin Brockmans', 'Bottle 70 cl', '31-08-25', 'Bottle', 5.0, '5', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.060', 'Gin Mare', 'Bottle 70 cl', '31-08-25', 'Bottle', 0, '-', '-', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.067', 'Gin Tanquerey', 'Bottle 70 cl', '31-08-25', 'Bottle', 0, '-', '-', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.068', 'Gin Tanquerey Ten', 'Bottle 70 cl', '31-08-25', 'Bottle', 52.0, '52', '', 8, 15, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.072', 'Gin Eva', 'Bottle 70 cl', '31-08-25', 'Bottle', 12.2, '12.2', '', 8, 3, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.085', 'Gin Tanqueray 0,0', 'Bottle 70 cl', '31-08-25', 'Bottle', 8.0, '8', '', 8, 2, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0268.089', 'Gin Xoriguer', '70cl', '31-08-25', 'Bottle', 1.0, '1', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.002', 'Ron Bacardi Blanco', 'Bottle 1 litro BACARD', '31-08-25', 'Bottle', 20.5, '20.5', '', 8, 6, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.007', 'Tequila Patron Silver', 'Bottle 0.70 cl BACARDI', '30-09-24', 'Bottle', 2.0, '2', '', 8, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.013', 'Ron Barceló Añejo', 'Bottle 70 cl', '31-08-25', 'Bottle', 4.0, '4', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.016', 'Ron Bacardi 8 years', 'Bottle 70 cl BACARDI', '31-08-25', 'Bottle', 3.0, '3', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.017', 'Ron Sta. Teresa Gran Rva', 'Bottle 70 cl', '31-08-25', 'Bottle', 4.0, '4', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.022', 'Ron Flor de Caña 12 años', '', '31-08-25', 'Bottle', 12.0, '12', '', 9, 3, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0269.054', 'Tequila Sauza Blanco', 'Bottle 70 cl', '31-08-25', 'Bottle', 5.8, '5.8', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0270.053', 'Grappa Sibona', 'Bottle 350 ml Di Nebbiolo', '31-08-25', 'Bottle', 0.6, '0.6', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0272.063', 'Jarabe Monin Sauco', 'Bottle 70 cl', '30-09-24', 'Bottle', 1.0, '1', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Siropes y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0272.076', 'Sour Line Azucar Blanquil', 'Bottle 70 cl', '17-11-24', 'Bottle', 3.0, '3', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Siropes y mixers'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.002', 'Averna Amaro 0.70cl', '', '00-00-00', 'Bottle', 2.0, '2', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.008', 'Cognac Soberano', 'Bottle 1 L', '31-08-25', 'Bottle', 1.0, '1', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Destilados'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.015', 'Jagermeister', 'Bottle 70 cl', '31-08-25', 'Bottle', 0, '-', '-', 9, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.016', 'Kahlua', 'LITRO', '31-08-25', 'Bottle', 0, '-', '-', 9, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.033', 'Malibu', 'Bottle 70 cl', '31-08-25', 'Bottle', 2.0, '2', '', 9, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.039', 'Ramazzotti', 'Bottle 70 cl', '00-00-00', 'Bottle', 2.0, '2', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.044', 'Licor Cointreau', 'Bottle 70 cl', '30-06-25', 'Bottle', 1.0, '1', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.046', 'Licor Hierbas Mixtas', 'Bottle 70 cl', '31-08-25', 'Bottle', 0.5, '0.5', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.047', 'Licor Hierbas Secas', 'Bottle 70 cl', '31-08-25', 'Bottle', 3.0, '3', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.048', 'Licor Hierbas Premium Moy', 'Bottle 70 cl', '17-11-24', 'Bottle', 2.0, '2', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.049', 'Licor Limoncello Villa Ma', 'Bottle 70 cl', '31-08-25', 'Bottle', 9.0, '9', '', 10, 2, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.082', 'Licor B.Bora Banana 0.70', '', '30-09-24', 'Bottle', 0, '-', '-', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.093', 'Triple Sec 1 Litro Cocina', '', '31-08-25', 'Bottle', 0, '-', '-', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.099', 'Lyre''s Italian Spritz', '', '17-11-24', 'Bottle', 8.0, '8', '', 10, 2, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.102', 'Lyre''s Orange Sec Triple Sec', '', '00-00-00', 'Bottle', 3.0, '3', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.109', 'Licor Nojae Edelflower', '', '00-00-00', 'Bottle', 3.0, '3', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0273.112', 'Lyre''s Agave Blanco sprit', '', '00-00-00', 'Bottle', 3.0, '3', '', 10, 1, c.id
from public.categorias c where c.nombre = 'Licores y aperitivos'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
insert into public.productos (stock_code, descripcion, presentacion, st_date, unit, cantidad, cantidad_original, detalle_cantidad, pagina, min_stock, categoria_id)
select '0421.707', 'Marcadores Pizarra* 4U', 'Niceday', '31-08-25', 'Each', 24.0, '24', '', 10, 7, c.id
from public.categorias c where c.nombre = 'Suministros'
on conflict (stock_code) do update set
descripcion = excluded.descripcion,
presentacion = excluded.presentacion,
st_date = excluded.st_date,
unit = excluded.unit,
cantidad = excluded.cantidad,
cantidad_original = excluded.cantidad_original,
detalle_cantidad = excluded.detalle_cantidad,
pagina = excluded.pagina,
min_stock = excluded.min_stock,
categoria_id = excluded.categoria_id;
commit;