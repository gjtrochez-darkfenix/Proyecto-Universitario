USE bufete_legal_db_v2;

SELECT
	id_usuario as "ID Usuario",
    nombre as "Nombre",
    rol "Rol",
    correo as "Correo"
FROM
	usuario;

SELECT
	id_cliente as "Cliente",
    nombre as "Nombre",
    numero_identidad as "Numero de identidad",
    telefono as "Telefono",
    correo as "correo",
    direccion as "Dirección"
FROM
	cliente;
        
SELECT
    c.id_caso AS "ID Caso",
    c.fecha_inicio AS "Inicio",
    c.estado AS "Estado",
    c.descripcion AS "Descripción del Caso",
    u.nombre AS "Abogado Asignado",
    cl.nombre AS "Nombre del Cliente"
FROM
    caso c
JOIN
    usuario u ON c.id_usuario = u.id_usuario
JOIN
    cliente cl ON c.id_cliente = cl.id_cliente -- Unión con la tabla cliente
ORDER BY
    c.id_caso;

SELECT
	d.id_documento as "ID Documento",
    d.tipo as "Tipo",
    d.fecha as "Fecha",
    d.fecha_limite as "Fecha Limite",
    d.id_caso as "ID Caso",
    d.monto as "Monto",
    c.descripcion as "Caso"
FROM
	documento d
INNER JOIN
	caso c on d.id_caso = c.id_caso;

SELECT
    f.id_factura as "ID Factura", 
    f.monto as "Monto",
    f.fecha_emision as "Fecha de emision",
    f.estado_pago as "Estado de Pago",
    f.id_caso as "ID Caso",
    c.descripcion as "Caso"
FROM
    factura f
INNER JOIN 
	caso c on f.id_caso = c.id_caso;
	
SELECT
	go.id_gasto as "ID Gastos",
    go.fecha as "Fecha",
    go.descripcion as "Descripción",
    go.monto as "Monto",
    go.id_caso as "ID Caso",
    c.descripcion as "Nombre del caso"
FROM
	gasto_operacional go
 INNER JOIN	
	caso c on go.id_caso = c.id_caso;
    
SELECT
    c.id_caso AS "ID Caso",
    c.descripcion AS "Caso",
    c.fecha_inicio AS "Inicio",
    MAX(ultima_actividad) AS "Última Actividad Registrada"
FROM
    caso c
JOIN
    (
        -- Subconsulta para encontrar la fecha más reciente de cualquier actividad (documento o gasto)
        SELECT id_caso, fecha AS ultima_actividad FROM documento
        UNION ALL
        SELECT id_caso, fecha AS ultima_actividad FROM gasto_operacional
    ) AS actividad ON c.id_caso = actividad.id_caso
WHERE
    c.estado = 'en proceso'
GROUP BY
    c.id_caso, c.descripcion, c.fecha_inicio
HAVING
    -- La excepción: la última actividad fue hace más de 60 días
    MAX(ultima_actividad) < DATE_SUB(CURDATE(), INTERVAL 60 DAY)
ORDER BY
    "Última Actividad Registrada" ASC;
    
SELECT
    c.id_caso AS "ID Caso",
    c.descripcion AS "Caso",
    d.tipo AS "Documento Requerido",
    d.fecha_limite AS "Fecha Límite",
    DATEDIFF(d.fecha_limite, CURDATE()) AS "Días Restantes"
FROM
    documento d
JOIN
    caso c ON d.id_caso = c.id_caso
WHERE
    d.fecha_limite IS NOT NULL -- Solo documentos con plazo definido
    -- La excepción: la fecha límite es anterior a hoy (VENCIDO) O está dentro de los próximos 7 días
    AND DATEDIFF(d.fecha_limite, CURDATE()) <= 7
    AND c.estado = 'en proceso' -- Solo casos activos
ORDER BY
    "Fecha Límite" ASC;






    

