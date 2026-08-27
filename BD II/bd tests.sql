-- 1. Creación de la base de datos
DROP DATABASE IF EXISTS ventas_db;
CREATE DATABASE ventas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ventas_db;

-- 2. Tabla de Categorías
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);

-- 3. Tabla de Productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 4. Tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

-- 5. Tabla de Vendedores
CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_vendedor VARCHAR(100) NOT NULL,
    sucursal VARCHAR(50) NOT NULL
);

-- 6. Tabla de Ventas (Encabezado)
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

-- 7. Tabla Detalle de Ventas
CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
-- Categorías
INSERT INTO categorias (nombre_categoria) VALUES 
('Tecnología'), 
('Electrodomésticos'), 
('Mobiliario');

-- Productos
INSERT INTO productos (nombre_producto, precio_unitario, id_categoria) VALUES 
('Laptop Pro 15', 1200.00, 1),
('Mouse Inalámbrico', 25.00, 1),
('Teclado Mecánico', 80.00, 1),
('Monitor 27 Pulgadas', 300.00, 1),
('Nevera No Frost', 900.00, 2),
('Lavadora 18kg', 750.00, 2),
('Microondas 30L', 150.00, 2),
('Escritorio Ergonómico', 220.00, 3),
('Silla de Oficina', 180.00, 3);

-- Clientes
INSERT INTO clientes (nombre_cliente, ciudad) VALUES 
('Carlos Martínez', 'Bogotá'),
('Ana Morales', 'Medellín'),
('Luisa Fernanda Gómez', 'Cali'),
('Jorge Restrepo', 'Barranquilla'),
('Sofía Vergara', 'Santa Marta');

-- Vendedores
INSERT INTO vendedores (nombre_vendedor, sucursal) VALUES 
('David Ospina', 'Norte'),
('María Camila Osorio', 'Centro'),
('Andrés Cepeda', 'Sur');

-- Ventas (Encabezados)
INSERT INTO ventas (fecha, id_cliente, id_vendedor) VALUES 
('2026-01-10', 1, 1), -- Venta 1
('2026-01-15', 2, 2), -- Venta 2
('2026-01-20', 3, 1), -- Venta 3
('2026-02-05', 4, 3), -- Venta 4
('2026-02-12', 1, 2), -- Venta 5
('2026-02-18', 5, 1), -- Venta 6
('2026-03-01', 2, 3), -- Venta 7
('2026-03-10', 3, 2); -- Venta 8

-- Detalle de Ventas
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_venta) VALUES 
(1, 1, 1, 1200.00),
(1, 2, 2, 25.00),
(2, 5, 1, 900.00),
(2, 7, 1, 150.00),
(3, 8, 2, 220.00),
(3, 9, 2, 180.00),
(4, 3, 3, 80.00),
(4, 4, 1, 300.00),
(5, 1, 2, 1200.00),
(6, 6, 1, 750.00),
(6, 7, 2, 150.00),
(7, 2, 5, 25.00),
(7, 4, 2, 300.00),
(8, 8, 1, 220.00),
(8, 1, 1, 1200.00);

/* ¿Cuál es el total de unidades vendidas
 y el ingreso total acumulado generado por cada producto,
 ordenado de mayor a menor según los ingresos?*/
 
 select p.nombre_producto 'Producto',  
 sum(dv.cantidad) 'Cantidad Vendida', 
 dv.precio_venta 'Precio/u', 
 sum(dv.cantidad)*dv.precio_venta 'Total'
 from productos p inner join detalle_ventas dv 
 on dv.id_producto=p.id_producto
 group by p.nombre_producto,dv.precio_venta;


/* ¿Cuánto ha gastado en total
 cada cliente, cuál es el promedio monetario
 de sus compras por ítem y a qué ciudad pertenecen?*/
 
 select  c.nombre_cliente,
 sum(dv.cantidad)*dv.precio_venta,
 avg(dv.cantidad*precio_venta),
 c.ciudad
 from clientes c 
 inner join ventas v on v.id_cliente=c.id_cliente
 inner join detalle_ventas dv on dv.id_venta=v.id_venta
 inner join productos p on p.id_producto=dv.id_producto
 group by c.nombre_cliente, c.ciudad,dv.precio_venta;
 
 /* ¿Cuántas transacciones se han registrado, cuál es el
 precio promedio de venta y cuál es la recaudación total
 agrupada por cada categoría de productos?*/
 
 select ct.nombre_categoria 'Categoria',
 count(dv.id_detalle) 'Transacciones',
 avg(dv.cantidad*dv.precio_venta) 'Promedio',
 sum(dv.cantidad)*sum(dv.precio_venta) 'Total'
 
 from categorias ct 
 inner join productos p on p.id.categoria=ct.id_categoria
 inner join detalle_ventas dv on dv.id_producto=p.id_producto
 group by ct.nombre_categoria;
