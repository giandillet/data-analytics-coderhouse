--Modificaciones en la DB en el README del repositorio

-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: mostrar en una sola fila toda la información de cada venta 

SELECT v.fecha_venta as Fecha_venta,
	   t.region as Territorio,
	   c.id_cliente as id_cliente,
	   c.nombre as Nombre_Cliente,
	   p.nombre_producto as Nombre_producto,
	   cat.nombre_Categoria as Categoria,
	   p.origen as Origen,
	   v.cantidad as Cantidad,
	   v.precio_unitario as Precio_unitario,
	   v.cantidad*v.precio_unitario as Total_de_venta,
	   v.canal as Canal_Venta
FROM ventas v INNER JOIN clientes c ON v.id_cliente = c.id_cliente
			  INNER JOIN productos p ON v.id_producto = p.id_producto
			  INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
			  INNER JOIN territorios t ON v.id_territorio = t.id_territorio;

-- Hallazgo: la vista devuelve las 10 ventas registradas, sin pérdidas por los JOINs.
-- La región Norte concentra la mayor facturación (2760 de 6444, cerca del 43%).


-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: identificar clientes registrados que aún no realizaron ninguna compra,
-- para que el área de CRM pueda contactarlos.

SELECT c.nombre AS Nombre, c.email AS Email, c.fecha_registro AS Fecha_Registro
FROM clientes c LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: 2 de los 7 clientes registrados nunca compraron: Diego Fernández y Sofía Díaz.
-- Ambos se registraron después de la última venta, así que son clientes nuevos y no perdidos:
-- CRM podría ofrecerles un descuento de bienvenida en su primera compra.


-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: identificar productos del catálogo que no tienen movimiento,
-- para que el área de producto decida qué hacer con ellos.

SELECT p.nombre_producto AS Nombre_producto, c.nombre_Categoria AS Categoria, p.precio AS Precio
FROM productos p LEFT JOIN ventas v ON p.id_producto = v.id_producto
				 INNER JOIN categorias c ON c.id_categoria = p.id_categoria
WHERE v.id_venta IS NULL;

-- Hallazgo: 4 de los 10 productos del catálogo no tienen ventas; los 4 son de precio bajo (entre 35 y 85) y 2 son de Accesorios. 

-- Consulta 4 — Consolidado por rango de precio (UNION ALL)
-- Propósito: comparar la facturación de los productos "caros" y "baratos". El corte es 300 por
-- precio unitario: separa la gama alta (Laptop y Monitor) de los accesorios y periféricos.

SELECT rango_precio, SUM(total) AS total_rango
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Caro' AS rango_precio
    FROM ventas WHERE precio_unitario > 300
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Barato' AS rango_precio
    FROM ventas WHERE precio_unitario <= 300
) AS consolidado
GROUP BY rango_precio;

-- Hallazgo: los productos caros sumaron 4950 y los baratos 1494 (más de 3 veces). Con solo 4 de las
-- 10 ventas, los caros aportan cerca del 77% de la facturación: el negocio depende de pocas ventas grandes.
