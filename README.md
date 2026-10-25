# data-analytics-coderhouse


Entregable: m5_consultas_joins.sql, con cuatro consultas sobre la base Ventas_Tech_DB del Módulo 3.

Cómo actualicé el esquema del Módulo 3

Para tener dimensiones de agrupación y filtrado, y datos que permitan probar los LEFT JOIN, amplié el modelo original (categorias, clientes, productos, ventas) con estos cambios:

Nueva tabla territorios (id_territorio, region) con Norte, Sur, Este y Oeste. Se relaciona con ventas mediante id_territorio (FOREIGN KEY), porque el territorio describe dónde ocurrió cada venta.
productos.origen: columna obligatoria (Nacional / Importado), controlada con un CHECK.
ventas.canal: columna obligatoria (Online / Presencial), controlada con un CHECK.
productos.id_categoria: pasó a NOT NULL, para que todo producto tenga categoría.
Datos de ejemplo nuevos: 2 clientes y 4 productos sin ventas (para las consultas 2 y 3).
