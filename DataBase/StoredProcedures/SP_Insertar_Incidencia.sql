  
-- Creación del nuevo stored procedure para insertar en la tabla de incidencias  
CREATE PROCEDURE SP_Insertar_Incidencia  
    @id_empleado INT,  
    @tipo_registro VARCHAR(50),  
    @tipo_incidencia VARCHAR(50),  
    @tiempo_sancion VARCHAR(50),  
    @descuento_dia CHAR(5),  
    @dia VARCHAR(10),  
    @fecha_inicio CHAR(10),  
    @descripcion NVARCHAR(MAX),  
    @goze CHAR(1),  
    @horas CHAR(5),  
    @id_usuario INT  
AS  
BEGIN  
    DECLARE @NuevoID INT;  
    DECLARE @folio_incidencia CHAR(20);  
    DECLARE @Estatus_Revision INT = (SELECT ID_Estatus FROM Estatus E   
                                     INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus  
                                     WHERE TE.TipoEstatus = 'Incidencias' AND E.Estatus = 'EN REVISION');  
  
    DECLARE @IdUbicacion INT = (SELECT E.id_ubicacion FROM USUARIO U  
        INNER JOIN EMPLEADO E ON U.id_empleado = E.id_empleado  
        WHERE U.id_usuario = @id_usuario);  
  
  -- Obtener el próximo valor del id_incidencia (esto asume que id_incidencia es autoincremental)     SELECT @NuevoID = ISNULL(MAX(id_incidencia), 0) + 1 FROM INCIDENCIA;      -- Generar el folio_incidencia basado en el nuevo ID     SET @folio_incidencia 
= 'INC-' + CAST(@NuevoID AS CHAR(10));  
  
    -- Insertamos los datos con la fecha y hora calculadas en el procedimiento  
    INSERT INTO INCIDENCIA(  
  folio_incidencia,  
        hora_registro, -- Solo la hora  
        fecha_registro, -- Solo la fecha  
        id_ubicacion,  
        id_empleado,  
        tipo_registro,  
        tipo_incidencia,  
        tiempo_sancion,  
        descuento_dia,  
        dia,  
        fecha_inicio,  
        descripcion,  
        goze,  
        horas,  
        id_usuario,  
        ID_Estatus  
    )  
    VALUES (  
  @folio_incidencia,  
        CONVERT(CHAR(5), GETDATE(), 108), -- Solo la hora (HH:MM formato 24 horas)  
        CONVERT(DATE, GETDATE()), -- Solo la fecha  
        @IdUbicacion,  
        @id_empleado,  
        @tipo_registro,  
        @tipo_incidencia,  
        @tiempo_sancion,  
        @descuento_dia,  
        @dia,  
        @fecha_inicio,  
        @descripcion,  
        @goze,  
        @horas,  
        @id_usuario,  
        @Estatus_Revision  
    );  
END  