USE NEO_GENESIS
GO
ALTER TABLE ORDEN_MTTO
ALTER COLUMN tipo_servicio CHAR(20) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN refacciones VARCHAR(30) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN falla_corregida CHAR(2) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN tiempo_invertido VARCHAR(20) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion2 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion3 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion4 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN diagnostico_falla NVARCHAR(600) NULL;

--ALTER TABLE ORDEN_MTTO
--DROP CONSTRAINT FK__ORDEN_MTT__id_em__442B18F2;

--ALTER TABLE ORDEN_MTTO
--ALTER COLUMN id_solicitud INT NULL;


--ALTER TABLE ORDEN_MTTO
--ALTER COLUMN id_empleado INT NULL;

--ALTER TABLE ORDEN_MTTO
--DROP CONSTRAINT FK__ORDEN_MTT__id_so__43F60EC8;



--SELECT 
--    fk.name AS ForeignKeyName,
--    tp.name AS TableName,
--    cp.name AS ColumnName,
--    rt.name AS ReferencedTableName,
--    rcp.name AS ReferencedColumnName
--FROM sys.foreign_keys AS fk
--INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
--INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
--INNER JOIN sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
--INNER JOIN sys.tables AS rt ON fk.referenced_object_id = rt.object_id
--INNER JOIN sys.columns AS rcp ON fkc.referenced_object_id = rcp.object_id AND fkc.referenced_column_id = rcp.column_id
--WHERE tp.name = 'ORDEN_MTTO';
