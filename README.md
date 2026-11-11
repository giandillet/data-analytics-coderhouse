# data-analytics-coderhouse

# RetailPro

Proyecto de análisis de datos de una distribuidora de tecnología. Su pregunta
de negocio es: las ventas de productos importados cayeron frente al año
anterior, ¿cómo se comportaron los nacionales y en qué territorios es mayor
la brecha?

El repositorio contiene el modelo relacional (Ventas_Tech_DB), las consultas
SQL y el boceto del dashboard. Usa un conjunto de datos de prueba pequeño,
no datos reales de producción.

## Herramientas
- SQL Server y SSMS (T-SQL)
- Power BI (dashboard, en etapa de diseño)
- Git y GitHub

## Modelo de datos
Tablas: clientes, productos, categorias, ventas y territorios.
Columnas clave: productos.origen (Nacional/Importado) y ventas.canal
(Online/Presencial).

## Cómo ejecutar los scripts
1. Abrí SSMS y conectate a tu instancia de SQL Server.
2. Ejecutá el script de creación de Ventas_Tech_DB [nombre real del archivo].
3. Ejecutá el script de ampliación con territorios, origen y canal
   [nombre real del archivo].
4. Ejecutá `m5_consultas_joins.sql` para las consultas de JOIN y UNION ALL.

## IA utilizada en Entregable 9: Claude
