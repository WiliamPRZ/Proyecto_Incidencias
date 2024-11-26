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

create table tipoError(
	id_tpError int identity(1,1) primary key not null,
	nom_error varchar(30) not null,
	id_error int not null
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
