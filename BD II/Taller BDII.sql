-- =============================================================================
-- 1. CREACIÓN DE LA BASE DE DATOS
-- =============================================================================
DROP DATABASE IF EXISTS citas_medicas_db;
CREATE DATABASE citas_medicas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE citas_medicas_db;

-- =============================================================================
-- 2. DEFINICIÓN DE TABLAS (DDL)
-- =============================================================================

-- Tabla de Sedes Clínicas (Mínimo 3 sedes)
CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    direccion VARCHAR(120) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- Tabla de Especialidades Médicas (Más de 10 especialidades)
CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_especialidad VARCHAR(80) NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);

-- Tabla de Médicos (Generales y Especialistas)
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre_medico VARCHAR(100) NOT NULL,
    tipo_medico ENUM('General', 'Especialista') NOT NULL,
    tarjeta_profesional VARCHAR(30) UNIQUE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    id_especialidad INT NULL, -- NULL para Médicos Generales
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

-- Tabla de Consultorios por Sede
CREATE TABLE consultorios (
    id_consultorio INT AUTO_INCREMENT PRIMARY KEY,
    numero_consultorio VARCHAR(10) NOT NULL,
    piso INT NOT NULL,
    id_sede INT NOT NULL,
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

-- Tabla de Pacientes
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paciente VARCHAR(100) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero ENUM('M', 'F', 'Otro') NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    ciudad VARCHAR(60) NOT NULL
);

-- Tabla de Citas Médicas
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_consultorio INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    motivo_consulta VARCHAR(200) NOT NULL,
    estado ENUM('Programada', 'Atendida', 'Cancelada', 'No Asistio') NOT NULL,
    costo_consulta DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio)
);

-- Tabla de Historias Clínicas (Atenciones)
CREATE TABLE historias_clinicas (
    id_historia INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT UNIQUE NOT NULL,
    diagnostico TEXT NOT NULL,
    observaciones TEXT,
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);

