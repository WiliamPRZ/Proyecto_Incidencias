use incidencias;

insert into tipoUsuario values ('Comun');
insert into tipoUsuario values ('Admin');
insert into tipoUsuario values ('Tecnico');

Select * from tipoUsuario;

go

insert into usuario values('Wiliam Perez','wiliam@gmail.com','01/01/01',1);
insert into usuario values('Alan Rodiguez','alan@gmail.com','01/01/01',1);
insert into usuario values('Jose Lopez','jose@gmail.com','01/01/01',1);

insert into usuario values('Carlos Rodriguez','carlos@gmail.com','01/01/01',2);
insert into usuario values('Luis Palazuelos','luis@gmail.com','01/01/01',2);
insert into usuario values('Antonio Banderas','antonio@gmail.com','01/01/01',2);

insert into usuario values('Miguel Abitia','miguel@gmail.com','01/01/01',3);
insert into usuario values('Erik Zazueta','erik@gmail.com','01/01/01',3);
insert into usuario values('Dilan Beltran','dilan@gmail.com','01/01/01',3);

Select * from Usuario u inner join tipoUsuario tu on tu.id_tpUsuario=u.id_tpUsuario;

