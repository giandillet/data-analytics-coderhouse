--EXTRAYENDO MÉTRICAS CLAVE CON SQL

--Consulta 1 - Resumen ejecutivo mensual

SELECT YEAR(fecha_venta) AS Anio ,MONTH(fecha_Venta) AS Mes,SUM(cantidad * precio_unitario) AS Total_Facturado, COUNT(id_venta) AS Cantidad_de_pedidos, CAST(AVG(cantidad * precio_unitario) AS DECIMAL(10,2)) AS Ticket_Promedio
FROM ventas
GROUP BY YEAR(fecha_venta),MONTH(fecha_venta)

--Utilice CAST en ticket promedio para que solo me muestre 2 decimales.

--Consulta 2 - Ranking de productos

SELECT TOP 5 id_producto AS Producto,SUM(cantidad) AS unidades_vendidas,SUM(cantidad*precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC

--Consulta 3 - Clientes recurrentes

SELECT id_cliente AS Cliente, COUNT(*) AS cantidad_de_pedidos, SUM(cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*)>1
ORDER BY total_gastado DESC

--agregue order by para determinar que cliente consumio mas


--Consulta 4 - Meses por encima/por debajo del promedio

SELECT YEAR(fecha_venta) AS Anio ,MONTH(fecha_Venta) AS Mes,
		CASE WHEN SUM(cantidad*precio_unitario) >
			(SELECT AVG(total_mes)
			 FROM (SELECT SUM(cantidad*precio_unitario) as total_mes 
				   FROM ventas 
				   GROUP BY YEAR(fecha_venta),MONTH(fecha_venta)) t) 
		THEN 'Por encima'
		ELSE 'Por debajo' END AS Comparativa
FROM ventas
GROUP BY YEAR(fecha_venta),MONTH(fecha_venta)

--El resultado de la consulta 4 da 'Por debajo porque al haber 1 mes con ventas da el mismo valor que el promedio.

--BLOQUE DE CIERRE

--El producto 2 es el más vendido en cantidad, sin embargo es el 2do producto que menos facturó debido a que su precio es bajo.
--El producto 1 facturó un total mayor al valor de la suma de los demas productos
--Entre 2 clientes facturan el 73% de la facturacion total (clientes 1 y 5)
