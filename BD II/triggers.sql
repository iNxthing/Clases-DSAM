SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS db_megastore;

CREATE DATABASE db_megastore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE db_megastore;

-- 1. Tabla de Categorías

CREATE TABLE categorias (

    id_categoria INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    pasillo INT NOT NULL

) ENGINE=InnoDB;

-- 2. Tabla de Productos

CREATE TABLE productos (

    id_producto INT AUTO_INCREMENT PRIMARY KEY,

    codigo_barras VARCHAR(20) UNIQUE NOT NULL,

    nombre VARCHAR(100) NOT NULL,

    id_categoria INT NOT NULL,

    precio_costo DECIMAL(10, 2) NOT NULL,

    precio_venta DECIMAL(10, 2) NOT NULL,

    stock_actual INT NOT NULL DEFAULT 0,

    stock_minimo INT NOT NULL DEFAULT 5,

    estado ENUM('Activo', 'Descontinuado', 'Agotado') DEFAULT 'Activo',

    CONSTRAINT fk_prod_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)

) ENGINE=InnoDB;

-- 3. Tabla de Clientes

CREATE TABLE clientes (

    id_cliente INT AUTO_INCREMENT PRIMARY KEY,

    documento VARCHAR(20) UNIQUE NOT NULL,

    nombre_completo VARCHAR(100) NOT NULL,

    email VARCHAR(100),

    puntos_fidelidad INT DEFAULT 0,

    categoria_cliente ENUM('Bronce', 'Plata', 'Oro', 'VIP') DEFAULT 'Bronce'

) ENGINE=InnoDB;

-- 4. Tabla de Empleados

CREATE TABLE empleados (

    id_empleado INT AUTO_INCREMENT PRIMARY KEY,

    documento VARCHAR(20) UNIQUE NOT NULL,

    nombre_completo VARCHAR(100) NOT NULL,

    cargo ENUM('Cajero', 'Supervisor', 'Bodeguero', 'Gerente') NOT NULL,

    salario DECIMAL(10, 2) NOT NULL,

    comision_acumulada DECIMAL(10, 2) DEFAULT 0.00,

    activo TINYINT(1) DEFAULT 1

) ENGINE=InnoDB;

-- 5. Tabla de Encabezado de Ventas

CREATE TABLE ventas (

    id_venta INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,

    id_empleado INT NOT NULL,

    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,

    total_venta DECIMAL(12, 2) DEFAULT 0.00,

    estado_venta ENUM('Abierta', 'Pagada', 'Anulada') DEFAULT 'Abierta',

    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),

    CONSTRAINT fk_venta_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)

) ENGINE=InnoDB;

-- 6. Tabla de Detalle de Ventas

CREATE TABLE detalle_ventas (

    id_detalle INT AUTO_INCREMENT PRIMARY KEY,

    id_venta INT NOT NULL,

    id_producto INT NOT NULL,

    cantidad INT NOT NULL,

    precio_unitario DECIMAL(10, 2) NOT NULL DEFAULT 0.00,

    subtotal DECIMAL(12, 2) NOT NULL DEFAULT 0.00,

    CONSTRAINT fk_det_venta FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),

    CONSTRAINT fk_det_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)

) ENGINE=InnoDB;

-- 7. Tabla de Auditoría de Precios

CREATE TABLE auditoria_precios (

    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,

    id_producto INT NOT NULL,

    precio_anterior DECIMAL(10, 2) NOT NULL,

    precio_nuevo DECIMAL(10, 2) NOT NULL,

    usuario_db VARCHAR(100) NOT NULL,

    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP

) ENGINE=InnoDB;

-- 8. Tabla de Alertas de Reabastecimiento

CREATE TABLE alertas_inventario (

    id_alerta INT AUTO_INCREMENT PRIMARY KEY,

    id_producto INT NOT NULL,

    stock_registrado INT NOT NULL,

    mensaje VARCHAR(255) NOT NULL,

    fecha_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,

    atendida TINYINT(1) DEFAULT 0

) ENGINE=InnoDB;


INSERT INTO categorias (nombre, pasillo) VALUES

('Tecnología y Electrodomésticos', 1),

('Mercado y Despensa', 2),

('Licores y Bebidas', 3),

('Hogar y Mobiliario', 4);

INSERT INTO productos (codigo_barras, nombre, id_categoria, precio_costo, precio_venta, stock_actual, stock_minimo) VALUES

('7701001', 'Televisor Smart TV 55 Pulgadas 4K', 1, 1200000.00, 1850000.00, 15, 3),

('7701002', 'Consola PlayStation 5 Slim', 1, 1800000.00, 2450000.00, 8, 2),

('7702001', 'Arroz Premium Bolsa 5Kg', 2, 14000.00, 21500.00, 120, 20),

