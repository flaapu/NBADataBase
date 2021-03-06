CREATE DATABASE NBA_BDD
GO

USE NBA_BDD
GO

create table datos(
equipoOP_ciudad varchar(50),
equipoOP_codigo varchar(30),
equipoOP_sigla varchar(5),
equipoOP_conferencia varchar(20),
equipoOP_division varchar(20),
equipoOP_id INT,
equipoOP_nombre varchar(50),
stat_asistencias_id INT,
stat_asistencias_nombre varchar(50),
stat_asistencias_valor INT,
stat_bloqueos_id INT,
stat_bloqueos_nombre varchar(50),
stat_bloqueos_valor INT,
equipo_ciudad varchar(50),
jugador_codigo varchar(40),
pais varchar(100),
stat_rebotes_defensivos_id INT,
stat_rebotes_defensivos_nombre varchar(50),
stat_rebotes_defensivos_valor int,
equipo_sigla varchar(5),
equipo_conferencia varchar(20),
nombre_completo varchar(100),
equipo_division varchar(20),
draft_year int,
fecha datetime,
stat_tiros_intentos_id INT,
stat_tiros_intentos_nombre varchar(50),
stat_tiros_intentos_valor int,
stat_tiros_convertidos_id INT,
stat_tiros_convertidos_nombre varchar(50),
stat_tiros_convertidos_valor int,
tiros_porcentaje decimal(5,2),
nombre varchar(30),
stat_faltas_id INT,
stat_faltas_nombre varchar(50),
stat_faltas_valor int,
stat_tiros_libres_intentos_id INT,
stat_tiros_libres_intentos_nombre varchar(50),
stat_tiros_libres_intentos_valor int,
stat_tiros_libres_convertidos_id INT,
stat_tiros_libres_convertidos_nombre varchar(50),
stat_tiros_libres_convertidos_valor int,
tiros_libres_porcentaje decimal(5,2),
partido_id int,
altura decimal(5,2),
esLocal varchar(20),
caminseta int,
apellido varchar(30),
stat_minutos_id INT,
stat_minutos_nombre varchar(50),
stat_minutos_valor int,
equipo_nombre varchar(50),
stat_rebotes_ofensivos_id INT,
stat_rebotes_ofensivos_nombre varchar(50),
stat_rebotes_ofensivos_valor int,
equipoOP_puntos int,
jugador_id int,
stat_puntos_id INT,
stat_puntos_nombre varchar(50),
stat_puntos_valor int,
posicion varchar(5),
rebotes int,
temporada_id int,
stat_segundos_id INT,
stat_segundos_nombre varchar(50),
stat_segundos_valor int,
stat_robos_id INT,
stat_robos_nombre varchar(50),
stat_robos_valor int,
equipo_codigo varchar(30),
equipo_puntos int,
equipo_id int,
stat_tiros_triples_intentos_id INT,
stat_tiros_triples_intentos_nombre varchar(50),
stat_tiros_triples_intentos_valor int,
stat_tiros_triples_convertidos_id INT,
stat_tiros_triples_convertidos_nombre varchar(50),
stat_tiros_triples_convertidos_valor int,
tiros_triples_porcentaje decimal(5,2),
stat_perdidas_id INT,
stat_perdidas_nombre varchar(50),
stat_perdidas_valor int,
peso varchar(100),
resultado varchar(10),
temporada_descripcion varchar(20),
idPais int,
equipo_idCiudad int,
equipoOP_idCiudad int,
)

BEGIN TRANSACTION
--CARGA MASIVA DE DATOS
BULK INSERT datos
FROM 'C:\Users\Matias Sotelo\Desktop\bdd\NBADataBase\datos\creacion.csv'
WITH (
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)
COMMIT

BEGIN TRAN
ALTER TABLE datos
ADD id_conferencia INT NULL

ALTER TABLE datos
ADD id_division INT NULL

ALTER TABLE datos
ADD id_ganador INT NULL
COMMIT

