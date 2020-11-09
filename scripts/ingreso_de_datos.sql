USE NBA_BDD
GO

--EMPEZAMOS A SEPARAR LAS TABLAS
--ACA CARGAMOS PAIS
BEGIN TRAN
INSERT INTO pais(id_pais, nombre)
SELECT DISTINCT idPais, pais FROM datos 
COMMIT


--ACA CARGAMOS CONFERENCIA
BEGIN TRAN
INSERT INTO conferencia(nombre)
SELECT DISTINCT equipo_conferencia FROM datos
COMMIT

--------

-- ACTUALIZAMOS DATOS DE CONFERENCIA EN LA TABLA DATOS
BEGIN TRAN
UPDATE datos SET datos.id_conferencia = conferencia.id_conferencia 
FROM datos INNER JOIN conferencia 
ON datos.equipo_conferencia = conferencia.nombre
COMMIT 

-------- YATRA
--ACA CARGAMOS DIVISION
BEGIN TRAN 
INSERT INTO division(nombre, id_conferencia)
SELECT DISTINCT equipo_division, id_conferencia FROM datos
COMMIT

--------

--ACTUALIZAMOS DATOS DE DIVISION EN LA TABLA DATOS --COMUNISM
BEGIN TRAN 
UPDATE datos SET datos.id_division = division.id_division 
FROM datos INNER JOIN division
ON datos.equipo_division = division.nombre
COMMIT 
--------
--SEGUIMOS SEPARANDO LAS TABLAS
--ACA CARGAMOS CIUDAD
BEGIN TRAN
INSERT INTO ciudad(id_ciudad, nombre)
SELECT DISTINCT equipo_idCiudad,equipo_ciudad FROM datos 
COMMIT
--ACA CARGAMOS JUGADOR
BEGIN TRAN
INSERT INTO jugador(id_jugador, codigo, nombre, apellido, altura, peso, id_pais, draft_year, posicion)
SELECT DISTINCT jugador_id, jugador_codigo, nombre, apellido, altura, peso, idPais, draft_year, posicion FROM datos
COMMIT
--ACA CARGAMOS TEMPORADA
BEGIN TRAN
INSERT INTO temporada(id_temporada, descripcion)
SELECT DISTINCT	temporada_id, temporada_descripcion FROM datos
COMMIT
--ACA CARGAMOS EQUIPO
BEGIN TRAN 
INSERT INTO equipo(id_equipo, nombre, codigo, acronimo, id_ciudad, id_division)
SELECT DISTINCT equipo_id, equipo_nombre, equipo_codigo, equipo_sigla, equipo_idCiudad, id_division FROM datos
COMMIT
----
--ACA CARGAMOS CONTRATA
BEGIN TRAN
INSERT INTO contrata(id_jugador, id_equipo, id_temporada, nro_camiseta)
SELECT DISTINCT jugador_id, equipo_id, temporada_id, caminseta FROM datos
COMMIT

--actualizamos y le seteamos el id del ganador
BEGIN TRAN
UPDATE datos 
SET id_ganador = case 
					WHEN resultado LIKE 'Won' THEN datos.equipo_id
					WHEN resultado LIKE 'Lost' THEN datos.equipoOP_id
				END
COMMIT

--ACA CARGAMOS PARTIDO
BEGIN TRAN
INSERT INTO partido(id_partido, fecha, id_temporada, id_ganador)
SELECT DISTINCT partido_id, fecha, temporada_id, id_ganador FROM datos
COMMIT

--ACA CARGAMOS PARTIDOXEQUIPO discriminando si son locales o visitantes.
BEGIN TRAN
INSERT INTO partidoxequipo(id_partido, id_equipo, puntos, esLocal) 
SELECT DISTINCT partido_id, equipo_id, equipo_puntos, esLocal FROM datos WHERE datos.esLocal LIKE 'True'
COMMIT

BEGIN TRAN
INSERT INTO partidoxequipo(id_partido, id_equipo, puntos, esLocal) 
SELECT DISTINCT partido_id, equipo_id, equipo_puntos, esLocal FROM datos WHERE datos.esLocal LIKE 'False'
COMMIT

--ACA CARGAMOS ESTADISTICA
BEGIN TRAN
INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_asistencias_id, stat_asistencias_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_bloqueos_id, stat_bloqueos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_rebotes_defensivos_id, stat_rebotes_defensivos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_intentos_id, stat_tiros_intentos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_convertidos_id, stat_tiros_convertidos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_faltas_id, stat_faltas_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_libres_intentos_id, stat_tiros_libres_intentos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_libres_convertidos_id, stat_tiros_libres_convertidos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_minutos_id, stat_minutos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_rebotes_ofensivos_id, stat_rebotes_ofensivos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_puntos_id, stat_puntos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_segundos_id, stat_segundos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_robos_id, stat_robos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_triples_intentos_id, stat_tiros_triples_intentos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_tiros_triples_convertidos_id, stat_tiros_triples_convertidos_nombre FROM datos

INSERT INTO estadistica (id_estadistica, descripcion)
SELECT DISTINCT stat_perdidas_id, stat_perdidas_nombre FROM datos

COMMIT

--ACA CARGAMOS REGISTRO
BEGIN TRAN
INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_asistencias_id, stat_asistencias_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_bloqueos_id, stat_bloqueos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_rebotes_defensivos_id, stat_rebotes_defensivos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_intentos_id, stat_tiros_intentos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_convertidos_id, stat_tiros_convertidos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_faltas_id, stat_faltas_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_libres_intentos_id, stat_tiros_libres_intentos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_libres_convertidos_id, stat_tiros_libres_convertidos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_minutos_id, stat_minutos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_rebotes_ofensivos_id, stat_rebotes_ofensivos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_puntos_id, stat_puntos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_segundos_id, stat_segundos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_robos_id, stat_robos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_triples_intentos_id, stat_tiros_triples_intentos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_tiros_triples_convertidos_id, stat_tiros_triples_convertidos_valor from datos

INSERT INTO registro (id_jugador, id_partido, id_estadistica, valor)
SELECT DISTINCT jugador_id, partido_id, stat_perdidas_id, stat_perdidas_valor from datos

COMMIT