('7702002', 'Aceite de Oliva Extra Virgen 1L', 2, 32000.00, 48000.00, 40, 10),

('7703001', 'Whisky Escocés 12 Años 750ml', 3, 95000.00, 145000.00, 25, 5),

('7704001', 'Silla Gamer Ergonómica Reclinable', 4, 420000.00, 680000.00, 6, 3);

INSERT INTO clientes (documento, nombre_completo, email, puntos_fidelidad, categoria_cliente) VALUES

('1082990111', 'Naruto Balvin Restrepo', 'naruto.balvin@email.com', 120, 'Bronce'),

('1082990222', 'Sakura Karol Giraldo', 'sakura.giraldo@email.com', 550, 'Plata'),

('1082990333', 'Levi Maluma Londoño', 'levi.londono@email.com', 1500, 'Oro'),

('1082990444', 'Mikasa Shakira Mebarak', 'mikasa.mebarak@email.com', 40, 'Bronce'),

('1082990555', 'Goku Feid Villada', 'goku.ferxxo@email.com', 3200, 'VIP');

INSERT INTO empleados (documento, nombre_completo, cargo, salario) VALUES

('85440111', 'Kakashi Daddy Yankee', 'Cajero', 1400000.00),

('85440222', 'Hinata Rosalía Tobón', 'Cajero', 1400000.00),

('85440333', 'Eren Don Omar Quintero', 'Supervisor', 2300000.00),

('85440444', 'Vegeta Nicky Jam Rivera', 'Bodeguero', 1500000.00);

INSERT INTO ventas (id_cliente, id_empleado, total_venta, estado_venta) VALUES

(1, 1, 0.00, 'Abierta'),

(3, 2, 0.00, 'Abierta');

DROP TRIGGER IF EXISTS trg_bi_validar_y_calcular_detalle;

DELIMITER //

CREATE TRIGGER trg_bi_validar_y_calcular_detalle

BEFORE INSERT ON detalle_ventas

FOR EACH ROW

BEGIN

    DECLARE v_stock INT;

    DECLARE v_precio DECIMAL(10,2);

    SELECT stock_actual, precio_venta 

    INTO v_stock, v_precio

    FROM productos 

    WHERE id_producto = NEW.id_producto;

    IF NEW.cantidad > v_stock THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Error Transaccional: Stock insuficiente para realizar la venta.';

    END IF;

    SET NEW.precio_unitario = v_precio;

    SET NEW.subtotal = NEW.cantidad * v_precio;

END //

DELIMITER ;

DROP TRIGGER IF EXISTS trg_ai_actualizar_stock_y_venta;

DELIMITER //

CREATE TRIGGER trg_ai_actualizar_stock_y_venta

AFTER INSERT ON detalle_ventas

FOR EACH ROW

BEGIN

    UPDATE productos 

    SET stock_actual = stock_actual - NEW.cantidad

    WHERE id_producto = NEW.id_producto;

    UPDATE ventas 

    SET total_venta = total_venta + NEW.subtotal

    WHERE id_venta = NEW.id_venta;

END //
DELIMITER ;

-- Trigger existente: registrar cambios en los precios de venta.
DROP TRIGGER IF EXISTS trg_au_auditoria_precios;
DELIMITER //
CREATE TRIGGER trg_au_auditoria_precios
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio_venta <> NEW.precio_venta THEN
        INSERT INTO auditoria_precios (id_producto, precio_anterior, precio_nuevo, usuario_db)
        VALUES (NEW.id_producto, OLD.precio_venta, NEW.precio_venta, CURRENT_USER());
    END IF;
END //
DELIMITER ;

-- DESAFÍO 1: impedir que el precio de venta sea menor al costo.
DROP TRIGGER IF EXISTS trg_bu_evitar_venta_perdida;
DELIMITER //
CREATE TRIGGER trg_bu_evitar_venta_perdida
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio_venta < NEW.precio_costo THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El precio de venta no puede ser menor al costo.';
    END IF;
END //
DELIMITER ;

-- DESAFÍO 2: normalizar datos del cliente y corregir puntos negativos.
DROP TRIGGER IF EXISTS trg_bi_formatear_cliente;
DELIMITER //
CREATE TRIGGER trg_bi_formatear_cliente
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    SET NEW.nombre_completo = UPPER(NEW.nombre_completo);
    SET NEW.email = LOWER(NEW.email);

    IF NEW.puntos_fidelidad < 0 THEN
        SET NEW.puntos_fidelidad = 0;
    END IF;
END //
DELIMITER ;

