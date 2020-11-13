USE NBA_BDD
GO

--1. Cantidad de equipos que juegan el campeonato.
SELECT count(*) as 'Cantidad de equipos' FROM equipo

--2. Cantidad de partidos jugados en la primera mitad del año.
SELECT count(*) as 'Cantidad de partidos'
FROM partido 
WHERE datepart(month, fecha) <= 6 

--3. Cantidad de partidos en los que ganaron los Raptors.
SELECT equipo.nombre as 'Equipo ganador', count(*) as 'Cantidad de partidos'
FROM partido, equipo 
WHERE equipo.id_equipo = partido.id_ganador AND equipo.nombre LIKE 'Raptors'
GROUP BY equipo.nombre

--4. Cantidad de partidos que ganaron los Raptors jugando como visitantes.
SELECT equipo.nombre as 'Equipo visitaante', count(*) as 'Cantidad de partidos ganados'
FROM partido, equipo, partidoxequipo
WHERE equipo.id_equipo = partido.id_ganador 
AND equipo.nombre LIKE 'Raptors' 
AND partidoxequipo.id_partido = partido.id_partido 
AND partidoxequipo.esLocal LIKE 'False'
GROUP BY equipo.nombre

--5. Mostrar nombre, apellido, camiseta y nombre de su equipo, del jugador con mayor promedio de asistencias por partido.
SELECT jugador.nombre as 'Nombre jugador', jugador.apellido as 'Apellido jugador',
contrata.nro_camiseta as 'Numero de camiseta', equipo.nombre as 'Nombre del equipo'
FROM jugador, contrata, equipo, (
SELECT max(promedio) as promedio_maximo FROM registro, (
SELECT jugador.nombre as nombrecito, avg(registro.valor) as promedio FROM registro
INNER JOIN jugador on registro.id_jugador = jugador.id_jugador
INNER JOIN partido on registro.id_partido = partido.id_partido
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
WHERE estadistica.descripcion LIKE 'Asistencias'
GROUP BY partido.id_partido, jugador.nombre, jugador.apellido) as a) as player
WHERE equipo.id_equipo = contrata.id_equipo
GROUP BY jugador.nombre, jugador.apellido, contrata.nro_camiseta, equipo.nombre

 --6. Listar los 5 primeros equipos ordenandos por mayor promedio de peso de sus jugadores.
SELECT TOP 5 equipo.nombre as 'Nombre equipo', CONVERT (DECIMAL (10,2),
avg(cast(SUBSTRING(jugador.peso, 1, CHARINDEX (' ', jugador.peso, 1)) as FLOAT))) as 'Promedio del peso'
FROM equipo 
INNER JOIN contrata on contrata.id_equipo = equipo.id_equipo
INNER JOIN jugador on jugador.id_jugador = contrata.id_jugador
GROUP BY equipo.nombre
ORDER BY 'Promedio del peso' DESC

--7. Cantidad de partidos perdidos por los Timberwolves habiendo superado los 100 puntos.
SELECT count(partido.id_partido) as 'Cantidad de partidos pedidos' FROM partido
INNER JOIN partidoxequipo on partidoxequipo.id_partido = partido.id_partido
INNER JOIN equipo on equipo.id_equipo = partidoxequipo.id_equipo
WHERE equipo.nombre LIKE 'Timberwolves' 
AND partidoxequipo.puntos > 100
AND partido.id_ganador <> partidoxequipo.id_equipo

--8. Indicar nombre del país y cantidad de jugadores, del país con más jugadores en el torneo (excluyendo Estados Unidos).
SELECT TOP 1 pais.nombre as Pais, count(jugador.id_jugador) as 'Cantidad de jugadores' FROM jugador
INNER JOIN pais on pais.id_pais = jugador.id_pais
WHERE pais.nombre NOT LIKE 'Estados Unidos'
GROUP BY pais.nombre 
ORDER BY 'Cantidad de jugadores' DESC

--9. Promedio de puntos por partido de los equipos agrupados por conferencia.
SELECT DISTINCT conferencia.nombre as 'Nombre conferencia', SUM(partidoxequipo.puntos)/Count(partidoxequipo.id_partido) as 'Promedio de puntos'
FROM partidoxequipo
INNER JOIN equipo on partidoxequipo.id_equipo = equipo.id_equipo
INNER JOIN division ON equipo.id_division = division.id_division
INNER JOIN conferencia ON division.id_conferencia = conferencia.id_conferencia
GROUP BY conferencia.nombre

