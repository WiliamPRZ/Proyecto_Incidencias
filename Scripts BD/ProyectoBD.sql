use incidencias;


create table tipoUsuario(
	id_tpUsuario int identity(1,1) primary key not null,
	nom_tpUsuario varchar(30) not null
);


create table Usuario(
	id_usuario int identity(1,1) primary key not null,
	nom_usuario varchar(30) not null,
	correo varchar(50)not null,
	fecha_registro date not null,
	id_tpUsuario int not null
);

create table estado(
	id_Estado int identity(1,1) primary key not null,
	nom_estado varchar(30) not null
);

create table error(
	id_error int identity(1,1) primary key not null,
	nom_error varchar(30) not null
);

create table sistema(
	id_sistema int identity(1,1) primary key not null,
	nom_sistema varchar(30) not null
);

create table incidencia(
		id_incidencia int identity(1,1) primary key not null,
		id_usuario_report int not null,
		id_usuario_tecn int,
		titulo varchar(50) not null,
		descripcion varchar(50) not null,
		fecha_reporte date not  null,
		id_error int not null,
		id_estado int not null,
		id_sistema int not null,
		fecha_resolucion date
);

create table comentario (
	id_comentario int identity(1,1) primary key not null,
	id_incidencia int not null,
	id_usuario int not null,
	comentario varchar(50) not null,
	fecha_comentario date not null
);

create table historial (
	id_historial int identity(1,1) primary key not null,
	id_incidencia int not null,
	est_anterior int not null,
	est_nuevo int not null,
	id_usuario int not null,
	fecha_cambio date not null
);

-- Llaves ForaneasS
-- Usuario
ALTER TABLE Usuario
ADD CONSTRAINT FK_Usuario_TPUsuario
FOREIGN KEY (id_tpUsuario)
REFERENCES tipoUsuario(id_tpUsuario);

-- Incidencia
ALTER TABLE incidencia
ADD CONSTRAINT FK_incidencia_usuarioReporte
FOREIGN KEY (id_usuario_report)
REFERENCES Usuario(id_usuario);

ALTER TABLE incidencia
ADD CONSTRAINT FK_incidencia_usuarioTecnico
FOREIGN KEY (id_usuario_tecn)
REFERENCES Usuario(id_usuario);

ALTER TABLE incidencia
ADD CONSTRAINT FK_incidencia_error
FOREIGN KEY (id_error)
REFERENCES error(id_error);

ALTER TABLE incidencia
ADD CONSTRAINT FK_incidencia_estado
FOREIGN KEY (id_estado)
REFERENCES estado(id_estado);

ALTER TABLE incidencia
ADD CONSTRAINT FK_incidencia_sistema
FOREIGN KEY (id_sistema)
REFERENCES sistema(id_sistema);

--Comentario
ALTER TABLE comentario
ADD CONSTRAINT FK_comentario_incidencia
FOREIGN KEY (id_incidencia)
REFERENCES incidencia(id_incidencia);

ALTER TABLE comentario
ADD CONSTRAINT FK_comentario_usuario
FOREIGN KEY (id_usuario)
REFERENCES Usuario(id_usuario);

--Historial
ALTER TABLE historial
ADD CONSTRAINT FK_historial_usuario
FOREIGN KEY (id_usuario)
REFERENCES Usuario(id_usuario);

ALTER TABLE historial
ADD CONSTRAINT FK_historial_incidencia
FOREIGN KEY (id_incidencia)
REFERENCES incidencia(id_incidencia);

ALTER TABLE historial
ADD CONSTRAINT FK_historial_est_anterior
FOREIGN KEY (est_anterior)
REFERENCES estado(id_Estado);

ALTER TABLE historial
ADD CONSTRAINT FK_historial_est_nuevo
FOREIGN KEY (est_nuevo)
REFERENCES estado(id_Estado);

-- PROCEDIMIENTO ALMACENADOS

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
    @IdUsuarioReport INT = NULL,      -- Este parámetro es opcional
    @IdUsuarioTecn INT = NULL,        -- Este parámetro es opcional
    @Titulo VARCHAR(50) = NULL,       -- Este parámetro es opcional
    @Descripcion VARCHAR(50) = NULL,  -- Este parámetro es opcional
    @IdError INT = NULL,              -- Este parámetro es opcional
    @IdEstado INT = NULL,             -- Este parámetro es opcional
    @IdSistema INT = NULL,            -- Este parámetro es opcional
    @FechaResolucion DATE = NULL      -- Este parámetro es opcional
AS
BEGIN
    -- Actualizamos la tabla de incidencia con los parámetros proporcionados
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
    @IdIncidencia INT = NULL,         -- Este parámetro es opcional
    @IdUsuario INT = NULL,            -- Este parámetro es opcional
    @Comentario VARCHAR(50) = NULL,   -- Este parámetro es opcional
    @FechaComentario DATE = NULL      -- Este parámetro es opcional
AS
BEGIN
    -- Actualizamos la tabla comentario con los parámetros proporcionados
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
    @IdIncidencia INT = NULL,         -- Este parámetro es opcional
    @EstAnterior INT = NULL,          -- Este parámetro es opcional
    @EstNuevo INT = NULL,             -- Este parámetro es opcional
    @IdUsuario INT = NULL,            -- Este parámetro es opcional
    @FechaCambio DATE = NULL          -- Este parámetro es opcional
AS
BEGIN
    -- Actualizamos la tabla historial con los parámetros proporcionados
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

