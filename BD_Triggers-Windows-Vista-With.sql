-- Database: facultad

-- DROP DATABASE facultad;
CREATE ROLE facultad LOGIN ENCRYPTED PASSWORD 'md58d37235a347ab3b4326a267b0ff95b16'
  NOINHERIT
   VALID UNTIL 'infinity';

CREATE DATABASE facultad
  WITH OWNER = facultad
       ENCODING = 'UTF8'
       CONNECTION LIMIT = -1;


CREATE TABLE tipodocumento(
  tipodocumento VARCHAR(5) NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  CONSTRAINT pk_tipodocumento PRIMARY KEY(tipodocumento)
);
ALTER TABLE tipodocumento OWNER TO facultad;
INSERT INTO tipodocumento(tipodocumento, descripcion) VALUES('DNI', 'Documento Nacional de Identidad');
INSERT INTO tipodocumento(tipodocumento, descripcion) VALUES('LE', 'Libreta de Enrolamiento');
INSERT INTO tipodocumento(tipodocumento, descripcion) VALUES('LC', 'Libreta Cívica');

CREATE TABLE carrera(
  carrera_id CHAR(1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT pk_carrera PRIMARY KEY(carrera_id)
);
ALTER TABLE carrera OWNER TO facultad;
INSERT INTO carrera(carrera_id, nombre) VALUES('K', 'Ingeniería en Sistemas de Información');



CREATE TABLE persona(
  persona_id INT4 NOT NULL,
  tipodocumento VARCHAR(5) NOT NULL,
  documento VARCHAR(25) NOT NULL,
  apellidos VARCHAR(50) NOT NULL,
  nombres VARCHAR(50) NOT NULL,
  CONSTRAINT pk_persona PRIMARY KEY(persona_id),
  CONSTRAINT uk_persona UNIQUE(tipodocumento, documento),
  CONSTRAINT fk_persona_tipodocumento_tipodocumento FOREIGN KEY(tipodocumento) REFERENCES tipodocumento ON UPDATE RESTRICT ON DELETE RESTRICT
);
ALTER TABLE persona OWNER TO facultad;


CREATE TABLE docente(
  persona_id INT4 NOT NULL,
  legajo INT4 NOT NULL,
  dependede INT4,
  CONSTRAINT pk_docente PRIMARY KEY(persona_id),
  CONSTRAINT uk_docente UNIQUE(legajo),
  CONSTRAINT fk_docente_persona_persona_id FOREIGN KEY(persona_id) REFERENCES persona ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_docente_docente_dependede FOREIGN KEY(dependede) REFERENCES docente ON UPDATE RESTRICT ON DELETE RESTRICT
);
ALTER TABLE docente OWNER TO facultad;

CREATE TABLE alumno(
  persona_id INT4 NOT NULL,
  legajo INT4 NOT NULL,
  carrera_id CHAR(1),
  CONSTRAINT pk_alumno PRIMARY KEY(persona_id),
  CONSTRAINT uk_alumno UNIQUE(legajo),
  CONSTRAINT fk_alumno_persona_persona_id FOREIGN KEY(persona_id) REFERENCES persona ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_alumno_carrera_carrera_id FOREIGN KEY(carrera_id) REFERENCES carrera ON UPDATE RESTRICT ON DELETE RESTRICT
);
ALTER TABLE alumno OWNER TO facultad;


--insertamos las personas que son docentes
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(1, 'DNI', 1, 'Gomez', 'Alan');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(2, 'DNI', 2, 'Smith', 'Micaela');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(3, 'DNI', 3, 'Perez', 'Albert');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(4, 'DNI', 4, 'Toma', 'Alexis');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(5, 'DNI', 5, 'Jones', 'Roberto');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(6, 'DNI', 6, 'Sea', 'Susana');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(7, 'DNI', 7, 'Ada', 'Martinez');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(8, 'DNI', 8, 'Keys', 'Gonzalo');

--insertar las relaciones correspondientes a los docentes
--INSERT INTO docente(persona_id, legajo) VALUES(1, 1);
--INSERT INTO docente(persona_id, legajo, dependede) VALUES(2, 2, 1);
--INSERT INTO docente(persona_id, legajo, dependede) VALUES(3, 3, 2);
--INSERT INTO docente(persona_id, legajo, dependede) VALUES(4, 4, 3);
--INSERT INTO docente(persona_id, legajo, dependede) VALUES(5, 5, 3);
--INSERT INTO docente(persona_id, legajo, dependede) VALUES(6, 6, 3);

--insertamos las personas que son alumnos
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(101, 'DNI', 101, 'Alumno', 'Alumno 1');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(102, 'DNI', 102, 'Alumno', 'Alumno 2');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(103, 'DNI', 103, 'Alumno', 'Alumno 3');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(104, 'DNI', 104, 'Alumno', 'Alumno 4');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(105, 'DNI', 105, 'Alumno', 'Alumno 5');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(106, 'DNI', 106, 'Alumno', 'Alumno 6');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(107, 'DNI', 107, 'Alumno', 'Alumno 7');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(108, 'DNI', 108, 'Alumno', 'Alumno 8');
INSERT INTO persona(persona_id, tipodocumento, documento, apellidos, nombres) VALUES(109, 'DNI', 109, 'Alumno', 'Alumno 9');

--insertamos los alumnos
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(101, 101, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(102, 102, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(103, 103, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(104, 104, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(105, 105, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(106, 106, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(107, 107, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(108, 108, 'K');
INSERT INTO alumno(persona_id, legajo, carrera_id) VALUES(109, 109, 'K');


--creamos la tabla de cursos
CREATE TABLE curso(
  curso_id INT4 NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  horaspermregular SMALLINT NOT NULL,
  horaspermpromocion SMALLINT NOT NULL,
  horasxclase SMALLINT NOT NULL,
  CONSTRAINT pk_curso PRIMARY KEY(curso_id)
);
ALTER TABLE curso OWNER TO facultad;
COMMENT ON COLUMN curso.horaspermregular IS 'Cantidad de horas de faltas permitidas para regularizar';
COMMENT ON COLUMN curso.horaspermpromocion IS 'Cantidad de horas de faltas permitidas para promocionar';
COMMENT ON COLUMN curso.horasxclase IS 'Cantidad de horas que se dictan por clase.';

--insertamos los cursos
INSERT INTO curso(curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) VALUES(1, 'Curso 1', 8, 4, 4);
INSERT INTO curso(curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) VALUES(2, 'Curso 2', 4, 0, 4);
INSERT INTO curso(curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) VALUES(3, 'Curso 3', 8, 4, 4);
INSERT INTO curso(curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) VALUES(4, 'Curso 4', 4, 0, 4);
INSERT INTO curso(curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) VALUES(5, 'Curso 5', 8, 4, 4);


--creamos la tabla de inscripciones
CREATE TABLE inscripto(
  inscripcion_id INT4 NOT NULL,
  anio SMALLINT NOT NULL,
  fecha DATE NOT NULL,
  alumno INT NOT NULL,
  curso_id INT NOT NULL,
  CONSTRAINT pk_inscripto PRIMARY KEY(inscripcion_id),
  CONSTRAINT uk_inscriptio UNIQUE(anio, alumno, curso_id),
  CONSTRAINT fk_inscripto_alumno_alumno FOREIGN KEY(alumno) REFERENCES alumno ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_inscripto_curso_curso_id FOREIGN KEY(curso_id) REFERENCES curso ON UPDATE RESTRICT ON DELETE RESTRICT
);
ALTER TABLE inscripto OWNER TO facultad;

--insertamos las inscripciones
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(1, 2020, NOW()::DATE, 101, 1);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(2, 2020, NOW()::DATE, 102, 1);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(3, 2020, NOW()::DATE, 103, 1);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(4, 2020, NOW()::DATE, 104, 1);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(5, 2020, NOW()::DATE, 105, 1);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(6, 2020, NOW()::DATE, 101, 2);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(7, 2020, NOW()::DATE, 102, 2);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(8, 2020, NOW()::DATE, 103, 2);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(9, 2020, NOW()::DATE, 104, 2);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(10, 2020, NOW()::DATE, 105, 2);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(11, 2020, NOW()::DATE, 101, 3);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(12, 2020, NOW()::DATE, 102, 3);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(13, 2020, NOW()::DATE, 103, 3);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(14, 2020, NOW()::DATE, 104, 3);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(15, 2020, NOW()::DATE, 105, 3);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(16, 2020, NOW()::DATE, 101, 4);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(17, 2020, NOW()::DATE, 102, 4);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(18, 2020, NOW()::DATE, 103, 4);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(19, 2020, NOW()::DATE, 104, 4);
INSERT INTO inscripto(inscripcion_id, anio, fecha, alumno, curso_id) VALUES(20, 2020, NOW()::DATE, 105, 4);

--creamos la tabla de asistencias
CREATE TABLE asistencia(
  inscripcion_id INT4 NOT NULL,
  fecha DATE NOT NULL DEFAULT(NOW()::DATE),
  horas INT NOT NULL,
  CONSTRAINT pk_asistencia PRIMARY KEY(inscripcion_id, fecha),
  CONSTRAINT fk_asistencia_inscripto_inscripcion_id FOREIGN KEY(inscripcion_id) REFERENCES inscripto ON UPDATE RESTRICT ON DELETE RESTRICT
);
ALTER TABLE asistencia OWNER TO facultad;

--insertamos las asistencias
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 1, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 2, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 3, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 4, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 5, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 6, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 7, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 8, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 9, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(10, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(11, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(12, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(13, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(14, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(15, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(16, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(17, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(18, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(19, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(20, '2020-04-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 1, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 2, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 3, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 4, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 5, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 6, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 7, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 8, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 9, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(10, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(11, '2020-04-03', 0);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(12, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(13, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(14, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(15, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(16, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(17, '2020-04-03', 0);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(18, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(19, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(20, '2020-04-03', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 1, '2020-06-01', 0);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 2, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 3, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 4, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 5, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 6, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 7, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 8, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES( 9, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(10, '2020-06-01', 0);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(11, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(12, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(13, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(14, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(15, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(16, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(17, '2020-06-01', 0);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(18, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(19, '2020-06-01', 4);
INSERT INTO asistencia(inscripcion_id, fecha, horas) VALUES(20, '2020-06-01', 4);


CREATE TYPE estadocursada AS enum ('REGULAR', 'LIBRE', 'RECURSA', 'PROMOCION');

ALTER TYPE estadocursada OWNER TO facultad;


ALTER TABLE inscripto ADD COLUMN estadocursada estadocursada;
UPDATE inscripto
SET estadocursada = 'REGULAR';
ALTER TABLE inscripto ALTER COLUMN estadocursada SET NOT NULL;