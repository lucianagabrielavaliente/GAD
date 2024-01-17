CREATE TYPE TSexo AS ENUM ('M', 'F', 'X');
CREATE TYPE TipoDeDocumento AS ENUM ('DNI', 'LC', 'LE', 'DU');
CREATE TYPE TPeriodoMateria AS ENUM ('ANUAL', 'PRIMER CUATRIMESTRE','SEGUNDO CUATRIMESTRE');

CREATE TYPE TDocumento AS (
numero VARCHAR(10),
tipo TipoDeDocumento,
expedidoPor TEXT
);
CREATE TYPE TDomicilio AS (
calle TEXT,
numero SMALLINT,
piso SMALLINT,
departamento varchar(5)
);

CREATE TYPE TNombres AS (
primerNombre TEXT,
segundoNombre TEXT,
terceroNombre TEXT
);

CREATE TYPE TApellidos AS (
primerApellido TEXT,
segundoApellido TEXT,
terceroApellido TEXT,
cuartoApellido TEXT
);
CREATE TABLE Personas (
idPersona UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
Nombres TNombres,
Apellidos TApellidos,
Sexo TSexo,
Documento TDocumento,
Domicilio TDomicilio,
FechaNacimiento DATE,
Foto BYTEA,
Huella BYTEA,
Firma BYTEA
);
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('John', 'David', 'Smith'), ROW ('Doe',
'Johnson', 'Black', ''), 'M', ROW ('123456789', 'DNI', 'City'), ROW
('123 Main St', 456, 3, '12'), '1990-05-15', E'\\x0123456789ABCDEF',
E'\\x0123456789ABCDEF', E'\\x0123456789ABCDEF');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Jane', '', ''), ROW ('Smith', '', '', ''), 'F',
ROW ('987654321', 'LC', 'County'), ROW ('456 Elm St', 123, NULL, NULL),
'1988-10-20', E'\\x9876543210FEDCBA', E'\\x9876543210FEDCBA',
E'\\x9876543210FEDCBA');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Maria', 'Isabella', 'Lopez'), ROW ('Garcia',
'Martinez', 'Rodriguez', ''), 'F', ROW ('564738291', 'DNI', 'City'), ROW
('789 Oak Ave', 234, NULL, ''), '1995-03-10', E'\\xABCD1234EFFE5678',
E'\\x4567890ABCDE1234', E'\\x89AB6789CDEF2345');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Robert', '', ''), ROW ('Johnson', '', '', ''),
'M', ROW ('987654320', 'DU', 'Village'), ROW ('567 Pine Rd', 789, 2,
'S5'), '1982-07-02', E'\\x7890ABCD1234EEFF', E'\\x2345CDEF6789ABCD',
E'\\x456789AB890CDEF1');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Linda', '', ''), ROW ('Williams', '', '', ''),
'F', ROW ('546372819', 'LE', 'Countryside'), ROW ('890 Maple Ln', 456,
NULL, ''), '1976-11-25', E'\\x2345EFFF5678ABCD1',
E'\\x6789ABCD1234CDEF', E'\\x890CDEF2345ABCD1');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Michael', '', ''), ROW ('Brown', '', '', ''),
'M', ROW ('123409876', 'LC', 'Suburb'), ROW ('123 Elm Ct', 789, 1, 'Apt
8'), '1998-09-08', E'\\x6789EFFF1234ABCD', E'\\x3456CDEF8901ABCD',
E'\\x0123ABCD4567EFFF');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Emily', '', ''), ROW ('Davis', '', '', ''),
'F', ROW ('678912345', 'LE', 'Riverside'), ROW ('456 Oak Dr', 123, NULL,
''), '1985-04-17', E'\\x2345678901ABCD12', E'\\x678901AB2345CDEF',
E'\\x89012345EFFF6789');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('William', 'Jacob', 'Miller'), ROW ('Brown',
'Johnson', 'Smith', ''), 'M', ROW ('234567890', 'DNI', 'Townsville'),
ROW ('789 Pine Ave', 567, 4, 'Apt 2'), '1993-12-03',
E'\\x567890AB1234CDEF', E'\\x901234CDEF567890', E'\\xABCD5678901234EF');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('Olivia', '', ''), ROW ('Martinez', '', '', ''),
'F', ROW ('876543219', 'LC', 'Countryside'), ROW ('890 Maple St', 234,
NULL, ''), '2000-08-22', E'\\x234567890123CDEF', E'\\x9012ABCD567890EF',
E'\\x567890AB1234CDEF');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)

