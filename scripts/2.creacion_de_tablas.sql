--CREACION DE TABLAS
--USE NBA_BDD
--GO
--USO DE TRANSACCIONES
BEGIN TRANSACTION

CREATE TABLE estadistica (
id_estadistica INT NOT NULL,		
descripcion VARCHAR(50) NULL,		
CONSTRAINT PK_ESTADISTICA PRIMARY KEY CLUSTERED (id_estadistica)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE pais (
id_pais INT NOT NULL,
nombre VARCHAR(100) NULL,
CONSTRAINT PK_PAIS PRIMARY KEY CLUSTERED (id_pais)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE ciudad (
id_ciudad INT NOT NULL,
nombre VARCHAR(50) NULL,
CONSTRAINT PK_CIUDAD PRIMARY KEY CLUSTERED (id_ciudad)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE conferencia (
id_conferencia INT NOT NULL IDENTITY(1,1),
nombre VARCHAR(20) NULL,
CONSTRAINT PK_CONFERENCIA PRIMARY KEY CLUSTERED (id_conferencia)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE division (
id_division INT NOT NULL IDENTITY(1,1),
nombre VARCHAR(20) NULL,
id_conferencia INT NOT NULL FOREIGN KEY REFERENCES conferencia(id_conferencia),
CONSTRAINT PK_DIVISION PRIMARY KEY CLUSTERED (id_division)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE temporada (
id_temporada INT NOT NULL,
descripcion VARCHAR(20) NULL,
CONSTRAINT PK_TEMPORADA PRIMARY KEY CLUSTERED (id_temporada)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE equipo (
id_equipo INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
codigo varchar(30) NOT NULL UNIQUE,
acronimo CHAR(5) NOT NULL,
descripcion VARCHAR(20) NULL,
id_ciudad INT NOT NULL,
id_division INT NOT NULL, 

FOREIGN KEY (id_division) REFERENCES division(id_division),
FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
CONSTRAINT PK_EQUIPO PRIMARY KEY CLUSTERED (id_equipo)
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE jugador(
id_jugador INT NOT NULL,
codigo VARCHAR(40) NULL,
nombre VARCHAR(30) NULL,
apellido VARCHAR(30) NULL,
altura DECIMAL(5,2) NULL,
peso VARCHAR(100) NULL,
draft_year INT NOT NULL, 
id_pais INT NOT NULL FOREIGN KEY REFERENCES pais(id_pais),
posicion VARCHAR(5) NULL,
CONSTRAINT PK_JUGADOR PRIMARY KEY CLUSTERED (id_jugador),
)

COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE partido(
id_partido INT NOT NULL,
fecha datetime,
id_ganador INT NOT NULL FOREIGN KEY REFERENCES equipo(id_equipo),
id_temporada INT NOT NULL FOREIGN KEY REFERENCES temporada(id_temporada),
CONSTRAINT PK_PARTIDO PRIMARY KEY CLUSTERED (id_partido)
)

COMMIT
--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE partidoxequipo(
id_partido INT NOT NULL FOREIGN KEY REFERENCES partido(id_partido),
id_equipo INT NOT NULL FOREIGN KEY REFERENCES equipo(id_equipo),
puntos int NOT NULL,
esLocal VARCHAR(20) NOT NULL,

CONSTRAINT PK_PARTIDOXEQUIPO PRIMARY KEY CLUSTERED (id_partido, id_equipo),
)
COMMIT



--USO DE TRANSACCIONES
BEGIN TRANSACTION 
CREATE TABLE registro(
valor INT NOT NULL,
id_estadistica INT NOT NULL FOREIGN KEY REFERENCES estadistica(id_estadistica),
id_jugador INT NOT NULL FOREIGN KEY REFERENCES jugador(id_jugador),
id_partido INT NOT NULL FOREIGN KEY REFERENCES partido(id_partido),

CONSTRAINT PK_REGISTRO PRIMARY KEY CLUSTERED (id_estadistica, id_jugador, id_partido),
)
COMMIT

--USO DE TRANSACCIONES
BEGIN TRANSACTION
CREATE TABLE contrata(
id_jugador INT NOT NULL FOREIGN KEY REFERENCES jugador(id_jugador),
id_equipo INT NOT NULL FOREIGN KEY REFERENCES equipo(id_equipo),
id_temporada INT NOT NULL FOREIGN KEY REFERENCES temporada(id_temporada),
nro_camiseta INT NULL, 

CONSTRAINT PK_CONTRATA PRIMARY KEY CLUSTERED (id_jugador, id_equipo, id_temporada),
)
COMMIT