-- DESAFÍO 3: aceptar detalles solo con cantidad positiva y venta abierta.
-- MySQL 8.0 permite este trigger junto al trigger de cálculo existente.
DROP TRIGGER IF EXISTS trg_bi_validar_item_venta;
DELIMITER //
CREATE TRIGGER trg_bi_validar_item_venta
BEFORE INSERT ON detalle_ventas
FOR EACH ROW
BEGIN
    DECLARE v_estado_venta VARCHAR(20) DEFAULT NULL;

    IF NEW.cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La cantidad del producto debe ser mayor a cero.';
    END IF;

    SELECT estado_venta
    INTO v_estado_venta
    FROM ventas
    WHERE id_venta = NEW.id_venta;

    IF v_estado_venta IS NULL OR v_estado_venta <> 'Abierta' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Solo se pueden agregar productos a una factura Abierta.';
    END IF;
END //
DELIMITER ;

-- DESAFÍO 4: crear una alerta al cruzar el umbral mínimo de inventario.
DROP TRIGGER IF EXISTS trg_au_alerta_stock_bajo;
DELIMITER //
CREATE TRIGGER trg_au_alerta_stock_bajo
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.stock_actual <= NEW.stock_minimo
       AND OLD.stock_actual > OLD.stock_minimo THEN
        INSERT INTO alertas_inventario (id_producto, stock_registrado, mensaje)
        VALUES (
            NEW.id_producto,
            NEW.stock_actual,
            'Urgente: Solicitar pedido a proveedor'
        );
    END IF;
END //
DELIMITER ;

-- DESAFÍO 5: cambiar automáticamente el estado según las existencias.
DROP TRIGGER IF EXISTS trg_bu_estado_agotado;
DELIMITER //
CREATE TRIGGER trg_bu_estado_agotado
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.stock_actual = 0 THEN
        SET NEW.estado = 'Agotado';
    ELSEIF NEW.stock_actual > 0 AND OLD.estado = 'Agotado' THEN
        SET NEW.estado = 'Activo';
    END IF;
END //
DELIMITER ;

-- DESAFÍO 6: devolver stock y descontar el subtotal al eliminar un detalle.
DROP TRIGGER IF EXISTS trg_ad_devolver_item_carrito;
DELIMITER //
CREATE TRIGGER trg_ad_devolver_item_carrito
AFTER DELETE ON detalle_ventas
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock_actual = stock_actual + OLD.cantidad
    WHERE id_producto = OLD.id_producto;

    UPDATE ventas
    SET total_venta = total_venta - OLD.subtotal
    WHERE id_venta = OLD.id_venta;
END //
DELIMITER ;

-- DESAFÍO 7: sumar puntos y actualizar la categoría al pagar una factura.
DROP TRIGGER IF EXISTS trg_au_fidelizacion_cliente;
DELIMITER //
CREATE TRIGGER trg_au_fidelizacion_cliente
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
    DECLARE v_puntos INT;

    IF OLD.estado_venta = 'Abierta' AND NEW.estado_venta = 'Pagada' THEN
        SET v_puntos = FLOOR(NEW.total_venta / 10000);

        UPDATE clientes
        SET puntos_fidelidad = puntos_fidelidad + v_puntos
        WHERE id_cliente = NEW.id_cliente;

        UPDATE clientes
        SET categoria_cliente = CASE
            WHEN puntos_fidelidad > 3000 THEN 'VIP'
            WHEN puntos_fidelidad > 1500 THEN 'Oro'
            WHEN puntos_fidelidad > 500 THEN 'Plata'
            ELSE 'Bronce'
        END
        WHERE id_cliente = NEW.id_cliente;
    END IF;
END //
DELIMITER ;

-- DESAFÍO 8: sumar el 1.5% de comisión al empleado al pagar una factura.
DROP TRIGGER IF EXISTS trg_au_comision_empleado;
DELIMITER //
CREATE TRIGGER trg_au_comision_empleado
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
    IF OLD.estado_venta = 'Abierta' AND NEW.estado_venta = 'Pagada' THEN
        UPDATE empleados
        SET comision_acumulada = comision_acumulada + (NEW.total_venta * 0.015)
        WHERE id_empleado = NEW.id_empleado;
    END IF;
END //
DELIMITER ;

-- DESAFÍO 9: revertir puntos y comisión cuando se anula una venta pagada.
DROP TRIGGER IF EXISTS trg_au_anular_factura;
DELIMITER //
CREATE TRIGGER trg_au_anular_factura
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
    IF OLD.estado_venta = 'Pagada' AND NEW.estado_venta = 'Anulada' THEN
        UPDATE empleados
        SET comision_acumulada = comision_acumulada - (OLD.total_venta * 0.015)
        WHERE id_empleado = OLD.id_empleado;

        UPDATE clientes
        SET puntos_fidelidad = puntos_fidelidad - FLOOR(OLD.total_venta / 10000)
        WHERE id_cliente = OLD.id_cliente;

        UPDATE clientes
        SET categoria_cliente = CASE
            WHEN puntos_fidelidad > 3000 THEN 'VIP'
            WHEN puntos_fidelidad > 1500 THEN 'Oro'
            WHEN puntos_fidelidad > 500 THEN 'Plata'
            ELSE 'Bronce'
        END
        WHERE id_cliente = OLD.id_cliente;
    END IF;
