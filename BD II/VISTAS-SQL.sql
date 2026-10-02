
drop database if exists db_ventas_ropa;
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

DELIMITER //
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
WHERE p.stock <= 30;//

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
('Ñejo L Lawliet', 'Santa Marta', '3145554433');

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


/* Básico - Vista de Clientes por Ciudad: Crear una vista llamada
 vw_clientes_santamarta que muestre únicamente el nombre completo
 y teléfono de los clientes que residen en 'Santa Marta'.*/
 
DELIMITER //
CREATE VIEW vw_clientes_santamarta As
Select c.nombre_completo , c.telefono ,c.ciudad from clientes c where c.ciudad="Santa Marta";
//

select * from vw_clientes_santamarta;

/* Básico - Vista de Catálogo Accesible: Crear una vista
 llamada vw_catalogo_economico que liste los productos
 cuyo precio sea menor a 100000.00.*/
CREATE VIEW vw_catalogo_economico AS
Select p.nombre_producto,p.precio from productos p where p.precio<= 100000.00;

//

select * from vw_catalogo_economico;


/* 
Básico - Vista de Vendedores por Sucursal: Diseñar una vista que filtre
 a los vendedores que laboran en la sucursal de 'Centro Comercial Santa Marta'.
*/

CREATE VIEW vw_Vendedores_Surcursal As
select v.nombre_completo,v.sucursal from vendedores v where v.sucursal="Centro Comercial Santa Marta";
//

select * from vw_Vendedores_Surcursal;





