USE NEO_GENESIS
GO

IF OBJECT_ID('SP_Insertar_HorasExtra', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_Insertar_HorasExtra;
END
GO

CREATE PROCEDURE SP_Insertar_HorasExtra
    @IDEMPLEADO INT,
    @IDRESPONSABLE INT,
    @FechaCompensacion DATE,
    @HorasPorPagar INT,
    @MotivoHorasExtra NVARCHAR(MAX) NULL,
    @Observaciones NVARCHAR(MAX) NULL,
    @IDUSUARIO INT,
    @Evidencia1 NVARCHAR(MAX) NULL,     -- Primera imagen en Base64
    @Evidencia2 NVARCHAR(MAX) NULL      -- Segunda imagen en Base64
AS
BEGIN
    DECLARE @CostoHoraExtra FLOAT;
    DECLARE @CostoHoraDoble FLOAT;
    DECLARE @CostoHoraTriple FLOAT;
    DECLARE @HoraTriple INT = 0;
    DECLARE @TotalHoraDoble FLOAT;
    DECLARE @TotalHoraTriple FLOAT = 0;
    DECLARE @TotalAPagar FLOAT;
    DECLARE @FolioRegistro NVARCHAR(50);
    DECLARE @IDHoraExtra INT;
    DECLARE @FechaActual DATE = GETDATE();
    DECLARE @HoraActual TIME = CONVERT(TIME, GETDATE());
    DECLARE @ID_Estatus INT;

    -- Obtener el siguiente ID_HoraExtra
    SELECT @IDHoraExtra = ISNULL(MAX(id_horaExtra), 0) + 1 FROM HORAS_EXTRAS;

    -- Generar el folio
    SET @FolioRegistro = 'HE_' + CAST(@IDHoraExtra AS NVARCHAR(10));

    -- Obtener el costo por hora del empleado
    SELECT @CostoHoraExtra = salario FROM EMPLEADO WHERE id_empleado = @IDEMPLEADO;

    -- Calcular el costo por hora doble
    IF @HorasPorPagar <= 9
    BEGIN
        SET @CostoHoraDoble = @CostoHoraExtra * 2;
        SET @TotalHoraDoble = @CostoHoraDoble * @HorasPorPagar;
        SET @TotalHoraTriple = 0;
    END
    ELSE
    BEGIN
        SET @CostoHoraDoble = @CostoHoraExtra * 2;
        SET @TotalHoraDoble = @CostoHoraDoble * 9;

        -- Calcular las horas triples
        SET @HoraTriple = @HorasPorPagar - 9;
        SET @CostoHoraTriple = @CostoHoraExtra * 3;
        SET @TotalHoraTriple = @CostoHoraTriple * @HoraTriple;
    END

    -- Calcular el total a pagar
    SET @TotalAPagar = @TotalHoraDoble + @TotalHoraTriple;

    -- Obtener el ID_Estatus correspondiente
    SELECT @ID_Estatus = E.ID_Estatus
    FROM Estatus E
    INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
    WHERE TE.TipoEstatus = 'Horas_Extra' AND E.Estatus = 'EN REVISION';

    -- Insertar en la tabla HORAS_EXTRAS
    INSERT INTO HORAS_EXTRAS (
        folio_registro,
        fecha_registro,
        hora_registro,
        id_empleado,
        id_responsable,
        fecha_compensacion,
        horas_porPagar,
        costo_horaExtra,
        costo_horaDoble,
        costo_horaTriple,
        hora_triple,
        total_horaDoble,
        total_horaTriple,
        total_aPagar,
        motivo_hraExtra,
        observaciones,
        id_usuario,
        ID_Estatus
    )
    VALUES (
        @FolioRegistro,
        @FechaActual,
        @HoraActual,
        @IDEMPLEADO,
        @IDRESPONSABLE,
        @FechaCompensacion,
        @HorasPorPagar,
        @CostoHoraExtra,
        @CostoHoraDoble,
        @CostoHoraTriple,
        @HoraTriple,
        @TotalHoraDoble,
        @TotalHoraTriple,
        @TotalAPagar,
        @MotivoHorasExtra,
        @Observaciones,
        @IDUSUARIO,
        @ID_Estatus
    );

    -- Insertar las evidencias en la tabla Evidencias solo si no son NULL
	
    -- Evidencia 1
    IF @Evidencia1 IS NOT NULL
    BEGIN
        INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)
        VALUES (
            @IDHoraExtra,
            @Evidencia1,
            (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),
            (
                SELECT CAST(GETDATE() AS NVARCHAR(20)) + 
                '_' + TipoEvidencia + '_'  + '.jpeg'
                FROM TipoEvidencias 
                WHERE TipoEvidencia = 'HORAS_EXTRAS'
            ),
            @IDUSUARIO,
            GETDATE()
        );
    END

    -- Evidencia 2
    IF @Evidencia2 IS NOT NULL
    BEGIN
        INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)
        VALUES (
            @IDHoraExtra,
            @Evidencia2,
            (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),
            (
                SELECT CAST(GETDATE() AS NVARCHAR(20)) + 
                '_' + TipoEvidencia + '_' + '.jpeg'
                FROM TipoEvidencias
                WHERE TipoEvidencia = 'HORAS_EXTRAS'
            ),
            @IDUSUARIO,
            GETDATE()
        );
    END
END
GO
SELECT * FROM HORAS_EXTRAS
