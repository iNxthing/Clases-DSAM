CREATE DATABASE IF NOT EXISTS db_ventas_ropa;
USE db_ventas_ropa;

-- 1. Tabla Categorías
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);

-- 2. Tabla Productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(80) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT fk_prod_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 3. Tabla Vendedores (Reguetonero + Anime)
CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    sucursal VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL
);

-- 4. Tabla Clientes (Reguetonero + Anime)
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- 5. Tabla Ventas (Cabecera)
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_venta DATETIME NOT NULL,
    total_venta DECIMAL(12,2) DEFAULT 0.00,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_venta_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

-- 6. Tabla Detalle de Ventas
CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_det_venta FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE,
    CONSTRAINT fk_det_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
-- Categorías
INSERT INTO categorias (nombre_categoria) VALUES 
('Hoodies y Buzos'), ('Camisetas Oversize'), ('Pantalones Jogger'), ('Chaquetas Urbanas'), ('Calzado Deportivo');

-- Productos
INSERT INTO productos (nombre_producto, id_categoria, precio, stock) VALUES 
('Hoodie Oversize Akatsuki Edition', 1, 145000.00, 50),
('Buzo Basico Negro Colección Cyber', 1, 120000.00, 40),
('Camiseta Estampada DBZ Goku', 2, 65000.00, 80),
('Camiseta Minimalista Estilo Cyberpunk', 2, 60000.00, 60),
('Jogger Cargo Tactical Negro', 3, 110000.00, 45),
('Jogger Jogging Clásico Gris', 3, 95000.00, 35),
('Chaqueta Impermeable Cortavientos', 4, 210000.00, 25),
('Chaqueta Denim Estilo Retro', 4, 190000.00, 20),
('Tenis Urbanos Chunky White', 5, 280000.00, 30),
('Tenis Deportivos Running Pro', 5, 310000.00, 15);

-- Vendedores (Reguetonero + Anime)
INSERT INTO vendedores (nombre_completo, sucursal, fecha_contratacion) VALUES 
('Yandel Uchiha', 'Centro Comercial Santa Marta', '2024-01-15'),
('Maluma Uzumaki', 'Sucursal Norte Barranquilla', '2024-03-10'),
('Arcángel Midoriya', 'Plaza Central Medellín', '2023-11-20'),
('Daddy Yankee Lelouch', 'Mall Comercial Bogotá', '2023-05-01'),
('Bad Bunny Roronoa', 'Costa Azul Cartagena', '2024-02-18');

-- Clientes (Reguetonero + Anime)
INSERT INTO clientes (nombre_completo, ciudad, telefono) VALUES 
('Anuel Light', 'Santa Marta', '3001112233'),
('Feid Tanjiro', 'Medellín', '3102223344'),
('J Balvin Gohan', 'Bogotá', '3203334455'),
('Bryant Myers Kakashi', 'Barranquilla', '3154445566'),
('Rauw Alejandro Meliodas', 'Cali', '3185556677'),
('Myke Towers Kirito', 'Cartagena', '3016667788'),
('Ozuna Edward Elric', 'Santa Marta', '3127778899'),
('Sech Saitama', 'Bucaramanga', '3218889900');

-- Ventas Bloque 1
INSERT INTO ventas (id_cliente, id_vendedor, fecha_venta, total_venta) VALUES 
(1, 1, '2026-09-01 10:30:00', 355000.00),
(2, 2, '2026-09-02 14:15:00', 210000.00),
(3, 1, '2026-09-03 16:45:00', 490000.00),
(4, 3, '2026-09-04 11:20:00', 145000.00),
(5, 4, '2026-09-05 13:10:00', 590000.00);

-- Detalle Ventas Bloque 1
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES 
(1, 1, 1, 145000.00, 145000.00),
(1, 5, 2, 105000.00, 210000.00), -- Ajustado simulación
(2, 7, 1, 210000.00, 210000.00),
(3, 9, 1, 280000.00, 280000.00),
(3, 3, 3, 70000.00, 210000.00),
(4, 1, 1, 145000.00, 145000.00),
(5, 10, 1, 310000.00, 310000.00),
(5, 8, 1, 280000.00, 280000.00);
CREATE VIEW vw_resumen_ventas AS
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.nombre_completo AS cliente,
    vnd.nombre_completo AS vendedor,
    vnd.sucursal,
    v.total_venta
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN vendedores vnd ON v.id_vendedor = vnd.id_vendedor;

