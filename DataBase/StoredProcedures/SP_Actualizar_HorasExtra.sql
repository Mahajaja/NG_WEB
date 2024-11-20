USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Actualizar_HorasExtra')
BEGIN
    DROP PROCEDURE SP_Actualizar_HorasExtra
END
GO

CREATE PROCEDURE [dbo].[SP_Actualizar_HorasExtra]
    @id_horaExtra INT,
    @id_empleado INT,
    @id_responsable INT,
    @fecha_compensacion DATE,
    @horas_porPagar INT,
    @motivo_hraExtra NVARCHAR(400),
    @observaciones NVARCHAR(400),
    @id_usuario INT,
    @Evidencia1 NVARCHAR(MAX) = NULL,
    @Evidencia2 NVARCHAR(MAX) = NULL
AS
BEGIN
    BEGIN TRY
			DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Horas_Extra') 

							     DECLARE @CostoHoraExtra FLOAT;
    DECLARE @CostoHoraDoble FLOAT;
    DECLARE @CostoHoraTriple FLOAT;
    DECLARE @HoraTriple INT = 0;
    DECLARE @TotalHoraDoble FLOAT;
    DECLARE @TotalHoraTriple FLOAT = 0;
    DECLARE @TotalAPagar FLOAT;
    DECLARE @IDHoraExtra INT;
    DECLARE @FechaActual DATE = GETDATE();
    DECLARE @HoraActual TIME = CONVERT(TIME, GETDATE());

    -- Obtener el siguiente ID_HoraExtra
    SELECT @IDHoraExtra = ISNULL(MAX(id_horaExtra), 0) + 1 FROM HORAS_EXTRAS;


    -- Obtener el costo por hora del empleado
    SELECT @CostoHoraExtra = salario / 7 FROM EMPLEADO WHERE id_empleado = @id_empleado;


    -- Calcular el costo por hora doble
    IF @horas_porPagar <= 9
    BEGIN
        SET @CostoHoraDoble = @CostoHoraExtra * 2;
        SET @TotalHoraDoble = @CostoHoraDoble * @horas_porPagar;
        SET @TotalHoraTriple = 0;
    END
    ELSE
    BEGIN
        SET @CostoHoraDoble = @CostoHoraExtra * 2;
        SET @TotalHoraDoble = @CostoHoraDoble * 9;

        -- Calcular las horas triples
        SET @HoraTriple = @horas_porPagar - 9;
        SET @CostoHoraTriple = @CostoHoraExtra * 3;
        SET @TotalHoraTriple = @CostoHoraTriple * @HoraTriple;
    END

    -- Calcular el total a pagar
    SET @TotalAPagar = @TotalHoraDoble + @TotalHoraTriple;
        -- Validar si existe el registro con el ID proporcionado
        IF NOT EXISTS (SELECT 1 FROM [NEO_GENESIS].[dbo].[HORAS_EXTRAS] WHERE id_horaExtra = @id_horaExtra)
        BEGIN
            RAISERROR('No se encontró el registro con el ID proporcionado.', 16, 1)
            RETURN
        END

        -- Actualización del registro
        UPDATE [NEO_GENESIS].[dbo].[HORAS_EXTRAS]
        SET 
            id_empleado = @id_empleado,
            id_responsable = @id_responsable,
            fecha_compensacion = @fecha_compensacion,
            horas_porPagar = @horas_porPagar,
            motivo_hraExtra = @motivo_hraExtra,
            observaciones = @observaciones,
            id_usuario = @id_usuario,
			ID_Estatus = @ID_Estatus,
			costo_horaDoble = @CostoHoraDoble,
			costo_horaExtra = @CostoHoraExtra,
			total_aPagar = @TotalAPagar,
			costo_horaTriple = @CostoHoraTriple,
			total_horaTriple = @TotalHoraTriple,
			total_horaDoble = @TotalHoraDoble,
			hora_triple = @HoraTriple
        WHERE id_horaExtra = @id_horaExtra;

		 -- Evidencia 1
        IF @Evidencia1 IS NOT NULL
        BEGIN
            INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)
            VALUES (
                @id_horaExtra,
                @Evidencia1,
                (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),
                (
                    SELECT CAST(GETDATE() AS NVARCHAR(20)) + 
                    '_HORAS_EXTRAS_' + '.jpeg'
                    FROM TipoEvidencias 
                    WHERE TipoEvidencia = 'HORAS_EXTRAS'
                ),
                @id_usuario,
                GETDATE()
            );
        END

        -- Evidencia 2
        IF @Evidencia2 IS NOT NULL
        BEGIN
            INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)
            VALUES (
                @id_horaExtra,
                @Evidencia2,
                (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),
                (
                    SELECT CAST(GETDATE() AS NVARCHAR(20)) + 
                    '_HORAS_EXTRAS_' + '.jpeg'
                    FROM TipoEvidencias
                    WHERE TipoEvidencia = 'HORAS_EXTRAS'
                ),
                @id_usuario,
                GETDATE()
            );
        END


        -- Confirmación de éxito
        SELECT 'Registro actualizado exitosamente.' AS Mensaje;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
