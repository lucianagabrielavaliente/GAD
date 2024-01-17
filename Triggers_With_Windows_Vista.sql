-- Al momento de dar de alta una inscripción, el estadocursada siempre tiene
-- que ser REGULAR.
CREATE OR REPLACE FUNCTION asegurar_estado_regular()
RETURNS TRIGGER AS $$
BEGIN
NEW.estadocursada = 'REGULAR';
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_asegurar_estado_regular
BEFORE INSERT ON inscripto
FOR EACH ROW
EXECUTE FUNCTION asegurar_estado_regular();

-- Cuando se actualice la inscripción, se debe controlar que puede pasar a
-- PROMOCION si la cantidad de inasistencias es menor o igual a
-- horaspermpromocion del curso correspondiente.
CREATE OR REPLACE FUNCTION CALCULAR_HORAS_FALTAS (INSCRIPCION_ID INT4)
RETURNS INT4 AS $$
DECLARE
total_inasistencias INT4 := 0;
horas_por_clase INT4;
BEGIN
-- Obtener las horas por clase para la inscripción
SELECT hx.horasxclase INTO horas_por_clase
FROM curso hx
WHERE hx.curso_id = (
SELECT i.curso_id FROM inscripto i
WHERE
i.inscripcion_id = calcular_horas_faltas.inscripcion_id);
-- Calcular la suma de inasistencias en horas para la inscripción
SELECT SUM(horas) INTO total_inasistencias FROM asistencia a
WHERE
a.inscripcion_id = calcular_horas_faltas.inscripcion_id;
RETURN horas_por_clase - total_inasistencias;
END;
$$ LANGUAGE PLPGSQL;
-- Función que actualiza el estado de la cursada
CREATE OR REPLACE FUNCTION ACTUALIZAR_ESTADO_CURSADA() RETURNS TRIGGER
AS $$
BEGIN
DECLARE
horas_faltantes INT4;
BEGIN
-- Llamar a la función
horas_faltantes := CALCULAR_HORAS_FALTAS(NEW.inscripcion_id);
-- Actualizamos el estado de cursada
IF horas_faltantes <= (SELECT horaspermpromocion FROM curso WHERE
curso_id = NEW.curso_id) THEN
NEW.estadocursada := 'PROMOCION';
ELSE
NEW.estadocursada := 'REGULAR';
END IF;
RETURN NEW;
END;
END;
$$ LANGUAGE PLPGSQL;
-- Trigger
CREATE TRIGGER ACTUALIZAR_CURSADA_PROMOCION AFTER
INSERT OR UPDATE ON INSCRIPTO
FOR EACH ROW EXECUTE FUNCTION ACTUALIZAR_ESTADO_CURSADA();

--Cuando la cantidad de inasistencias sobrepase horaspermregular el estado
--de la inscripción debe pasar a LIBRE.
c. Cuando la cantidad de inasistencias sobrepase horaspermregular el estado
de la inscripción debe pasar a LIBRE.

CREATE OR REPLACE FUNCTION ACTUALIZAR_ESTADO_CURSADA_LIBRE() RETURNS
TRIGGER AS $$
BEGIN
DECLARE
horas_faltantes INT4;
BEGIN
-- Llamó a la función
horas_faltantes := CALCULAR_HORAS_FALTAS(NEW.inscripcion_id);
-- Actualizo el estado de la cursada a LIBRE
IF horas_faltantes > (SELECT horaspermregular FROM curso WHERE
curso_id = NEW.curso_id) THEN
NEW.estadocursada := 'LIBRE';
END IF;
RETURN NEW;
END;
END;
$$ LANGUAGE PLPGSQL;
-- Trigger
CREATE TRIGGER ACTUALIZAR_CURSADA_LIBRE AFTER
INSERT
OR
UPDATE ON INSCRIPTO
FOR EACH ROW EXECUTE FUNCTION ACTUALIZAR_ESTADO_CURSADA_LIBRE();

--Escriba una regla de integridad que evite que se ingresen bucles en la jerarquía
-- docente. Por ejemplo: si B depende de A y A depende de C, entonces C no puede
-- depender de A. Otro ejemplo más sencillo: si B depende de A, A no puede depender
-- de B. Tampoco se debe permitir que un nodo hijo tenga más de un padre.

RETURNS TRIGGER AS $$
DECLARE
cnt INTEGER;
parent_count INTEGER;
BEGIN
IF NEW.persona_id = NEW.dependede THEN
RAISE EXCEPTION 'No se permite que un docente dependa de sí

mismo';
END IF;
WITH RECURSIVE DocenteHierarchy AS (
SELECT
persona_id,
dependede
FROM
docente
WHERE
persona_id = NEW.dependede
UNION ALL
SELECT
d.persona_id,
d.dependede
FROM
docente d

INNER JOIN DocenteHierarchy h ON d.persona_id =

h.dependede
)
SELECT
COUNT(*) INTO STRICT cnt
FROM
DocenteHierarchy
WHERE
persona_id = NEW.persona_id;
IF cnt > 0 THEN
RAISE EXCEPTION 'Se encontró un bucle en la jerarquía

docente';
END IF;
SELECT
COUNT(*) INTO STRICT parent_count
FROM
docente
WHERE
persona_id = NEW.persona_id
AND dependede IS NOT NULL;
IF parent_count > 0 THEN
RAISE EXCEPTION 'El docente ya tiene uno asignado';
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

BEFORE INSERT
OR
UPDATE
ON docente FOR EACH ROW EXECUTE FUNCTION check_docente_hierarchy
();

--Utilizando WITH listar los alumnos que menos faltas en horas tuvieron durante el
-- 2014.

WITH TotalFaltas AS (
SELECT
i.alumno,
SUM(a.horas) AS total_faltas
FROM

inscripto i
JOIN
asistencia a ON i.inscripcion_id = a.inscripcion_id
WHERE
i.anio = 2014
GROUP BY
i.alumno
)
SELECT
p.apellidos,
p.nombres,
tf.total_faltas
FROM
persona p
JOIN
alumno a ON p.persona_id = a.persona_id
JOIN
TotalFaltas tf ON a.persona_id = tf.alumno
ORDER BY
tf.total_faltas ASC;

--Utilizando WITH listar los docentes cuyo salario se encuentre en el rango de la
-- media y la desviación estándar.
WITH SalariosDocentes AS (
SELECT
persona_id,
legajo,
salario,
AVG(salario) OVER () AS salario_promedio,
STDDEV(salario) OVER () AS desviacion_estandar
FROM docente
)
SELECT
persona_id,
legajo,
salario
FROM SalariosDocentes
WHERE salario >= salario_promedio - desviacion_estandar
AND salario <= salario_promedio + desviacion_estandar;

--Escribir una función que dadas dos personas X e Y, devuelva verdadero si X
--depende directa o indirectamente de Y.
CREATE OR REPLACE FUNCTION depende_de(X INT, Y INT) RETURNS BOOLEAN AS
$$
DECLARE
depende BOOLEAN := FALSE;
rec RECORD;
BEGIN
-- Verificar si X depende directamente de Y
SELECT TRUE INTO depende
FROM docente
WHERE persona_id = X AND dependede = Y;
IF depende THEN
RETURN TRUE;
ELSE
-- Buscar dependencias indirectas usando recursión
FOR rec IN
SELECT persona_id
FROM docente
WHERE dependede = Y
LOOP
IF depende_de(X, rec.persona_id) THEN
RETURN TRUE;
END IF;
END LOOP;
END IF;
RETURN FALSE;
END;
$$ LANGUAGE plpgsql;