-- Forma de consultarla en el tablero:
SELECT * FROM vw_resumen_ventas WHERE total_venta > 200000;
CREATE VIEW vw_inventario_critico AS
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio,
    p.stock
FROM productos p
JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE p.stock <= 30;

-- Forma de consultarla en el tablero:
SELECT * FROM vw_inventario_critico ORDER BY stock ASC;
-- Más Vendedores con temática Reguetonero + Anime
INSERT INTO vendedores (nombre_completo, sucursal, fecha_contratacion) VALUES 
('Farruko Vegeta', 'Centro Comercial Santa Marta', '2024-05-12'),
('Jhayco Todoroki', 'Sucursal Norte Barranquilla', '2024-06-01');

-- Más Clientes con temática Reguetonero + Anime
INSERT INTO clientes (nombre_completo, ciudad, telefono) VALUES 
('De la Ghetto Bakugo', 'Medellín', '3199990011'),
('Ñengo Flow Saitama Jr', 'Cali', '3168887766'),
('Ñejo L Lawliet', 'Bogotá', '3145554433');

-- Nuevas Ventas Bloque 2
INSERT INTO ventas (id_cliente, id_vendedor, fecha_venta, total_venta) VALUES 
(6, 6, '2026-09-10 10:00:00', 420000.00),
(7, 7, '2026-09-11 15:30:00', 250000.00),
(8, 2, '2026-09-12 18:00:00', 500000.00);

-- Nuevos Detalles de Venta Bloque 2
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES 
(6, 9, 1, 280000.00, 280000.00),
(6, 4, 2, 70000.00, 140000.00),
(7, 2, 1, 120000.00, 120000.00),
(7, 6, 1, 130000.00, 130000.00),
(8, 10, 1, 310000.00, 310000.00),
(8, 5, 1, 190000.00, 190000.00);



-- 1. básico - vista de clientes por ciudad: crear una vista llamada vw_clientes_santamarta
-- que muestre únicamente el nombre completo y teléfono de los clientes que residen en 'santa marta'.
create view vw_clientes_santamarta as
select
nombre_completo,
telefono
from clientes
where ciudad = 'santa marta';
select * from vw_clientes_santamarta;

-- 2. básico - vista de catálogo accesible: crear una vista llamada vw_catalogo_economico que
-- liste los productos cuyo precio sea menor a 100000.00.
create view vw_catalogo_economico as
select
nombre_producto,
precio,
stock
from productos
where precio < 100000.00;

select * from vw_catalogo_economico;


-- 3. básico - vista de vendedores por sucursal: diseñar una vista que filtre a los vendedores
-- que laboran en la sucursal de 'centro comercial santa marta'.
create view vw_vendedores_santa_marta as
select
nombre_completo,
sucursal,
fecha_contratacion
from vendedores
where sucursal = 'centro comercial santa marta';
select * from vw_vendedores_santa_marta;



-- 4. intermedio - vista con join de productos y categorías: crear una vista llamada
-- vw_productos_detallados que relacione el nombre del producto, su precio, stock y
-- el nombre de su categoría correspondiente.
create view vw_productos_detallados as
select
p.nombre_producto,
p.precio,
p.stock,
c.nombre_categoria
from productos p
inner join categorias c on c.id_categoria=p.id_categoria;
select * from vw_productos_detallados;


-- 5. intermedio - vista de rendimiento por vendedor: desarrollar una vista que muestre
-- el nombre del vendedor y cuántas ventas totales ha registrado en el sistema.
create view vw_rendimiento_vendedores as
select
v.nombre_completo as vendedor,
count(vt.id_venta) as total_ventas
from vendedores v
left join ventas vt on vt.id_vendedor=v.id_vendedor
group by v.id_vendedor, v.nombre_completo;
select * from vw_rendimiento_vendedores;


