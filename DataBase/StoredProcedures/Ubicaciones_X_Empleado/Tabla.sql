USE db_aaf5ad_nggg02
GO

CREATE TABLE Ubicaciones_X_Empleado (
    ID_Ubicaciones_X_Empleado INT IDENTITY(1,1) PRIMARY KEY,
    id_Ubicacion INT NOT NULL,
    id_Empleado INT NOT NULL,
    CONSTRAINT FK_Ubicaciones_X_Empleado_Ubicacion FOREIGN KEY (id_Ubicacion) REFERENCES UBICACION (id_ubicacion),
    CONSTRAINT FK_Ubicaciones_X_Empleado_Empleado FOREIGN KEY (id_Empleado) REFERENCES EMPLEADO (id_empleado)
);