-- Tabla de Recetas / Medicamentos Prescritos
CREATE TABLE recetas_medicas (
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT NOT NULL,
    medicamento VARCHAR(100) NOT NULL,
    dosis VARCHAR(80) NOT NULL,
    duracion_dias INT NOT NULL,
    FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- =============================================================================
-- 3. POBLAMIENTO DE DATOS (DML)
-- =============================================================================

-- Sedes
INSERT INTO sedes (nombre_sede, ciudad, direccion, telefono) VALUES
('Sede Principal Prado', 'Santa Marta', 'Cra 4 # 24-89', '3001112233'),
('Sede Norte Rodadero', 'Santa Marta', 'Cl 11 # 2-15', '3002223344'),
('Sede Centro Histórico', 'Barranquilla', 'Cra 54 # 72-101', '3013334455'),
('Sede Murillo', 'Barranquilla', 'Cl 45 # 21-30', '3014445566'),
('Sede Los Alpes', 'Cartagena', 'Av. Pedro de Heredia # 31-10', '3025556677');

-- Especialidades Clínicas (12 especialidades)
INSERT INTO especialidades (nombre_especialidad, descripcion) VALUES
('Cardiología', 'Diagnóstico y tratamiento de enfermedades cardíacas y vasculares'),
('Pediatría', 'Atención médica integral para recién nacidos, niños y adolescentes'),
('Dermatología', 'Tratamiento y prevención de afecciones de la piel, pelo y uñas'),
('Neurología', 'Trastornos del sistema nervioso central y periférico'),
('Ortopedia y Traumatología', 'Tratamiento de lesiones del sistema musculoesquelético'),
('Ginecología y Obstetricia', 'Salud del sistema reproductor femenino y control prenatal'),
('Oftalmología', 'Patologías y cirugías del ojo y sistema visual'),
('Otorrinolaringología', 'Enfermedades de oído, nariz, garganta y estructuras de cabeza y cuello'),
('Psiquiatría', 'Salud mental, trastornos afectivos y neuroconductuales'),
('Endocrinología', 'Trastornos hormonales, metabólicos y de glándulas'),
('Gastroenterología', 'Afecciones del tracto digestivo, hígado y páncreas'),
('Urología', 'Sistema urinario en ambos sexos y aparato reproductor masculino');

INSERT INTO medicos (nombre_medico, tipo_medico, tarjeta_profesional, correo, id_especialidad) VALUES 
('Dr. Goku Yandel González Rodríguez', 'General', 'TP-1001', 'gyandel@saludplus.com', NULL), 
('Dra. Barbie Karol Gómez Hernández', 'General', 'TP-1002', 'bkarol@saludplus.com', NULL), 
('Dr. Vegeta Feid López Pérez', 'General', 'TP-1003', 'vfeid@saludplus.com', NULL), 
('Dra. Hermione Rosalía Martínez García', 'Especialista', 'TP-2001', 'hrosalia@saludplus.com', 1), -- Cardiología 
('Dr. Naruto Maluma Morales Romero', 'Especialista', 'TP-2002', 'nmaluma@saludplus.com', 2), -- Pediatría 
('Dra. Katniss Becky Silva Torres', 'Especialista', 'TP-2003', 'kbecky@saludplus.com', 3), -- Dermatología 
('Dr. Sherlock Rauw Castro Delgado', 'Especialista', 'TP-2004', 'srauw@saludplus.com', 4), -- Neurología 
('Dr. Legolas Wisin Ortiz Álvarez', 'Especialista', 'TP-2005', 'lwisin@saludplus.com', 5), -- Ortopedia 
('Dra. Daenerys Natti Sánchez Herrera', 'Especialista', 'TP-2006', 'dnatti@saludplus.com', 6), -- Ginecología 
('Dr. Luke Myke Ramírez Díaz', 'Especialista', 'TP-2007', 'lmyke@saludplus.com', 7), -- Oftalmología 
('Dra. Zelda Greeicy Mendoza Rojas', 'Especialista', 'TP-2008', 'zgreeicy@saludplus.com', 8), -- Otorrinolaringología 
('Dr. Harry Chencho Flores Acosta', 'Especialista', 'TP-2009', 'hchencho@saludplus.com', 9), -- Psiquiatría 
('Dra. Leia Emilia Cruz Navarro', 'Especialista', 'TP-2010', 'lemilia@saludplus.com', 10), -- Endocrinología 
('Dr. Spiderman Anuel Vargas Medina', 'Especialista', 'TP-2011', 'sanuel@saludplus.com', 11), -- Gastroenterología 
('Dra. Mulan BadGyal Castillo Reyes', 'Especialista', 'TP-2012', 'mbadgyal@saludplus.com', 12), -- Urología 
('Dr. Albus Trueno Peña Moreno', 'Especialista', 'TP-2013', 'atrueno@saludplus.com', 1); -- Cardiología (Sin citas asignadas) 
-- ============================================================================= -- INSERCIÓN DE PACIENTES ACTUALIZADA

-- Consultorios por Sedes
INSERT INTO consultorios (numero_consultorio, piso, id_sede) VALUES
('C-101', 1, 1),
('C-102', 1, 1),
('C-201', 2, 1),
('C-301', 3, 1),
('C-101', 1, 2),
('C-201', 2, 2),
('C-101', 1, 3),
('C-201', 2, 3),
('C-301', 3, 3),
('C-101', 1, 4),
('C-201', 2, 4),
('C-101', 1, 5),
('C-999', 9, 5); -- Consultorio sin citas asignadas

-- =============================================================================
-- INSERCIÓN DE PACIENTES ACTUALIZADA
-- =============================================================================
INSERT INTO pacientes (nombre_paciente, documento, fecha_nacimiento, genero, telefono, ciudad) VALUES
('Luffy Mora Romero Gutierrez', 'CC-112233', '1988-04-15', 'M', '3151234567', 'Santa Marta'),
('ChunLi Tokischa Paredes Blanco', 'CC-223344', '1995-09-20', 'F', '3162345678', 'Santa Marta'),
('Frodo Quevedo Suárez Méndez', 'CC-334455', '2012-03-10', 'M', '3173456789', 'Barranquilla'),
('SailorMoon Villano Aguilar Rivas', 'CC-445566', '1970-11-05', 'F', '3184567890', 'Santa Marta'),
('Homer Balvin Cárdenas Soto', 'CC-556677', '1982-01-25', 'M', '3195678901', 'Barranquilla'),
('Moana YoungMiko Guzmán Lozano', 'CC-667788', '1990-07-18', 'F', '3106789012', 'Ciénaga'),
('Sonic Duki Valenzuela Ramos', 'CC-778899', '2015-12-02', 'M', '3117890123', 'Cartagena'),
('Shrek Cosculluela Benítez Fuentes', 'CC-889900', '1985-06-30', 'F', '3128901234', 'Cartagena'),
('Batman Arcángel Ospina Cabrera', 'CC-990011', '1975-02-14', 'M', '3139012345', 'Santa Marta'),
('Ahsoka Snow Salgado Miranda', 'CC-001122', '2001-08-22', 'F', '3140123456', 'Barranquilla'),
('Fiona Bellakath Figueroa Marín', 'CC-102938', '1998-10-10', 'F', '3159988776', 'Cartagena'); -- Paciente sin citas
-- Citas Médicas
INSERT INTO citas (id_paciente, id_medico, id_consultorio, fecha_hora, motivo_consulta, estado, costo_consulta) VALUES
(1, 1, 1, '2026-03-01 08:00:00', 'Control de rutina y chequeo general', 'Atendida', 40000.00),
(1, 4, 3, '2026-03-05 10:00:00', 'Dolor precordial punzante y taquicardia', 'Atendida', 120000.00),
(2, 6, 4, '2026-03-02 09:00:00', 'Manchas y erupción en la piel', 'Atendida', 110000.00),
(3, 5, 8, '2026-03-03 14:00:00', 'Fiebre persistente y tos seca', 'Atendida', 100000.00),
(4, 7, 3, '2026-03-04 11:30:00', 'Cefaleas recurrentes y mareo', 'Atendida', 130000.00),
(5, 8, 7, '2026-03-06 08:30:00', 'Dolor intenso en rodilla derecha tras golpe', 'Atendida', 115000.00),
(6, 9, 2, '2026-03-07 10:30:00', 'Control prenatal primer trimestre', 'Atendida', 125000.00),
(7, 5, 12, '2026-03-08 15:00:00', 'Evaluación de crecimiento y desarrollo', 'Atendida', 100000.00),
(8, 10, 12, '2026-03-09 16:00:00', 'Disminución de agudeza visual ojo izquierdo', 'Atendida', 105000.00),
(9, 11, 4, '2026-03-10 09:00:00', 'Congestión nasal y dolor de garganta agudo', 'Atendida', 110000.00),
(1, 13, 3, '2026-03-12 11:00:00', 'Control de tiroides y metabolismo', 'Atendida', 120000.00),
(2, 1, 1, '2026-03-14 08:00:00', 'Certificado médico general y laboratorio', 'Atendida', 40000.00),
(10, 12, 9, '2026-03-15 16:30:00', 'Crisis de ansiedad y dificultades de sueño', 'Atendida', 140000.00),
(4, 14, 3, '2026-03-16 10:00:00', 'Reflujo gastroesofágico y acidez nocturna', 'Atendida', 115000.00),
(5, 15, 7, '2026-03-17 11:30:00', 'Chequeo urológico y cólico renal', 'Atendida', 125000.00),
(2, 4, 3, '2026-03-18 09:00:00', 'Palpitaciones al esfuerzo físico', 'Atendida', 120000.00),
(9, 2, 5, '2026-03-20 08:00:00', 'Malestar general y fatiga', 'Atendida', 40000.00),
(3, 5, 8, '2026-03-25 14:00:00', 'Revisión posterior de cuadro viral', 'Atendida', 100000.00),
(6, 1, 1, '2026-04-01 08:00:00', 'Revisión de paraclínicos generales', 'Programada', 40000.00),
(8, 8, 12, '2026-04-02 10:00:00', 'Dolor lumbar mecánico continuo', 'Programada', 115000.00),
(10, 4, 9, '2026-04-03 11:00:00', 'Valoración cardiovascular prequirúrgica', 'Cancelada', 120000.00),
(5, 1, 7, '2026-04-04 07:30:00', 'Control rutinario', 'No Asistio', 40000.00);

-- Historias Clínicas
INSERT INTO historias_clinicas (id_cita, diagnostico, observaciones, fecha_registro) VALUES
(1, 'Chequeo dentro de límites normales', 'Se solicitan exámenes de lípidos y glicemia de control', '2026-03-01'),
(2, 'Hipertensión arterial estadio 1', 'Iniciar plan dietario hiposódico y medicación regular', '2026-03-05'),
(3, 'Dermatitis atópica por contacto', 'Evitar jabones alcalinos, aplicar crema emoliente tópica', '2026-03-02'),
(4, 'Rinofaringitis aguda viral infantil', 'Manejo sintomático e hidratación oral frecuente', '2026-03-03'),
(5, 'Migraña común con aura', 'Reposo en ambiente oscuro durante episodios agudos', '2026-03-04'),
(6, 'Esguince de rodilla grado I', 'Reposo relativo, hielo local y analgésicos', '2026-03-06'),
(7, 'Embarazo de 10 semanas con evolución favorable', 'Se prescriben micronutrientes y ecografía de tamizaje', '2026-03-07'),
(8, 'Desarrollo estaturo-ponderal adecuado', 'Continuar con alimentación balanceada e inmunización al día', '2026-03-08'),
(9, 'Astigmatismo miópico bilateral', 'Uso permanente de lentes correctores de fórmula óptica', '2026-03-09'),
(10, 'Faringoamigdalitis bacteriana aguda', 'Tratamiento antibiótico completo por 7 días', '2026-03-10'),
(11, 'Hipotiroidismo primario compensado', 'Continuar suplencia hormonal en ayunas', '2026-03-12'),
(12, 'Estado nutricional y paraclínicos óptimos', 'Firma de certificado médico ocupacional', '2026-03-14'),
(13, 'Trastorno de ansiedad generalizada leve', 'Terapia cognitivo-conductual e higiene del sueño', '2026-03-15'),
(14, 'Enfermedad por reflujo gastroesofágico (ERGE)', 'Evitar cafeína, comidas grasas y no acostarse recién comido', '2026-03-16'),
(15, 'Litiasis renal no obstructiva', 'Abundante ingesta hídrica diaria (mínimo 2.5 litros)', '2026-03-17'),
(16, 'Extrasístoles ventriculares benignas', 'Monitoreo Holter 24 horas y reducción del estrés laboral', '2026-03-18'),
(17, 'Síndrome de fatiga posviral', 'Reposo, multivitamínicos y reincorporación progresiva', '2026-03-20'),
(18, 'Resolución satisfactoria de cuadro respiratorio', 'Alta pediátrica sin complicaciones registradas', '2026-03-25');

-- Recetas Médicas
INSERT INTO recetas_medicas (id_historia, medicamento, dosis, duracion_dias) VALUES
(2, 'Losartán Potásico 50mg', '1 tableta cada 12 horas vía oral', 60),
(2, 'Hidroclorotiazida 25mg', '1 tableta cada mañana vía oral', 30),
(3, 'Hidrocortisona crema 1%', 'Aplicar capa fina en zona afectada cada 12 horas', 7),
(3, 'Cetirizina 10mg', '1 tableta en la noche vía oral', 10),
(4, 'Acetaminofén jarabe 120mg/5ml', '5 ml cada 6 horas según fiebre o dolor', 3),
(5, 'Sumatriptán 50mg', '1 tableta al inicio del dolor de cabeza', 5),
(5, 'Naproxeno 250mg', '1 cápsula cada 8 horas con alimentos', 5),
(6, 'Ibuprofeno 600mg', '1 tableta cada 8 horas después de comidas', 5),
(7, 'Ácido Fólico 1mg + Hierro', '1 tableta diaria en ayunas', 90),
(7, 'Carbonato de Calcio 600mg', '1 tableta al día con el almuerzo', 90),
(10, 'Amoxicilina + Ácido Clavulánico 875/125mg', '1 tableta cada 12 horas vía oral', 7),
(11, 'Levotiroxina Sódica 75mcg', '1 tableta en ayunas 30 min antes del desayuno', 60),
(13, 'Sertralina 50mg', '1 tableta cada mañana con agua', 30),
(14, 'Esomeprazol 40mg', '1 cápsula en ayunas por 28 días', 28),
(15, 'Tamsulosina 0.4mg', '1 cápsula en la noche', 15);

/* Directorio Profesional de Médicos: Generar el directorio completo indicando
 el nombre del médico, tipo de médico (General o Especialista), número de tarjeta
 profesional, correo electrónico y el nombre de la especialidad clínica asignada
 (utilizando LEFT JOIN para incluir a los médicos generales que no tienen una especialidad asignada).*/
 
select m.nombre_medico,m.tipo_medico,m.tarjeta_profesional,m.correo,es.nombre_especialidad from medicos m 
left join especialidades es on es.id_especialidad=m.id_especialidad; 


/* Citas y su Ubicación Física: Listar las citas atendidas mostrando:
 código de la cita, nombre del paciente, nombre del médico tratante,
 fecha y hora de la cita, sede médica, número de consultorio y piso.*/
 
 select c.id_cita 'Cita',
 p.nombre_paciente 'Paciente',
 m.nombre_medico 'Medico Tratante',
 c.fecha_hora 'Fecha/hora',
 s.nombre_sede 'Sede',
 co.numero_consultorio 'Consultorio',
 co.piso 'Piso'
 from citas c 
 inner join pacientes p on p.id_paciente=c.id_paciente
 inner join medicos m on m.id_medico=c.id_medico
 inner join consultorios co on co.id_consultorio=c.id_consultorio
 inner join sedes s on s.id_sede=co.id_sede;
 
 /* 
 Diagnósticos y Atenciones por Paciente: Consultar los expedientes
 clínicos registrados mostrando: nombre del paciente, documento,
 fecha de atención, nombre del médico que lo atendió y el diagnóstico emitido.
 */
 
 select p.nombre_paciente 'Paciente',
p.documento 'Documento',
c.fecha_hora 'Fecha/Hora',
m.nombre_medico 'Medico',
hc.diagnostico 'Diagnostico'
 from pacientes p
 inner join citas c on c.id_paciente=p.id_paciente
 inner join medicos  m on m.id_medico=c.id_medico
 inner join historias_clinicas hc on hc.id_cita=c.id_cita;
 
 /* Prescripción Farmacológica Detallada: Generar el detalle de prescripciones
 médicas con: nombre del paciente, diagnóstico registrado, nombre comercial/genérico
 del medicamento prescrito, dosis indicada y días de tratamiento.*/
 
 
 select p.nombre_paciente 'Paciente',
 hc.diagnostico 'Diagnostico',
 rm.medicamento 'Medicamento Recetado',
 rm.dosis 'Dosis indicada',
 rm.duracion_dias 'Dias de tratamiento'
 from pacientes p 
 inner join citas c on c.id_paciente=p.id_paciente
 inner join historias_clinicas hc on hc.id_cita=c.id_cita
 inner join recetas_medicas rm on rm.id_historia=hc.id_historia;
 
/* Auditoría de Pacientes sin Citas Registradas (LEFT JOIN):
Identificar a los pacientes registrados en el sistema que nunca
han agendado ni solicitado una cita médica.*/

select p.nombre_paciente 'Paciente',
p.documento 'Documento',
p.telefono 'Telefono',
p.ciudad 'Ciudad'
from pacientes p
left join citas c on p.id_paciente = c.id_paciente
where c.id_cita is null;


/* Consultorios sin Uso Clínico (RIGHT JOIN / LEFT JOIN):
Identificar qué consultorios (número, piso y nombre de sede)
no registran asignación en ninguna cita médica del sistema.*/

select co.numero_consultorio 'Consultorio',
co.piso 'Piso',
s.nombre_sede 'Sede',
s.ciudad 'Ciudad'
from consultorios co
left join citas c on co.id_consultorio = c.id_consultorio
inner join sedes s on co.id_sede = s.id_sede
where c.id_cita is null;


/* Tratamientos de Larga Duración: Listar el nombre del paciente,
médico tratante, especialidad médica y medicamento recetado para
aquellos tratamientos médicos que superen los 15 días de duración.*/

select p.nombre_paciente 'Paciente',
m.nombre_medico 'Medico Tratante',
e.nombre_especialidad 'Especialidad',
rm.medicamento 'Medicamento',
rm.duracion_dias 'Dias de Tratamiento'
from pacientes p
inner join citas c on p.id_paciente = c.id_paciente
inner join medicos m on c.id_medico = m.id_medico
inner join especialidades e on m.id_especialidad = e.id_especialidad
inner join historias_clinicas hc on c.id_cita = hc.id_cita
inner join recetas_medicas rm on hc.id_historia = rm.id_historia
where rm.duracion_dias > 15;


/* Pacientes Multiespecialidad: Obtener el listado de pacientes que
han sido atendidos por más de un médico especialista diferente,
mostrando el nombre del paciente, documento, nombre del médico 
y la especialidad atendida.*/

select p.nombre_paciente 'Paciente',
p.documento 'Documento',
m.nombre_medico 'Medico',
e.nombre_especialidad 'Especialidad'
from pacientes p
inner join citas c on p.id_paciente = c.id_paciente
inner join medicos m on c.id_medico = m.id_medico
inner join especialidades e on m.id_especialidad = e.id_especialidad
where m.tipo_medico = 'Especialista'
and c.estado = 'Atendida'
group by p.nombre_paciente, p.documento, m.nombre_medico, e.nombre_especialidad
having count(distinct e.id_especialidad) > 1;


/* Médicos y Disponibilidad de Agenda (LEFT JOIN): Listar todos los
médicos de la clínica junto con los identificadores y fechas de las
citas que tienen agendadas, mostrando claramente a los médicos
que no registran citas.*/

select m.nombre_medico 'Medico',
m.tipo_medico 'Tipo',
m.tarjeta_profesional 'Tarjeta Profesional',
c.id_cita 'Cita',
c.fecha_hora 'Fecha/Hora',
c.estado 'Estado'
from medicos m
left join citas c on m.id_medico = c.id_medico;


/* Trazabilidad Integral de Atención Clínica: Construir la trazabilidad
completa desde la sede hasta el medicamento: Nombre de la sede, Ciudad
de la sede, Nombre del paciente, Médico tratante, Fecha de la cita, 
Diagnóstico registrado y Medicamento recetado.*/

select s.nombre_sede 'Sede',
s.ciudad 'Ciudad',
p.nombre_paciente 'Paciente',
m.nombre_medico 'Medico',
c.fecha_hora 'Fecha Cita',
hc.diagnostico 'Diagnostico',
rm.medicamento 'Medicamento'
from citas c
inner join pacientes p on c.id_paciente = p.id_paciente
inner join medicos m on c.id_medico = m.id_medico
inner join consultorios co on c.id_consultorio = co.id_consultorio
inner join sedes s on co.id_sede = s.id_sede
inner join historias_clinicas hc on c.id_cita = hc.id_cita
inner join recetas_medicas rm on hc.id_historia = rm.id_historia;
 
 
 
 /* Productividad y Facturación por Especialidad: Calcular la cantidad
 total de citas atendidas y el valor económico total recaudado por cada
 especialidad clínica (incluyendo aquellas especialidades sin citas
 registradas mediante LEFT JOIN).
*/

select 
es.nombre_especialidad 'Especialidad',
count(c.id_cita) 'Total Citas',
sum(c.costo_consulta) 'Total Recaudado'
from especialidades es
left join medicos m on es.id_especialidad = m.id_especialidad
left join citas c on m.id_medico = c.id_medico
where c.estado = 'Atendida' or c.estado is null
group by es.nombre_especialidad;

/* Consolidado de Atención por Sede Médica: Mostrar el nombre de la sede,
 ciudad, la cantidad total de citas atendidas, el valor promedio cobrado
 por consulta y el recaudo total acumulado por sede.*/
 
select
s.nombre_sede 'Nombre Sede',
s.ciudad 'Ciudad',
count(c.id_cita) 'Citas Atendidas',
avg(c.costo_consulta) 'Promedio de Cobro',
sum(c.costo_consulta) 'Recaudo Total'
from sedes s
inner join consultorios cs on s.id_sede = cs.id_sede
inner join citas c on cs.id_consultorio = c.id_consultorio
where c.estado = "Atendida"
group by s.nombre_sede, s.ciudad;


/* Productividad Médica Individual: Determinar el número total de citas
asignadas a cada médico, el número de citas efectivamente atendidas y
el total recaudado por cada profesional de la salud.*/

select m.nombre_medico 'Medico',
m.tipo_medico 'Tipo',
count(c.id_cita) 'Total Citas Asignadas',
sum(case when c.estado = 'Atendida' then 1 else 0 end) 'Citas Atendidas',
sum(case when c.estado = 'Atendida' then c.costo_consulta else 0 end) 'Total Recaudado'
from medicos m
left join citas c on m.id_medico = c.id_medico
group by m.nombre_medico, m.tipo_medico;


/* Gasto Acumulado por Paciente: Calcular el número total de citas
agendadas y el monto económico total invertido por cada paciente en
la institución médica, ordenado de mayor a menor según el gasto total.*/

select p.nombre_paciente 'Paciente',
p.documento 'Documento',
count(c.id_cita) 'Total Citas',
sum(c.costo_consulta) 'Monto Total'
from pacientes p
inner join citas c on p.id_paciente = c.id_paciente
group by p.nombre_paciente, p.documento
order by sum(c.costo_consulta) desc;


/* Balance General de Citas por Estado: Generar un consolidado general
que muestre los diferentes estados de las citas (Atendida, Programada,
Cancelada, No Asistio), el conteo total de citas en cada estado y el
valor económico proyectado/recaudado.*/

select c.estado 'Estado',
count(c.id_cita) 'Total Citas',
sum(c.costo_consulta) 'Valor Economico'
from citas c
group by c.estado;


/* Promedio de Duración de Tratamientos Farmacológicos: Calcular el
promedio de días de duración de los tratamientos recetados y la
cantidad de medicamentos formulados, agrupados por cada especialidad
médica.*/

select e.nombre_especialidad 'Especialidad',
avg(rm.duracion_dias) 'Promedio Duracion',
count(rm.id_receta) 'Medicamentos Formulados'
from especialidades e
inner join medicos m on e.id_especialidad = m.id_especialidad
inner join citas c on m.id_medico = c.id_medico
inner join historias_clinicas hc on c.id_cita = hc.id_cita
inner join recetas_medicas rm on hc.id_historia = rm.id_historia
group by e.nombre_especialidad;


/* Carga Operativa por Sede y Tipo de Médico: Analizar la distribución
de consultas atendidas y el ingreso generado al cruzar cada sede
médica con el tipo de médico (General o Especialista).*/

select s.nombre_sede 'Sede',
s.ciudad 'Ciudad',
m.tipo_medico 'Tipo Medico',
count(c.id_cita) 'Citas Atendidas',
sum(c.costo_consulta) 'Ingreso Generado'
from sedes s
inner join consultorios co on s.id_sede = co.id_sede
inner join citas c on co.id_consultorio = c.id_consultorio
inner join medicos m on c.id_medico = m.id_medico
where c.estado = 'Atendida'
group by s.nombre_sede, s.ciudad, m.tipo_medico;


/* Sedes con Facturación Superior al Promedio (HAVING): Identificar
cuáles sedes médicas han recaudado un valor total acumulado superior
a $300,000 COP en citas atendidas, indicando el número de pacientes
distintos atendidos.*/

select s.nombre_sede 'Sede',
s.ciudad 'Ciudad',
count(distinct c.id_paciente) 'Pacientes Atendidos',
sum(c.costo_consulta) 'Total Recaudado'
from sedes s
inner join consultorios co on s.id_sede = co.id_sede
inner join citas c on co.id_consultorio = c.id_consultorio
where c.estado = 'Atendida'
group by s.nombre_sede, s.ciudad
having sum(c.costo_consulta) > 300000;


/* Pacientes Frecuentes: Identificar a los pacientes recurrentes
(aquellos que registran 2 o más citas atendidas), indicando el total
de citas, el monto total pagado y el costo promedio por consulta.*/

select p.nombre_paciente 'Paciente',
p.documento 'Documento',
count(c.id_cita) 'Total Citas',
sum(c.costo_consulta) 'Monto Total',
avg(c.costo_consulta) 'Costo Promedio'
from pacientes p
inner join citas c on p.id_paciente = c.id_paciente
where c.estado = 'Atendida'
group by p.nombre_paciente, p.documento
having count(c.id_cita) >= 2;


/* Demanda de Servicios Médicos por Ciudad de Origen: Analizar el
flujo de pacientes según su ciudad de residencia, mostrando la ciudad
del paciente, la cantidad de citas solicitadas y la facturación total
generada por cada localidad.*/

select p.ciudad 'Ciudad Paciente',
count(c.id_cita) 'Total Citas',
sum(c.costo_consulta) 'Facturacion Total'
from pacientes p
inner join citas c on p.id_paciente = c.id_paciente
group by p.ciudad;