VALUES(ROW ('James', '', ''), ROW ('Jones', '', '', ''),
'M', ROW ('678901234', 'LC', 'Cityville'), ROW ('123 Oak Rd', 789, 2,
'Apt 7'), '1989-02-12', E'\\x901234CDEFA56789', E'\\xABCD5678901234EF',E'\\x567890AB12BCDEF3');

CREATE TABLE Alumnos (
idpersona uuid,
idcarrera uuid,
Legajo VARCHAR(10) PRIMARY KEY,
fechaIngreso DATE,
fechaEgreso DATE,
FOREIGN KEY (idPersona) REFERENCES personas(idpersona),
FOREIGN KEY (idCarrera) REFERENCES carreras(idcarrera)
);

CREATE TABLE Carreras (
idCarrera UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
Nombre TEXT,
Titulo TEXT,
Posgrado BOOLEAN
);
INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Computer Science', 'Bachelor of Science in Computer Science',
FALSE);
INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Electrical Engineering', 'Bachelor of Engineering in Electrical
Engineering', FALSE);
INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Business Administration', 'Bachelor of Business
Administration', FALSE);
INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Data Science', 'Master of Science in Data Science', TRUE);
INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Mechanical Engineering', 'Bachelor of Engineering in Mechanical
Engineering', FALSE);

CREATE TYPE TAnio AS ENUM ('1', '2', '3', '4', '5' );
CREATE TABLE Materias (
idMateria UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
idCarrera uuid,
Nombre TEXT,
Anio tanio,
Periodo tperiodomateria,
Costo MONEY,
FOREIGN KEY (idCarrera) REFERENCES carreras(idCarrera)
);

CREATE TABLE Correlativas (
idMateriaRequerida uuid,
idMateria uuid,
PRIMARY KEY (idMateriaRequerida,idMateria),
FOREIGN KEY (idMateriaRequerida) REFERENCES materias (idMateria),
FOREIGN KEY (idMateria) REFERENCES materias (idMateria)
);

CREATE TYPE TNota AS ENUM ('1', '2', '3', '4', '5', '6', '7', '8', '9',
'10');
CREATE TYPE TEstado AS ENUM ('Desaprobado', 'Aprobado');
CREATE TABLE ExamenesFinales (
idExamen UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
idMateria uuid,
Legajo VARCHAR(10),
Fecha DATE,
Nota tnota,
Estado testado,
NumeroActa TEXT,
FOREIGN KEY (idMateria) REFERENCES materias (idMateria)
);

INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)
VALUES (ROW('Lucia','Ines',''), ROW('Thea','','',''), 'F',
ROW('42487133', 'DNI', 'Registro Civil'), ROW('Falsa', 123, NULL,
NULL),'2000-04-27', E'\\x0123456789ABCDEF', E'\\x0123456789ABCDEF',
E'\\x0123456789ABCDEF');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)
VALUES (ROW('Luciana','Gabriela',''), ROW('Valiente','','',''), 'F',
ROW('42355692', 'DNI', 'Registro Civil'), ROW('Falsa', 123, NULL,
NULL),'2000-02-27', E'\\x9876543210FEDCBA', E'\\x9876543210FEDCBA',
E'\\x9876543210FEDCBA');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)
VALUES (ROW('Martin', 'Rodrigo',''),ROW('Lopez','','','') , 'M',
ROW('41058957', 'DNI', 'Registro Civil'), ROW('Falsa', 123, NULL,
NULL),'1999-01-16', E'\\xABCD1234EFFE5678', E'\\x4567890ABCDE1234',
E'\\x89AB6789CDEF2345');
INSERT INTO Personas (Nombres, Apellidos, Sexo, Documento, Domicilio,
FechaNacimiento, Foto, Huella, Firma)
VALUES (ROW('Renato', '',''),ROW('Corbellini','Pezzatti','','') , 'M',
ROW('95889617', 'DNI', 'Registro Civil'), ROW('LaVa-gancia', 123, NULL,
NULL),'2000-05-03', E'\\xABCD1234EFFE5678', E'\\x4567890ABCDE1234',
E'\\x89AB6789CDEF2345');

