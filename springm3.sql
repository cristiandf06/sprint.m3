-- crear la base de datos telovendo
CREATE DATABASE telovendospring;

/*
-- crear el usuario y contraseña
CREATE USER 'admintienda'@'localhost' IDENTIFIED BY '123456';
-- conceder permisos de la base de datos al usuario admintienda
GRANT ALL PRIVILEGES ON telovendo.* TO 'admintienda'@'localhost';
*/

USE telovendospring;

-- creación de la tabla de proveedores con sus campos correspondientes
CREATE TABLE proveedor (
    id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_representante VARCHAR(255) NOT NULL,
    nombre_corporativo VARCHAR(255) NOT NULL,
    telefono1 VARCHAR(20) NOT NULL,
    telefono2 VARCHAR(20),
    nombre_contacto VARCHAR(255) NOT NULL,
    categoria_producto VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL
);

-- Agregar datos a la tabla de proveedor
INSERT INTO proveedor (nombre_representante, nombre_corporativo, telefono1, telefono2, nombre_contacto, categoria_producto, correo_electronico) 
VALUES 
('Juan Perez', 'Electronics Corp.', '9-1234-5678', '9-3456-7890', 'Pedro Sanchez', 'Electrónicos', 'juan@electronics.com'),
('Ana Lopez', 'Gadget Supply', '9-2345-6789', '9-3456-7890', 'Luis Ramirez', 'Electrónicos', 'ana@gadgets.com'),
('María Hernández', 'High Tech Inc.', '9-3456-7890', '9-3456-7890', 'Lorenzo Ortiz', 'Electrónicos', 'maria@hightech.com'),
('Pedro Martinez', 'Tech Gear', '9-4567-8901', '9-3456-7890', 'Carmen Garcia', 'Muebleria', 'pedro@techgear.com'),
('Sofía Gonzalez', 'Innovative Tech', '9-5678-9012', '9-3456-7890', 'Miguel Torres', 'Hogar', 'sofia@innovative.com');

-- creación de la tabla de clientes con sus campos correspondientes
CREATE TABLE cliente (
	id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_cliente VARCHAR(50) NOT NULL,
    apellido_cliente VARCHAR(50) NOT NULL,
    direccion_cliente VARCHAR(50) NOT NULL
);

-- Agregar datos a la tabla de cliente
INSERT INTO cliente (nombre_cliente, apellido_cliente, direccion_cliente)
VALUES
('Elva', 'Ginazo', '#12321'),
('Armando', 'Casa', '#14143'),
('Larry', 'Capija', '#4575446'),
('Lucho', 'Pay', '#344235'),
('Sevino', 'Sobretti','San Pedro');

-- creación de la tabla de producto con sus campos correspondientes
CREATE TABLE producto(
	id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stock_producto INT NOT NULL,
    precio_producto INT NOT NULL,
    categoria_producto VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL
);

-- Agregar datos a la tabla de producto
INSERT INTO producto (stock_producto, precio_producto, categoria_producto, color) 
VALUES 
(10, 5990, 'Computadoras', 'Negro'),
(20, 2990, 'Audífonos', 'Azul'),
(15, 7990, 'Teléfonos', 'Gris'),
(5, 14990, 'Televisores', 'Blanco'),
(30, 990, 'Televisores', 'Rojo'),
(25, 4990, 'Cámaras', 'Negro'),
(8, 12990, 'Drones', 'Gris'),
(12, 3990, 'Computadoras', 'Negro'),
(18, 1990, 'Impresoras', 'Blanco'),
(3, 1490, 'Computadoras', 'Azul');

-- Creación de la tabla intermedia para manejar la relación muchos-a-muchos entre productos y proveedores
CREATE TABLE producto_proveedor (
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor)
);

-- Agregar datos a la tabla de producto_proveedor
INSERT INTO producto_proveedor (id_producto, id_proveedor)
VALUES
(1, 1),(1, 3),(2, 2),(3, 4),(4, 1),(4, 2),(4, 3),(5, 5),(6, 1),(6, 4),(7, 3),(8, 5),(9, 2),(10, 1),(10, 4);

-- QUERYS

-- Cuál es la categoría de productos que más se repite.
SELECT categoria_producto, COUNT(*) AS cantidad
FROM producto
GROUP BY categoria_producto
ORDER BY cantidad DESC
LIMIT 1;

-- Cuáles son los productos con mayor stock
SELECT id_producto, stock_producto, precio_producto, categoria_producto, color
FROM producto
ORDER BY stock_producto DESC
LIMIT 1;

-- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(*) as cantidad
FROM producto
GROUP BY color
ORDER BY cantidad DESC
LIMIT 1;

-- Cual o cuales son los proveedores con menor stock de productos.
SELECT proveedor.nombre_corporativo, MIN(producto.stock_producto) as total_stock
FROM proveedor
JOIN producto_proveedor ON proveedor.id_proveedor = producto_proveedor.id_proveedor
JOIN producto ON producto_proveedor.id_producto = producto.id_producto
GROUP BY proveedor.nombre_corporativo
ORDER BY total_stock ASC
LIMIT 1;

-- consulatamos todas las filas con la categoria Computadoras en la tabla producto
SELECT id_producto FROM producto
WHERE categoria_producto = 'Computadoras';
-- Cambien la categoría de productos más popular por 'Electrónica y computación'.
UPDATE producto
SET categoria_producto = 'Electrónica y computación'
WHERE id_producto IN (1,8,10);


select * from proveedor;
select * from cliente;
select * from producto;
select * from producto_proveedor;