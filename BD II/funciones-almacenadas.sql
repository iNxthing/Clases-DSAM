-- Crear la base de datos
drop database if exists db_colegio_control;
CREATE DATABASE IF NOT EXISTS db_colegio_control;
USE db_colegio_control;

-- 1. Tabla Cursos
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(50) NOT NULL,
    nivel VARCHAR(20) NOT NULL
);

-- 2. Tabla Estudiantes
CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) NOT NULL,
    id_curso INT,
    CONSTRAINT fk_estudiante_curso FOREIGN KEY (id_curso) 
        REFERENCES cursos(id_curso) ON DELETE CASCADE
);

-- 3. Tabla Materias
CREATE TABLE materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nombre_materia VARCHAR(60) NOT NULL,
    creditos INT DEFAULT 3
);

-- 4. Tabla Notas
CREATE TABLE notas (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_materia INT,
    valor_nota DECIMAL(4,2) NOT NULL,
    periodo TINYINT NOT NULL,
    fecha_registro DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_nota_estudiante FOREIGN KEY (id_estudiante) 
        REFERENCES estudiantes(id_estudiante) ON DELETE CASCADE,
    CONSTRAINT fk_nota_materia FOREIGN KEY (id_materia) 
        REFERENCES materias(id_materia) ON DELETE CASCADE
);

-- 5. Tabla Asistencias
CREATE TABLE asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    fecha DATE NOT NULL,
    estado ENUM('Presente', 'Ausente', 'Tardanza') NOT NULL,
    CONSTRAINT fk_asistencia_estudiante FOREIGN KEY (id_estudiante) 
        REFERENCES estudiantes(id_estudiante) ON DELETE CASCADE
);
-- Insertar Cursos
INSERT INTO cursos (nombre_curso, nivel) VALUES 
('10° A', 'Secundaria'),
('10° B', 'Secundaria'),
('11° A', 'Media');

-- Insertar Estudiantes (con fechas de nacimiento variadas para probar cumpleaños)
INSERT INTO estudiantes (id_estudiante,nombres, apellidos, fecha_nacimiento, genero, id_curso) VALUES 
(1,'Carlos Andrés', 'Pérez Gómez', '2009-03-15', 'M', 1),
(2,'María Alejandra', 'López Ruiz', '2009-09-22', 'F', 1),
(3,'Juan David', 'Martínez Silva', '2008-11-05', 'M', 3),
(4,'Ana Sofía', 'Torres Benítez', '2009-03-30', 'F', 2),
(5,'Luis Miguel', 'Ramírez Castro', '2008-01-12', 'M', 3),
(6,'Valeria', 'Gutiérrez Mendoza', '2009-06-18', 'F', 2);

-- Insertar Materias
INSERT INTO materias (nombre_materia, creditos) VALUES 
('Matemáticas', 4),
('Bases de Datos', 4),
('Física', 3),
('Ingles', 3);

-- Insertar Notas (para evaluar estadísticas: promedios, máximas y mínimas)
INSERT INTO notas (id_estudiante, id_materia, valor_nota, periodo, fecha_registro) VALUES 
(1, 1, 4.5, 1, '2026-03-10'),
(1, 2, 3.8, 1, '2026-03-12'),
(2, 1, 4.9, 1, '2026-03-10'),
(2, 2, 4.7, 1, '2026-03-12'),
(3, 1, 2.9, 1, '2026-03-10'),
(3, 3, 3.5, 1, '2026-03-15'),
(4, 2, 4.2, 1, '2026-03-12'),
(4, 4, 4.8, 1, '2026-03-14'),
(5, 1, 3.1, 1, '2026-03-10'),
(5, 3, 3.0, 1, '2026-03-15'),
(6, 2, 4.6, 1, '2026-03-12'),
(6, 4, 3.9, 1, '2026-03-14');

-- Insertar Asistencias (para calcular porcentajes de asistencia)
INSERT INTO asistencias (id_estudiante, fecha, estado) VALUES 
(1, '2026-09-01', 'Presente'),
(1, '2026-09-02', 'Presente'),
(1, '2026-09-03', 'Tardanza'),
(2, '2026-09-01', 'Presente'),
(2, '2026-09-02', 'Presente'),
(2, '2026-09-03', 'Presente'),
(3, '2026-09-01', 'Ausente'),
(3, '2026-09-02', 'Ausente'),
(3, '2026-09-03', 'Presente'),
(4, '2026-09-01', 'Presente'),
(4, '2026-09-02', 'Tardanza'),
(4, '2026-09-03', 'Presente');


/* Reto 1: Promedio General del Estudiante
    • Objetivo: Crear una función llamada fn_promedio_estudiante que reciba el 
    de un estudiante y retorne el promedio aritmético de todas sus notas registradas.

    • Parámetro de entrada: p_id_estudiante INT

    • Retorno: DECIMAL(4,2)*/