-- 10. Promedio de puntos por partido de los equipos agrupados por división.
SELECT DISTINCT  division.nombre as 'Nombre division', SUM(partidoxequipo.puntos)/Count(partidoxequipo.id_partido) as 'Promedio de puntos'
FROM partidoxequipo
INNER JOIN equipo on partidoxequipo.id_equipo = equipo.id_equipo
INNER JOIN division ON equipo.id_division = division.id_division
GROUP BY  division.nombre

-- 11. Cantidad de puntos, rebotes, asistencias totales realizados por Chris Paul contra equipos de la otra conferencia.


SELECT  SUM(asisTOT) as totalAsistencias,
SUM(rebsOTOT) as totalRebotesOfensivos,
SUM(rebsDTOT) as totalRebotesDefensivos,
SUM(puntosTOT) as totalPuntos
FROM partidoxequipo
INNER JOIN equipo on equipo.id_equipo LIKE partidoxequipo.id_equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia,

(SELECT equipo.id_equipo as equipoCP, partidoxequipo.id_partido as encuentrosCP, conferencia.nombre as confCP FROM equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia
INNER JOIN contrata on equipo.id_equipo = contrata.id_equipo
INNER JOIN jugador on contrata.id_jugador = jugador.id_jugador
INNER JOIN partidoxequipo on equipo.id_equipo LIKE partidoxequipo.id_equipo
WHERE jugador.nombre LIKE 'Chris' AND jugador.apellido LIKE 'Paul') as queryinfo,

(SELECT registro.id_partido as encuentroContado1, estadistica.descripcion, SUM(registro.valor) as asisTOT FROM equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia
INNER JOIN contrata on equipo.id_equipo = contrata.id_equipo
INNER JOIN jugador on contrata.id_jugador = jugador.id_jugador
INNER JOIN registro on jugador.id_jugador = registro.id_jugador 
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
WHERE jugador.nombre LIKE 'Chris' AND jugador.apellido LIKE 'Paul'
AND estadistica.descripcion LIKE 'Asistencias'
GROUP BY registro.id_partido, estadistica.descripcion) as registroinfo,

(SELECT registro.id_partido as encuentroContado2, estadistica.descripcion, SUM(registro.valor) as puntosTOT FROM equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia
INNER JOIN contrata on equipo.id_equipo = contrata.id_equipo
INNER JOIN jugador on contrata.id_jugador = jugador.id_jugador
INNER JOIN registro on jugador.id_jugador = registro.id_jugador 
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
WHERE jugador.nombre LIKE 'Chris' AND jugador.apellido LIKE 'Paul'
AND estadistica.descripcion LIKE 'Puntos'
GROUP BY registro.id_partido, estadistica.descripcion) as infoPuntos,

(SELECT registro.id_partido as encuentroContado3, estadistica.descripcion, SUM(registro.valor) as rebsOTOT FROM equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia
INNER JOIN contrata on equipo.id_equipo = contrata.id_equipo
INNER JOIN jugador on contrata.id_jugador = jugador.id_jugador
INNER JOIN registro on jugador.id_jugador = registro.id_jugador 
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
WHERE jugador.nombre LIKE 'Chris' AND jugador.apellido LIKE 'Paul'
AND estadistica.descripcion LIKE 'Rebotes ofensivos'
GROUP BY registro.id_partido, estadistica.descripcion) as infoRebsO,

(SELECT registro.id_partido as encuentroContado4, estadistica.descripcion, SUM(registro.valor) as rebsDTOT FROM equipo
INNER JOIN division on equipo.id_division = division.id_division
INNER JOIN conferencia on division.id_conferencia = conferencia.id_conferencia
INNER JOIN contrata on equipo.id_equipo = contrata.id_equipo
INNER JOIN jugador on contrata.id_jugador = jugador.id_jugador
INNER JOIN registro on jugador.id_jugador = registro.id_jugador 
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
WHERE jugador.nombre LIKE 'Chris' AND jugador.apellido LIKE 'Paul'
AND estadistica.descripcion LIKE 'Rebotes defensivos'
GROUP BY registro.id_partido, estadistica.descripcion) as infoRebsD