-- 6. intermedio - vista de facturación detallada: hacer una vista que combine la tabla ventas,
-- clientes y detalle_ventas para ver el id de venta, fecha, cliente, producto comprado y cantidad.
create view vw_facturacion_detallada as
select
vt.id_venta,
vt.fecha_venta,
c.nombre_completo as cliente,
p.nombre_producto as producto,
d.cantidad
from detalle_ventas d
inner join ventas vt on vt.id_venta=d.id_venta
inner join clientes c on c.id_cliente=vt.id_cliente
inner join productos p on p.id_producto=d.id_producto;
select * from vw_facturacion_detallada;


-- 7. intermedio - vista de clientes frecuentes: construir una vista que liste a los clientes que
-- hayan realizado más de una compra en el sistema.
create view vw_clientes_frecuentes as
select
c.nombre_completo as cliente,
count(vt.id_venta) as compras_realizadas
from clientes c
inner join ventas vt on vt.id_cliente=c.id_cliente
group by c.id_cliente, c.nombre_completo
having count(vt.id_venta) > 1;
select * from vw_clientes_frecuentes;


-- 8. avanzado - vista de total vendido por categoría: crear una vista agregada que sume los ingresos
-- totales (subtotales) generados por cada categoría de ropa.
create view vw_ingresos_por_categoria as
select
cat.nombre_categoria as categoria,
sum(d.subtotal) as ingresos_totales
from categorias cat
inner join productos p on p.id_categoria=cat.id_categoria
inner join detalle_ventas d on d.id_producto=p.id_producto
group by cat.id_categoria, cat.nombre_categoria;
select * from vw_ingresos_por_categoria;


-- 9. avanzado - vista de gasto total por cliente: diseñar una vista que calcule la suma acumulada
-- de dinero que cada cliente ha gastado en la tienda.
create view vw_gasto_total_cliente as
select
c.nombre_completo as cliente,
sum(vt.total_venta) as gasto_total
from clientes c
inner join ventas vt on vt.id_cliente=c.id_cliente
group by c.id_cliente,c.nombre_completo
order by gasto_total desc;
select * from vw_gasto_total_cliente;


-- 10. avanzado - vista de productos más vendidos: construir una vista que sume las cantidades
-- totales vendidas por cada producto ordenadas de mayor a menor.
create view vw_productos_mas_vendidos as
select
p.nombre_producto as producto,
sum(d.cantidad) as unidades_vendidas
from productos p
inner join detalle_ventas d on d.id_producto=p.id_producto
group by p.id_producto,p.nombre_producto
order by unidades_vendidas desc;
select * from vw_productos_mas_vendidos;


-- 11. avanzado - vista de sucursales y dinero recaudado: hacer una vista que agrupe las ventas
-- totales por la sucursal del vendedor.
create view vw_ventas_por_sucursal as
select
v.sucursal,
sum(vt.total_venta) as dinero_recaudado
from vendedores v
inner join ventas vt on vt.id_vendedor=v.id_vendedor
group by v.sucursal
order by dinero_recaudado desc;
select * from vw_ventas_por_sucursal;


-- 12. avanzado - vista de transacciones de alto valor: crear una vista que filtre exclusivamente
-- aquellas ventas cuyo monto total supere los 300000.00.
create view vw_ventas_alto_valor as
select
vt.id_venta,
vt.fecha_venta,
c.nombre_completo as cliente,
v.nombre_completo as vendedor,
vt.total_venta
from ventas vt
inner join clientes c on c.id_cliente=vt.id_cliente
inner join vendedores v on v.id_vendedor=vt.id_vendedor
where vt.total_venta > 300000.00;
select * from vw_ventas_alto_valor;


-- 13. avanzado - vista con filtrado de fechas estáticas: diseñar una vista que muestre las ventas
-- registradas únicamente entre el '2026-09-01' y el '2026-09-05'.
create view vw_ventas_septiembre_01_05 as
select
vt.id_venta,
vt.fecha_venta,
c.nombre_completo as cliente,
vt.total_venta
from ventas vt
inner join clientes c on c.id_cliente=vt.id_cliente
where date(vt.fecha_venta) between '2026-09-01' and '2026-09-05';
select * from vw_ventas_septiembre_01_05;


