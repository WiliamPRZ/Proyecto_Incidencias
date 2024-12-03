use incidencias;

-- PROCEDIMIENTO ALMACENADOS
go
CREATE PROCEDURE InicioSesion
    @idUsuario INT
AS
BEGIN
Select id_usuario, nom_usuario, correo, fecha_registro, id_tpUsuario
from Usuario u
where u.id_usuario = @idUsuario

END;

go
CREATE PROCEDURE InsertarIncidencia
    @IdUsuarioReport INT,
    @IdUsuarioTecn INT,
    @Titulo VARCHAR(50),
    @Descripcion VARCHAR(50),
    @IdError INT,
    @IdEstado INT,
    @IdSistema INT
AS
BEGIN
    -- Realizamos el INSERT en la tabla incidencia
    INSERT INTO incidencia (id_usuario_report, id_usuario_tecn, titulo, descripcion, fecha_reporte, id_error, id_estado, id_sistema, fecha_resolucion)
    VALUES (@IdUsuarioReport, @IdUsuarioTecn, @Titulo, @Descripcion, GETDATE(), @IdError, @IdEstado, @IdSistema, null);

END;

GO
CREATE PROCEDURE InsertarComentario
    @IdIncidencia INT,
    @IdUsuario INT,
    @Comentario VARCHAR(50)
AS
BEGIN
    -- Realizamos el INSERT en la tabla comentario
    INSERT INTO comentario (id_incidencia, id_usuario, comentario, fecha_comentario)
    VALUES (@IdIncidencia, @IdUsuario, @Comentario, GETDATE());

END;

go

CREATE PROCEDURE InsertarHistorial
    @IdIncidencia INT,
    @EstAnterior INT,
    @EstNuevo INT,
    @IdUsuario INT
AS
BEGIN
    -- Realizamos el INSERT en la tabla historial
    INSERT INTO historial (id_incidencia, est_anterior, est_nuevo, id_usuario, fecha_cambio)
    VALUES (@IdIncidencia, @EstAnterior, @EstNuevo, @IdUsuario, GETDATE());
END;

GO

CREATE PROCEDURE ConsultaIncidencias_Totales
AS
BEGIN
	Select i.id_incidencia, i.titulo, i.descripcion, u1.nom_usuario as 'Reporto', u2.nom_usuario as 'Tecnico', e.nom_error, es.nom_estado, s.nom_sistema
	from incidencia i
	inner join Usuario u1 on u1.id_usuario = i.id_usuario_report
	inner join Usuario u2 on u2.id_usuario = i.id_usuario_tecn
	inner join error e on e.id_error = i.id_error
	inner join estado es on es.id_Estado = i.id_estado
	inner join sistema s on s.id_sistema = i.id_sistema
END;

GO
CREATE PROCEDURE ModificarIncidencia
    @IdIncidencia INT,
    @IdUsuarioReport INT = NULL,      -- Este par�metro es opcional
    @IdUsuarioTecn INT = NULL,        -- Este par�metro es opcional
    @Titulo VARCHAR(50) = NULL,       -- Este par�metro es opcional
    @Descripcion VARCHAR(50) = NULL,  -- Este par�metro es opcional
    @IdError INT = NULL,              -- Este par�metro es opcional
    @IdEstado INT = NULL,             -- Este par�metro es opcional
    @IdSistema INT = NULL,            -- Este par�metro es opcional
    @FechaResolucion DATE = NULL      -- Este par�metro es opcional
AS
BEGIN
    -- Actualizamos la tabla de incidencia con los par�metros proporcionados
    UPDATE incidencia
    SET
        id_usuario_report = COALESCE(@IdUsuarioReport, id_usuario_report),
        id_usuario_tecn = COALESCE(@IdUsuarioTecn, id_usuario_tecn),
        titulo = COALESCE(@Titulo, titulo),
        descripcion = COALESCE(@Descripcion, descripcion),
        id_error = COALESCE(@IdError, id_error),
        id_estado = COALESCE(@IdEstado, id_estado),
        id_sistema = COALESCE(@IdSistema, id_sistema),
        fecha_resolucion = COALESCE(@FechaResolucion, fecha_resolucion)
    WHERE id_incidencia = @IdIncidencia;
    
END;
GO

CREATE PROCEDURE ModificarComentario
    @IdComentario INT,
    @IdIncidencia INT = NULL,         -- Este par�metro es opcional
    @IdUsuario INT = NULL,            -- Este par�metro es opcional
    @Comentario VARCHAR(50) = NULL,   -- Este par�metro es opcional
    @FechaComentario DATE = NULL      -- Este par�metro es opcional
AS
BEGIN
    -- Actualizamos la tabla comentario con los par�metros proporcionados
    UPDATE comentario
    SET
        id_incidencia = COALESCE(@IdIncidencia, id_incidencia),
        id_usuario = COALESCE(@IdUsuario, id_usuario),
        comentario = COALESCE(@Comentario, comentario),
        fecha_comentario = COALESCE(@FechaComentario, fecha_comentario)
    WHERE id_comentario = @IdComentario;

END;
GO
CREATE PROCEDURE ModificarHistorial
    @IdHistorial INT,
    @IdIncidencia INT = NULL,         -- Este par�metro es opcional
    @EstAnterior INT = NULL,          -- Este par�metro es opcional
    @EstNuevo INT = NULL,             -- Este par�metro es opcional
    @IdUsuario INT = NULL,            -- Este par�metro es opcional
    @FechaCambio DATE = NULL          -- Este par�metro es opcional
AS
BEGIN
    -- Actualizamos la tabla historial con los par�metros proporcionados
    UPDATE historial
    SET
        id_incidencia = COALESCE(@IdIncidencia, id_incidencia),
        est_anterior = COALESCE(@EstAnterior, est_anterior),
        est_nuevo = COALESCE(@EstNuevo, est_nuevo),
        id_usuario = COALESCE(@IdUsuario, id_usuario),
        fecha_cambio = COALESCE(@FechaCambio, fecha_cambio)
    WHERE id_historial = @IdHistorial;

END;
GO

