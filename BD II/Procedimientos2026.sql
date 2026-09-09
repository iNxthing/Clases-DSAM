create database procedimiento2026;
use procedimiento2026;

create table ejemplo_1 (idcampo int primary key, nombre varchar(20), apellido varchar(20), telefono varchar(20));

create table ejemplo_2 (idcampo int primary key auto_increment, nombre varchar(20), apellido varchar(20), telefono varchar(20));


-- Sintaxis procedmimientp de almacenado
delimiter //
create procedure guardar1(p_id int,p_n varchar(20),p_a varchar(20), p_t varchar(20)) 
begin
insert into ejemplo_1 (idcampo,nombre,apellido,telefono)
values (p_id,p_n,p_a,p_t);
select * from ejemplo_1;


end
;//

call guardar1(1,'Diomedez','Uzumaki','300012321');//

delimiter //
create procedure siud(p1 int,p1 varchar(20),
p1 varchar(20), p1 varchar(20),accion varchar(2)) BEGIN
if accion='s' then
select * from ejemplo_1;
end if;
if accion='i' then
insert into ejemplo_1 (idcampo,nombre,apellido,telefono)
values(p1,p2,p3,p4);
end if;
if accion='u' then
update ejemplo_1 set nombre=p1, apellido=p2,telefono=p4
where idcampo=p1;
end if;
if accion='d' then
delete from ejemplo_1 where idcampo=p1;
end if;
end;//

delimiter //
create procedure siud(p1 int,p1 varchar(20),
p1 varchar(20), p1 varchar(20),accion varchar(2)) BEGIN
if accion='s' then
select * from ejemplo_2;
end if;
if accion='i' then
insert into ejemplo_2 (idcampo,nombre,apellido,telefono)
values(p1,p2,p3,p4);
end if;
if accion='u' then
update ejemplo_2 set nombre=p1, apellido=p2,telefono=p4
where idcampo=p1;
end if;
if accion='d' then
delete from ejemplo_2 where idcampo=p1;
end if;
end;//