WHERE partidoxequipo.id_partido LIKE encuentrosCP 
AND partidoxequipo.id_partido LIKE encuentroContado1
AND partidoxequipo.id_partido LIKE encuentroContado2
AND partidoxequipo.id_partido LIKE encuentroContado3
AND partidoxequipo.id_partido LIKE encuentroContado4
AND partidoxequipo.id_equipo NOT LIKE equipoCP
AND conferencia.nombre NOT LIKE confCP


-- 12. Promedio de minutos jugados por partido de los jugadores originarios del país del punto 8. 
--		Se considera partido jugado si jugó al menos 1 minuto en el partido.
SELECT TOP 1 pais.nombre as Pais, count(jugador.id_jugador) as 'Cantidad de jugadores', avg(registro.valor) as Promedio FROM jugador
INNER JOIN pais on pais.id_pais = jugador.id_pais
INNER JOIN registro on registro.id_jugador = jugador.id_jugador
INNER JOIN estadistica on estadistica.id_estadistica = registro.id_estadistica
WHERE pais.nombre NOT LIKE 'Estados Unidos' 
AND estadistica.descripcion LIKE 'Minutos'
AND registro.valor > 0
GROUP BY pais.nombre 
ORDER BY 'Cantidad de jugadores' DESC

-- 13. Cantidad de jugadores con más de 15 años de carrera, cantidad entre 15 y 10 y cantidad con menos de 10 años.
SELECT MasQuince as 'Mas de 15 años', EntreDiezQuince as 'Entre 15 y 10 años', MenosDiez as 'Menos de 10 años' FROM
(SELECT count(jugador.draft_year) as MasQuince FROM jugador
WHERE 15 < (year(getdate()) - jugador.draft_year)) as a, 
(SELECT count(jugador.draft_year) as EntreDiezQuince FROM jugador
WHERE 15 >= (year(getdate()) - jugador.draft_year)
AND 10 <= (year(getdate()) - jugador.draft_year)) as b,
(SELECT count(jugador.draft_year) as MenosDiez FROM jugador
WHERE 10 > (year(getdate()) - jugador.draft_year)) as c

-- 14. Cantidad de partidos en que los que al menos un jugador de los Celtics obtuvo más de 10 rebotes en total.
SELECT COUNT(contador) as 'Cantidad de Partidos' FROM 
(SELECT distinct registro.id_partido as contador, registro.valor AS 'Cantidad Rebotes' FROM registro
INNER JOIN estadistica on registro.id_estadistica = estadistica.id_estadistica
INNER JOIN contrata ON registro.id_jugador = contrata.id_jugador
INNER JOIN equipo ON contrata.id_equipo = equipo.id_equipo
INNER JOIN partidoxequipo ON equipo.id_equipo = partidoxequipo.id_equipo
WHERE estadistica.descripcion LIKE 'Rebotes%'
AND equipo.nombre LIKE 'Celtics'
AND registro.valor > 10
GROUP BY registro.id_jugador, registro.id_partido, registro.valor) as SubQuery

-- 15. Indicar ID de partido, fecha, sigla y puntos realizados del equipo local y visitante, 
--		del partido en que Ricky Rubio hizo más puntos en esta temporada.
SELECT TOP 2 partido.id_partido as ID_Partido, cast((partido.fecha) as date) as Fecha,
equipo.acronimo as Siglas, partidoxequipo.puntos as Puntos, partidoxequipo.esLocal FROM partido
INNER JOIN partidoxequipo ON partido.id_partido = partidoxequipo.id_partido
INNER JOIN equipo ON partidoxequipo.id_equipo = equipo.id_equipo
INNER JOIN registro ON partidoxequipo.id_partido = registro.id_partido
INNER JOIN jugador ON registro.id_jugador = jugador.id_jugador
INNER JOIN estadistica ON registro.id_estadistica = estadistica.id_estadistica
WHERE jugador.nombre LIKE 'Ricky' AND jugador.apellido LIKE 'Rubio'
AND estadistica.descripcion LIKE 'Puntos'
ORDER BY registro.valor DESC