INSERT INTO Carreras (Nombre, Titulo, Posgrado)
VALUES ('Ingeniería Gerencial', 'Especialista en Ingeniería Gerencial',

TRUE);
INSERT INTO Materias (idCarrera, Nombre,Anio, Periodo, Costo) VALUES
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Fundamentos de Ingeniería
Gerencial','1','ANUAL', 1000.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Análisis Financiero para
la Toma de Decisiones','2','PRIMER CUATRIMESTRE', 1200.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Gestión de Operaciones y
Cadena de Suministro','2','SEGUNDO CUATRIMESTRE', 1100.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Estrategia Empresarial y
Competitividad','3','PRIMER CUATRIMESTRE', 1300.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Gestión de Recursos
Humanos y Liderazgo','3','SEGUNDO CUATRIMESTRE', 1000.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Marketing Estratégico y
Gestión Comercial','3','SEGUNDO CUATRIMESTRE', 1200.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Gestión de la Innovación y
Tecnología','4','ANUAL', 1300.00),
('1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 'Ética Empresarial y
Responsabilidad Social','5','ANUAL', 1000.00);

INSERT INTO Correlativas (idMateriaRequerida, idMateria)
VALUES
('9e005fd9-22c1-48aa-921a-1f52f7a878ad',
'7ff21ff1-102f-43ae-89f7-a7f19ab85ba0'),
('7ff21ff1-102f-43ae-89f7-a7f19ab85ba0',
'abc42a1a-9001-47bd-8cde-d52f61bd8b86'),
('f2f83088-d2cf-41d8-b9a6-8afa97ca8d02',
'eec141a2-c9bb-4056-a7e5-4ff87ae11826'),
('eec141a2-c9bb-4056-a7e5-4ff87ae11826',
'551fa557-f31b-4e04-aae1-8b4128059cdd'),
('551fa557-f31b-4e04-aae1-8b4128059cdd',
'759e3479-5357-4150-ab98-3dab320d5321'),
('d96d5add-02c1-4197-9591-442ba14e449f',
'd0989ff9-1456-4a67-95a2-ad9a77f27566'),
('993b9b9a-7698-4537-9b92-faa7770820ca',
'e529b6e6-d8a2-4c86-b1bb-9124489aa3e2'),
('e529b6e6-d8a2-4c86-b1bb-9124489aa3e2',
'6458d954-5369-420e-b0e5-7de9dc3e423b'),
('6458d954-5369-420e-b0e5-7de9dc3e423b',
'472104c8-5d07-4139-95a1-1dfd69edc2a2'),
('472104c8-5d07-4139-95a1-1dfd69edc2a2',
'06ec2f3a-3f75-4bc6-acd1-1612112bcc22'),
('06ec2f3a-3f75-4bc6-acd1-1612112bcc22',
'bc57950b-dea1-4b3d-925b-85e52ded88a2'),
('bc57950b-dea1-4b3d-925b-85e52ded88a2',
'34feab13-6b3e-40a4-ab4a-64ef18f06e7c');

INSERT INTO Alumnos (idpersona, idcarrera, Legajo,
fechaIngreso,fechaegreso)
VALUES
('36c37e22-a785-4e77-94fc-51e3c881bae7',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000001, NOW(), NULL),
('775592da-f8e4-4c5a-85fb-49224c78f87e',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000002, NOW(), NULL),
('ab051b9c-3515-4c8a-8ea0-3767c185532c',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000003, NOW(), NULL),
('58becc0e-3904-4802-a373-c7399efbfaa8',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000004, NOW(), NULL),
('fb68ccc3-b3ea-461d-acec-9367277e94bf',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000005, NOW(), NULL),
('d1f6877f-2e8f-4244-a097-d04866927ca6',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000006, NOW(), NULL),
('1eae94bf-f6f4-460a-8c5e-7736a78b3603',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000007, NOW(), NULL),
('2bd176f8-af5e-4e9f-9d36-7d9e0ddb5519',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000008, NOW(), NULL),
('ae1b7d17-81f9-4890-92d4-7e65d6c7f616',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000009, NOW(), NULL),
('4c58c570-df51-46da-8efb-28e89cfd5d8f',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000010, NOW(), NULL),
('77240fc6-98ad-4a84-ab04-ac555799b463',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000011, NOW(), NULL),
('d2ebaf89-20b4-4a7a-9ae5-433e4bc7f594',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000012, NOW(), NULL),
('7073e946-b943-429b-bc6f-5d448ab8bca6',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000013, NOW(), NULL),
('bcb8cfd8-e6ac-4f92-8014-31d2121fe6e8',
'1f099d05-047e-4eb1-8e2e-772f1ebcc74c', 14000014, NOW(), NULL);

INSERT INTO ExamenesFinales (idMateria, Legajo, Fecha, Nota, Estado,
NumeroActa)
VALUES
('c8be46e2-9de8-4ea6-8818-2b9138b24ea0', '14000101', '2023-06-01',
'9', 'Aprobado', '2023-123'),
('de16b774-8893-4fb7-bb12-800c54915113', '14000102', '2023-06-15',
'7', 'Aprobado', '2023-124'),
('744f599e-17ad-498d-a622-46b35b13d8f3', '14000103', '2023-07-05',
'5', 'Desaprobado', '2023-125'),
('0721217c-d5a6-4c5f-a763-9c55bb4618d7', '14000104', '2023-06-10',
'8', 'Aprobado', '2023-126'),
('d96d5add-02c1-4197-9591-442ba14e449f', '14000105', '2023-06-28',
'10', 'Aprobado', '2023-127'),
('cc2094da-9d67-4955-a954-5fe2e4ad862e', '14000106', '2023-07-02',
'1', 'Desaprobado', '2023-128'),
('de16b774-8893-4fb7-bb12-800c54915113', '14000107', '2023-07-15',
'7', 'Aprobado', '2023-129'),
('744f599e-17ad-498d-a622-46b35b13d8f3', '14000108', '2023-06-18',
'9', 'Aprobado', '2023-130'),
('0721217c-d5a6-4c5f-a763-9c55bb4618d7', '14000109', '2023-07-08',
'2', 'Desaprobado', '2023-131'),
('d96d5add-02c1-4197-9591-442ba14e449f', '14000110', '2023-06-20',
'8', 'Aprobado', '2023-132'),
('cc2094da-9d67-4955-a954-5fe2e4ad862e', '14000111', '2023-07-02',
'7', 'Aprobado', '2023-133'),
('de16b774-8893-4fb7-bb12-800c54915113', '14000112', '2023-06-30',
'3', 'Desaprobado', '2023-134'),
('744f599e-17ad-498d-a622-46b35b13d8f3', '14000113', '2023-07-10',
'9', 'Aprobado', '2023-135'),
('0721217c-d5a6-4c5f-a763-9c55bb4618d7', '14000114', '2023-07-22',
'8', 'Aprobado', '2023-136'),
('5466a4ba-3c0c-4f9c-aa9f-5337c3f468d8', '14000104', '2023-07-18',
'4', 'Desaprobado', '2023-137'),
('759e3479-5357-4150-ab98-3dab320d5321', '14000105', '2023-07-04',
'10', 'Aprobado', '2023-138'),
('551fa557-f31b-4e04-aae1-8b4128059cdd', '14000105', '2023-07-06',
'3', 'Desaprobado', '2023-139'),
('5466a4ba-3c0c-4f9c-aa9f-5337c3f468d8', '14000104', '2023-07-12',
'3', 'Desaprobado', '2023-140'),
('7ff21ff1-102f-43ae-89f7-a7f19ab85ba0', '14000105', '2023-07-24',
'8', 'Aprobado', '2023-141'),
('551fa557-f31b-4e04-aae1-8b4128059cdd', '14000105', '2023-07-30',
'9', 'Aprobado', '2023-142');

-- Cantidad de alumnos que cursan o cursaron una carrera a una fecha dada (se
-- ingresa el idCarrera y la Fecha)

WITH cte AS (
SELECT
'ef1428d1-f150-46dc-a349-f32fb3b43781'::UUID AS idCarrera,
'2022-08-14'::DATE AS fecha

)
SELECT
c.Nombre AS NombreCarrera,
COALESCE(a.CantidadAlumnos, 0) AS CantidadAlumnos
FROM
Carreras c
LEFT JOIN (
SELECT
idCarrera,
COALESCE(COUNT(Legajo), 0) AS CantidadAlumnos
FROM
Alumnos
WHERE
idCarrera = (SELECT idCarrera FROM cte)
AND(SELECT fecha FROM cte) BETWEEN fechaIngreso
AND COALESCE(fechaEgreso, (SELECT fecha FROM

cte))

GROUP BY
idCarrera) a ON c.idCarrera = a.idCarrera

WHERE
c.idCarrera = (SELECT idCarrera FROM cte);

-- Costo total de una carrera (se ingresa el idCarrera)
WITH cte AS (
SELECT
'72b74b7a-05bd-490a-ab16-4b2e6b1b69a1'::UUID AS idCarrera,

)
SELECT

c.Nombre AS NombreCarrera,
COALESCE(SUM(m.Costo), 0::MONEY) AS CostoTotalCarrera
FROM
Carreras c
LEFT JOIN (
SELECT
idCarrera,
COALESCE(SUM(m.Costo), 0::MONEY) AS Costo
FROM
Materias m
GROUP BY
idCarrera) m ON c.idCarrera = m.idCarrera

WHERE
c.idCarrera = (SELECT idCarrera FROM cte)
GROUP BY c.Nombre;

-- Promedio de notas de un alumno (solo los aprobados) (se ingresa el idPersona y
-- el idCarrera)

WITH cte AS (
SELECT
'ef1428d1-f150-46dc-a349-f32fb3b43781'::UUID AS idCarrera,
'358aea12-d080-40f4-8daf-8b8539de429d'::UUID AS idPersona

)
SELECT
CONCAT((p.nombres).primernombre, ' ',
(p.apellidos).primerapellido) as NombreApellido,
a.legajo as Legajo,
AVG(ef.Nota::TEXT:: NUMERIC)::NUMERIC(10, 2) as
PromedioNotasAprobadas
FROM
examenesfinales ef
JOIN alumnos a ON ef.legajo = a.legajo
JOIN personas p ON a.idpersona = p.idpersona
WHERE
a.idpersona = (SELECT idPersona FROM cte)
AND a.idCarrera = (SELECT idCarrera FROM cte)
AND ef.Nota::TEXT:: NUMERIC >= 6
AND ef.Estado = 'Aprobado'
GROUP BY
(p.nombres).primernombre,
a.legajo,
(p.apellidos).primerapellido;

-- Promedio de notas de un alumno (todas las notas) (se ingresa el idPersona y el
-- idCarrera)

WITH cte AS (
SELECT
'ef1428d1-f150-46dc-a349-f32fb3b43781'::UUID AS idCarrera,
'b73cd886-5330-4692-961d-2229386a015c'::UUID AS idPersona

)
SELECT
CONCAT((p.nombres).primernombre, ' ',
(p.apellidos).primerapellido) as NombreApellido,
a.legajo as Legajo,
AVG(ef.Nota::TEXT:: NUMERIC)::NUMERIC(10, 2) as
PromedioNotasAprobadas
FROM
examenesfinales ef
JOIN alumnos a ON ef.legajo = a.legajo
JOIN personas p ON a.idpersona = p.idpersona
WHERE
a.idpersona = (SELECT idPersona FROM cte)
AND a.idCarrera = (SELECT idCarrera FROM cte)
GROUP BY
(p.nombres).primernombre,
a.legajo,
(p.apellidos).primerapellido;

-- Documento (tipo, número, etc) de un alumno (se ingresa el Legajo)

WITH cte AS (
SELECT
'14000001' AS legajo

)
SELECT
(p.documento).tipo AS tipodocumento,
(p.documento).numero AS numerodocumento,
(p.documento).expedidopor AS expedidopor
FROM
Alumnos A
INNER JOIN Personas P ON A.idPersona = P.idPersona
WHERE
A.Legajo = (SELECT legajo from cte);

-- Lista de alumnos (Apellido y Nombres, Legajo, Nota) que aprobaron una materia,
-- entre fechas (se ingresa el idMateria y las fechas)

SELECT
CONCAT_WS(' ', (P.Nombres).primerNombre,
(P.Nombres).segundoNombre, (P.Nombres).terceroNombre,
(P.Apellidos).primerApellido, (P.Apellidos).segundoApellido,
(P.Apellidos).terceroApellido, (P.Apellidos).cuartoApellido) AS
NombreCompleto,
A.Legajo,
EF.Nota
FROM
ExamenesFinales EF
JOIN Alumnos A ON EF.Legajo = A.Legajo
JOIN Personas P ON A.idPersona = P.idPersona
WHERE
EF.idMateria = '368969f3-ca4e-4608-a699-b1a0cf83fde7'
AND EF.Fecha >= '2020-08-05'
AND EF.Fecha <= '2023-08-05'
AND EF.Estado = 'Aprobado';

--Materias (idMateria, Nombre, Año, Periodo) que hay que aprobar para poder
-- cursar una materia dada (se ingresa el idMateria).

SELECT
m.idMateria,
ma.idCarrera,
m.Nombre,
m.Anio,
m.Periodo,
m.Costo
FROM
Correlativas cr
JOIN Materias m ON cr.idMateria = m.idMateria
JOIN Materias ma ON cr.idMateriaRequerida = ma.idMateria
WHERE ma.idMateria = '759e3479-5357-4150-ab98-3dab320d5321'
UNION
SELECT
m2.idMateria,
m2.idCarrera,
m2.Nombre,
m2.Anio,
m2.Periodo,
m2.Costo
FROM
Correlativas cr
JOIN Materias m ON cr.idMateria = m.idMateria
JOIN Materias ma ON cr.idMateriaRequerida = ma.idMateria
JOIN Correlativas cr2 ON ma.idMateria = cr2.idMateria
JOIN Materias m2 ON cr2.idMateriaRequerida = m2.idMateria;

-- Costo total de las materias que debe cursar y aprobar un alumno para poder
-- cursar una materia dada (se ingresa el Legajo y el idMateria). Tener en cuenta que
-- el alumno puede haber aprobado algunas materias.
SELECT
SUM(m.Costo) AS CostoTotal
FROM
Correlativas c
JOIN Materias m ON c.idMateriaRequerida = m.idMateria
LEFT JOIN ExamenesFinales e ON c.idMateriaRequerida = e.idMateria
AND e.Legajo = '14000004'
AND e.Estado = 'Aprobado'

WHERE
c.idMateria = '368969f3-ca4e-4608-a699-b1a0cf83fde7'
AND(e.idExamen IS NULL
OR e.idExamen IS NOT NULL);