END //
DELIMITER ;

-- DESAFÍO 10: impedir el borrado físico de facturas cerradas.
DROP TRIGGER IF EXISTS trg_bd_proteger_facturas;
DELIMITER //
CREATE TRIGGER trg_bd_proteger_facturas
BEFORE DELETE ON ventas
FOR EACH ROW
BEGIN
    IF OLD.estado_venta IN ('Pagada', 'Anulada') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Prohibido eliminar facturas cerradas. Utilice el estado Anulada.';
    END IF;
END //
DELIMITER ;

-- PRUEBAS MANUALES
-- Ejecutar cada prueba por separado después de crear esquema y triggers.
-- Las consultas marcadas "ERROR esperado" deben producir SQLSTATE 45000.

-- 1. ERROR esperado: no permite vender por debajo del costo.
-- UPDATE productos SET precio_venta = precio_costo - 1 WHERE id_producto = 1;

-- 2. Debe guardar el nombre en mayúsculas, el correo en minúsculas y puntos en 0.
-- INSERT INTO clientes (documento, nombre_completo, email, puntos_fidelidad)
-- VALUES ('9990000001', 'Cliente De Prueba', 'PRUEBA@EMAIL.COM', -5);
-- SELECT nombre_completo, email, puntos_fidelidad
-- FROM clientes WHERE documento = '9990000001';

-- 3. ERROR esperado: la cantidad debe ser mayor a cero.
-- INSERT INTO detalle_ventas (id_venta, id_producto, cantidad)
-- VALUES (1, 6, 0);
-- Precondición: venta 1 Pagada. ERROR esperado: la factura no está abierta.
-- INSERT INTO detalle_ventas (id_venta, id_producto, cantidad) VALUES (1, 6, 1);

-- 4. Debe crear una alerta al bajar el producto hasta su mínimo.
-- UPDATE productos SET stock_actual = stock_minimo WHERE id_producto = 6;
-- SELECT * FROM alertas_inventario
-- WHERE id_producto = 6 ORDER BY id_alerta DESC LIMIT 1;

-- 5. Debe cambiar a Agotado y luego volver a Activo.
-- UPDATE productos SET stock_actual = 0 WHERE id_producto = 6;
-- SELECT estado FROM productos WHERE id_producto = 6;
-- UPDATE productos SET stock_actual = 2 WHERE id_producto = 6;
-- SELECT estado FROM productos WHERE id_producto = 6;

-- 6. Debe devolver el stock y restar el subtotal de la venta.
-- INSERT INTO detalle_ventas (id_venta, id_producto, cantidad) VALUES (1, 6, 1);
-- SET @id_detalle_prueba = LAST_INSERT_ID();
-- DELETE FROM detalle_ventas WHERE id_detalle = @id_detalle_prueba;

-- 7. Debe sumar puntos y actualizar categoría al pagar la venta 1.
-- UPDATE ventas SET total_venta = 25000, estado_venta = 'Pagada'
-- WHERE id_venta = 1 AND estado_venta = 'Abierta';
-- SELECT puntos_fidelidad, categoria_cliente FROM clientes WHERE id_cliente = 1;

-- 8. Debe sumar la comisión al pagar la venta 2.
-- UPDATE ventas SET total_venta = 40000, estado_venta = 'Pagada'
-- WHERE id_venta = 2 AND estado_venta = 'Abierta';
-- SELECT comision_acumulada FROM empleados WHERE id_empleado = 2;

-- 9. Precondición: venta 1 pagada. Debe revertir puntos y comisión.
-- UPDATE ventas SET estado_venta = 'Anulada'
-- WHERE id_venta = 1 AND estado_venta = 'Pagada';
-- SELECT puntos_fidelidad FROM clientes WHERE id_cliente = 1;
-- SELECT categoria_cliente FROM clientes WHERE id_cliente = 1;
-- SELECT comision_acumulada FROM empleados WHERE id_empleado = 1;

-- 10. ERROR esperado: no permite eliminar una factura cerrada.
-- DELETE FROM ventas WHERE id_venta = 1 AND estado_venta IN ('Pagada', 'Anulada');

-- Diagnóstico de triggers en MySQL Workbench:
-- SHOW TRIGGERS FROM db_megastore;
-- SHOW CREATE TRIGGER trg_bu_evitar_venta_perdida;
