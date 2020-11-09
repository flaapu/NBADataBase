USE NBA_BDD
GO

--1. Cantidad de equipos que juegan el campeonato.
SELECT count(*) as Cantidad FROM equipo

--2. Cantidad de partidos jugados en la primera mitad del año.
SELECT count(*) as Cantidad_de_Partidos 
FROM partido 
WHERE datepart(month, fecha) <= 6 

--3. Cantidad de partidos en los que ganaron los Raptors.
SELECT equipo.nombre as WinTeam, count(*) as Cantidad 
FROM partido, equipo 
WHERE equipo.id_equipo = partido.id_ganador AND equipo.nombre LIKE 'Raptors'
GROUP BY equipo.nombre

--4. Cantidad de partidos que ganaron los Raptors jugando como visitantes.
SELECT equipo.nombre as TeamVisitante, count(*) as Victory
FROM partido, equipo, partidoxequipo
WHERE equipo.id_equipo = partido.id_ganador 
AND equipo.nombre LIKE 'Raptors' 
AND partidoxequipo.id_partido = partido.id_partido 
AND partidoxequipo.esLocal LIKE 'False'
GROUP BY equipo.nombre

--5. Mostrar nombre, apellido, camiseta y nombre de su equipo, del jugador con mayor promedio de asistencias por partido.
SELECT jugador.nombre, jugador.apellido, contrata.nro_camiseta, equipo.nombre 
FROM equipo, jugador, contrata, estadistica, registro 
WHERE jugador.id_jugador = contrata.id_jugador 
AND equipo.id_equipo = contrata.id_equipo
AND jugador.id_jugador = registro.id_jugador
AND estadistica.descripcion LIKE 'Asistencias'
AND estadistica.id_estadistica = registro.id_estadistica
AND AVG(registro.valor) as Promedio AND MAX(Promedio)

--

SELECT jugador.nombre, jugador.apellido, contrata.nro_camiseta, equipo.nombre 
FROM equipo, jugador, contrata
WHERE jugador.id_jugador = contrata.id_jugador 
AND equipo.id_equipo = contrata.id_equipo
AND SELECT MAX(Promedio) FROM registro
WHERE 



SELECT avg(registro.valor) as PROMEDIO FROM registro


--