DROP FUNCTION IF EXISTS fn_promedio_estudiante;

DELIMITER //

CREATE FUNCTION fn_promedio_estudiante(p_id_estudiante INT)
RETURNS DECIMAL(4,2)
BEGIN
    DECLARE promedio_notas DECIMAL(4,2);

    set promedio_notas= (SELECT AVG(valor_nota) from notas WHERE id_estudiante = p_id_estudiante);

    RETURN promedio_notas;
END //

DELIMITER ;

SELECT *, fn_promedio_estudiante(id_estudiante) AS promedio
FROM estudiantes;
    
/* Reto 2: Porcentaje de Asistencia Efectiva
    • Objetivo: Desarrollar una función que calcule el porcentaje de asistencia
    de un alumno, dividiendo sus asistencias con estado 'Presente' entre el total
    de registros de asistencia que posea.

    • Parámetro de entrada: p_id_estudiante INT

    • Retorno: DECIMAL(5,2) (Representando el porcentaje, ej: 85.50)*/
    
DELIMITER //

create function FC_ASISTENCIAS_EFECTIVAS(p_id_estudiante int) returns decimal(5,2)
begin
declare Asistencias_totales INT;
declare Asistencias_Efectivas double;
declare Asistencias_Presentes INT;

set Asistencias_totales = (select count(id_asistencia)from asistencias where id_estudiante=p_id_estudiante);
set Asistencias_Presentes = (select count(id_asistencia) from asistencias where id_estudiante=p_id_estudiante and estado="Presente");


if Asistencias_Presentes=0 then
return Asistencias_Efectivas;
end if;
if Asistencias_totales<0 then
set Asistencias_Efectivas=0;
end if;
if Asistencias_totales>0 then
set Asistencias_Efectivas = (Asistencias_Presentes/Asistencias_totales)*100.0;
end if;
return Asistencias_Efectivas;

end ;//

select *,FC_ASISTENCIAS_EFECTIVAS(id_estudiante) from estudiantes


/* 
Reto 3: Cálculo de la Edad Actual
    • Objetivo: Diseñar una función llamada fn_calcular_edad que
    tome la fecha de nacimiento de un estudiante y calcule su edad
    actual en años cumplidos respecto a la fecha actual.

    • Parámetro de entrada: p_id_estudiante INT

    • Retorno: INT
*/
    
DELIMITER //
create function fn_calcular_edad(p_id_estudiante INT) returns INT
begin
	declare edad int;
    
    set edad = (select(timestampdiff(year,fecha_nacimiento,CURDATE())) from estudiantes where id_estudiante=p_id_estudiante);
    
    return edad;
end//

DELIMITER ;

select *,fn_calcular_edad(id_estudiante) from estudiantes


/* 
Reto 4: Desempeño Cualitativo de una Nota
    • Objetivo: Escribir una función que reciba un valor numérico de nota
    y retorne una escala cualitativa según la siguiente regla:


        ◦ 4.6 - 5.0  'Superior'

        ◦ 4.0 - 4.5  'Alto'

        ◦ 3.0 - 3.9  'Básico'

        ◦ 0.0 - 2.9  'Bajo'

    • Parámetro de entrada: p_valor_nota DECIMAL(4,2)

    • Retorno: VARCHAR(20)
*/

DELIMITER //

-- drop function if exists fn_desempeño;  
create function fn_desempeño(p_valor_nota DECIMAL(4,2)) returns VARCHAR(20)
begin
	
    declare desempeño Varchar(20);
    
   
if p_valor_nota>=4.6 then
   set desempeño="Superior";
end if;
if p_valor_nota>=4.0 and p_valor_nota <=4.5 then
   set desempeño="Alto";
end if;
if p_valor_nota>=3.0 and p_valor_nota <=3.9 then
   set desempeño="Basico";
end if;
if p_valor_nota>=0.0 and p_valor_nota <=2.9 then
   set desempeño="Bajo";
end if;
   return desempeño;
   
end//

DELIMITER ;

select *,fn_desempeño(valor_nota) from notas





DELIMITER //

create function fn_desempeño_estudiante(p_id_estudiante INT) returns VARCHAR(20)
begin
	
    declare desempeño Varchar(20);
    declare nota decimal(4,2);
    
    set nota = (select(avg(valor_nota)) from notas where id_estudiante=p_id_estudiante);
    
   
if nota>=4.6 then
   set desempeño="Superior";
end if;
if nota>=4.0 and nota <=4.5 then
   set desempeño="Alto";
end if;
if nota>=3.0 and nota <=3.9 then
   set desempeño="Basico";
end if;
if nota>=0.0 and nota <=2.9 then
   set desempeño="Bajo";
end if;
   return desempeño;
   
end //

DELIMITER ;

select *,fn_desempeño_estudiante(id_estudiante) from estudiantes;






