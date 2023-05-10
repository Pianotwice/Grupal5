-- Parte 1: Crear entorno de trabajo
-- Crear una base de datos
-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.

CREATE DATABASE ejercicioGrupal5;
USE ejercicioGrupal5;
CREATE USER 'adminEG5'@'localhost' IDENTIFIED BY 'admin54321';
GRANT ALL PRIVILEGES ON ejercicioGrupal5 .* TO 'adminEG5'@'localhost';

-- Parte 2: Crear dos tablas.
-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).

CREATE TABLE usuario(
	id_usuario VARCHAR (36) PRIMARY KEY NOT NULL,
		-- * establecer un identificador único en base a una estructura definida para ello
	nombre VARCHAR (15) NOT NULL,
    	-- * los nombres se componen por caracteres
	apellido  VARCHAR (15),
    	-- * los apellidos se componen de caracteres
	contrasena VARCHAR (12) NOT NULL,
		-- * admitir solo caracteres válidos para ser procesados y validados
	zona_horaria TIME DEFAULT (TIMEDIFF(NOW(), DATE_ADD(NOW(), INTERVAL 3 HOUR))), -- (UTC-3)
    	-- * poder tener el fomato UTC como diferencia de horas
	genero VARCHAR (20),
		-- * cadena de texto
	telefono VARCHAR (15) UNIQUE NOT NULL
    	-- * poder admitir caracteres como '+' , '(' ,')'
);
SELECT * FROM usuario;


-- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la plataforma
-- (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).

CREATE TABLE historial(
	id_ingreso VARCHAR (36) PRIMARY KEY NOT NULL,
    	-- * establecer un identificador con los datos de ingreso
    id_usuario VARCHAR (36),
    	-- * nombre de usuario
    ingreso_Fecha DATE DEFAULT (CURRENT_DATE) ,
    	-- * Retener la fecha de ingreso
	ingreso_Hora TIME DEFAULT (CURRENT_DATE)
		-- * Retener la hora de ingreso
);
SELECT * FROM historial;


-- Parte 3: Modificación de la tabla
-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.

DESCRIBE usuario;	-- DEFAULT PRE CAMBIO
ALTER TABLE usuario
ALTER zona_horaria
SET DEFAULT  (TIMEDIFF(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR)));
DESCRIBE usuario;	-- DEFAULT POST CAMBIO


-- Parte 4: Creación de registros.
-- Para cada tabla crea 8 registros.
-- -----------------------------------------------------------------------------------
INSERT INTO usuario
	(id_usuario, nombre, apellido, contrasena, genero, telefono)
		VALUES
('afd424dc-02e1-478c-8ad6-84e56322424b', 'Simonne', 'Morter', 'vCl3XH', 'Transgender Person', '2841464412'),
('921cfb84-326e-4975-b67e-6eb7362d0afc', 'Rooney', 'Kupke', 'RJfyUB', 'Transsexual Woman', '6702820008'),
('0db6e324-98b0-483d-926c-1c5646d18fc5', 'Zaccaria', 'Poppleton', '4xXMeP', 'Gender Nonconforming', '1807533674'),
('d3c57794-8dd5-43b8-8c89-f0213ca42504', 'Rozalin', 'Spellsworth', 'og9jz0baV', 'Trans Female', '3902047927'),
('8e096ed7-d5e9-4701-a3d0-c68c57b9a440', 'Andriana', 'Bernardos', 'PJeA3PXNjw', 'Intersex', '1315021613'),
('ec76035d-6470-4b44-8e81-95a8ad02cbf6', 'Judith', 'Blesli', 'mEUZJaDhd', 'Transsexual Male', '6833107642'),
('7f05a706-553b-4206-86f8-20c149f498f7', 'Janessa', 'Surgison', 'ptFQPYTkQxr', 'Neutrois', '7084045011'),
('3518ed96-9aae-4cca-b96f-1b9847d20bdf', 'Mischa', 'Neame', 'VC7ghV6MAQuj', 'Neither', '9888956889');
SELECT * FROM usuario;

-- -----------------------------------------------------------------------------------
INSERT INTO historial
	(id_ingreso, id_usuario, ingreso_Fecha, ingreso_Hora)
		VALUES
('68312784-f424-41ef-8769-ff807be9dbf5', 'afd424dc-02e1-478c-8ad6-84e56322424b', '2023-04-03', '19:32'),
('80f27d17-5146-4bb9-81d2-3d0dcd0ca5f0', '921cfb84-326e-4975-b67e-6eb7362d0afc', '2022-05-18', '11:50'),
('0ac15e3e-6d95-42d7-b167-db4f6b799afd', '0db6e324-98b0-483d-926c-1c5646d18fc5', '2022-12-04', '0:57'),
('361ba872-315e-410a-aab8-97de58cba990', 'd3c57794-8dd5-43b8-8c89-f0213ca42504', '2022-08-31', '15:33'),
('83786862-05d6-4a10-bd87-91eb2ef4013b', '8e096ed7-d5e9-4701-a3d0-c68c57b9a440', '2022-11-19', '20:56'),
('72dc0701-ec55-4314-8bb9-b54845cb5cec', 'ec76035d-6470-4b44-8e81-95a8ad02cbf6', '2023-01-07', '0:43'),
('b9c4a63a-d79f-4002-bc9f-abbae660aba7', '7f05a706-553b-4206-86f8-20c149f498f7', '2022-05-08', '11:58'),
('3c708e01-35ae-410d-a72f-7125e6b4987a', '3518ed96-9aae-4cca-b96f-1b9847d20bdf', '2022-05-19', '23:01');
SELECT * FROM historial;

-- -----------------------------------------------------------------------------------
-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
-- -----------------------------------------------------------------------------------
-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).

CREATE TABLE contacto(
	id_contacto VARCHAR (36) PRIMARY KEY NOT NULL,
    id_usuario VARCHAR (36) NOT NULL,
    telefono VARCHAR (15),
    email VARCHAR (40)
);
SELECT * FROM contacto;


-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.

ALTER TABLE ejercicioGrupal5.contacto
	ADD CONSTRAINT fk_telefono
	FOREIGN KEY (telefono) REFERENCES ejercicioGrupal5.usuario (telefono);
DESCRIBE contacto;


-- *El ejercicio debe ser subido a github y al Nodo Virtual.  ;D

-- (Inserte link al repo de GitHub)


