CREATE DATABASE RRHH;

USE RRHH;
CREATE TABLE EMPRESA (
Id_empresa INT PRIMARY KEY,
nombre VARCHAR(50),
descripcion VARCHAR(250),
tipo_de_empresa VARCHAR(50),
telefono VARCHAR(15),
direccion VARCHAR(100),
altura VARCHAR(10),
codigo_postal INT,
localidad VARCHAR(100),
provincia VARCHAR(100)
);
CREATE TABLE MODULO (
id_modulo INT PRIMARY KEY,
activado BOOLEAN,
costo FLOAT,
empresa_id INT,
FOREIGN KEY (empresa_id) REFERENCES EMPRESA(Id_empresa)
);
CREATE TABLE Sector (
Id_sector INT PRIMARY KEY,
id_empresa INT,
direccion VARCHAR(100),
descripcion VARCHAR(250),
FOREIGN KEY (id_empresa) REFERENCES EMPRESA(Id_empresa)
);
CREATE TABLE Lider (
Id_lider INT PRIMARY KEY,
id_sector INT,
nombre VARCHAR(25),
apellido VARCHAR(25),
fecha_ingreso DATE,
FOREIGN KEY (id_sector) REFERENCES Sector(Id_sector)
);
CREATE TABLE Personal (
Id_personal INT PRIMARY KEY,
id_sector INT,
id_lider INT,
FOREIGN KEY (id_sector) REFERENCES Sector(Id_sector),
FOREIGN KEY (id_lider) REFERENCES Lider(Id_lider)
);
CREATE TABLE PETICIONES (
id_personal INT,
id_peticion INT PRIMARY KEY,
situacion BOOLEAN,
fecha DATE,
FOREIGN KEY (id_personal) REFERENCES Personal(Id_personal)
);
CREATE TABLE OrdenPeticiones (
id_lider INT,
id_peticion INT,
direccion VARCHAR(100),
descripcion VARCHAR(250),
fecha DATE,
FOREIGN KEY (id_lider) REFERENCES Lider(Id_lider),
FOREIGN KEY (id_peticion) REFERENCES PETICIONES(id_peticion)
);
CREATE TABLE DatosPersonales (
id_personal INT PRIMARY KEY,
edad INT,
nombre VARCHAR(25),
apellido VARCHAR(25),
telefono VARCHAR(25),
direccion VARCHAR(100),
altura VARCHAR(10
),
codigo_postal INT,
localidad VARCHAR(100),
provincia VARCHAR(100),
FOREIGN KEY (id_personal) REFERENCES Personal(Id_personal)
);
CREATE TABLE Publicacion (
id_publicacion INT PRIMARY KEY,
Id_empresa INT,
Id_personal INT,
titulo VARCHAR(
100),
descripcion VARCHAR(250),
requisitos VARCHAR(300),
fecha_creacion DATE,
FOREIGN KEY (Id_empresa) REFERENCES EMPRESA(Id_empresa),
FOREIGN KEY (Id_personal) REFERENCES Personal(Id_personal
)
);
CREATE TABLE Candidato (
id_candidato INT PRIMARY KEY,
nombre VARCHAR(100),
direccion VARCHAR(100),
telefono VARCHAR(20),
url_cv VARCHAR(100)
);
CREATE TABLE Postulacion (
id_postulacion INT PRIMARY KEY,
id_publicacion INT,
id_candidato INT,
fecha_postulacion DATE,
estado VARCHAR(200),
FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion),
FOREIGN KEY (id_candidato) REFERENCES Candidato(id_candidato)
);

INSERT INTO EMPRESA (Id_empresa, nombre, descripcion, tipo_de_empresa, telefono, direccion, altura, codigo_postal, localidad, provincia)
VALUES (1, 'La Empresa SA', 'Descripción de La Empresa SA', 'Tecnología', '011-1234567', 'Calle Principal 123', '5A', 1234, 'Buenos Aires', 'Buenos Aires'),
       (2, 'Consultora Argenta', 'Descripción de Consultora Argenta', 'Servicios', '011-9876543', 'Avenida Comercial 456', '10B', 5678, 'Córdoba', 'Córdoba'),
		(3, 'Software Solutions', 'Descripción de Software Solutions', 'Tecnología', '011-8888888', 'Calle Software 789', '7B', 4567, 'La Plata', 'Buenos Aires'),
       (4, 'Consultoría Innovadora', 'Descripción de Consultoría Innovadora', 'Consultoría', '011-7777777', 'Avenida Consultores 543', '3A', 7890, 'Córdoba', 'Córdoba'),
        (5, 'Innovación Digital', 'Descripción de Innovación Digital', 'Tecnología', '011-5555555', 'Calle Innovación 123', '5A', 1234, 'Buenos Aires', 'Buenos Aires'),
    (6, 'Estrategias Empresariales', 'Descripción de Estrategias Empresariales', 'Consultoría', '011-6666666', 'Avenida Estrategias 456', '10B', 5678, 'Córdoba', 'Córdoba'),
    (7, 'Soluciones Creativas', 'Descripción de Soluciones Creativas', 'Servicios', '011-7777777', 'Calle Creatividad 789', '7B', 4567, 'La Plata', 'Buenos Aires'),
    (8, 'Global Tech', 'Descripción de Global Tech', 'Tecnología', '011-8888888', 'Avenida Tecnológica 543', '3A', 7890, 'Córdoba', 'Córdoba');

INSERT INTO MODULO (id_modulo, activado, costo, empresa_id)
VALUES (1, true, 100.00, 1),
       (2, false, 200.00, 1),
       (3, true, 150.00, 2),
       (4, true, 80.00, 3),
       (5, false, 120.00, 3),
       (6, true, 180.00, 4);



INSERT INTO Sector (Id_sector, id_empresa, direccion, descripcion)
VALUES (1, 1, 'Oficina Principal', 'Departamento de Desarrollo'),
       (2, 1, 'Sucursal Este', 'Departamento de Ventas'),
       (3, 2, 'Oficina Central', 'Departamento de Consultoría'),
		(4, 3, 'Oficina Sur', 'Departamento de Desarrollo'),
       (5, 3, 'Sucursal Norte', 'Departamento de Ventas'),
       (6, 4, 'Oficina Oeste', 'Departamento de Finanzas');

INSERT INTO Lider (Id_lider, id_sector, nombre, apellido, fecha_ingreso)
VALUES (1, 1, 'Juan', 'Pérez', '2020-01-01'),
       (2, 2, 'María', 'González', '2019-05-15'),
       (3, 3, 'Carlos', 'Rodríguez', '2022-03-10'),
       (4, 4, 'Federico', 'Martínez', '2018-11-10'),
       (5, 5, 'Laura', 'Rojas', '2017-06-22'),
       (6, 6, 'Miguel', 'López', '2021-09-05');



INSERT INTO Personal (Id_personal, id_sector, id_lider)
VALUES (1, 1, 1),
       (2, 1, 1),
       (3, 2, 2),
       (4, 4, 4),
       (5, 4, 4),
       (6, 5, 5),
        (7, 2, 2),
    (8, 3, 3),
    (9, 4, 4),
    (10, 1, 1),
    (11, 5, 5),
    (12, 1, 1),
    (13, 3, 3),
    (14, 2, 2),
    (15, 4, 4),
    (16, 5, 5);


INSERT INTO PETICIONES (id_personal, id_peticion, situacion, fecha)
VALUES (1, 1, true, '2022-07-01'),
       (2, 2, false, '2022-06-15'),
       (3, 3, true, '2022-07-05'),
       (4, 4, true, '2022-08-05'),
       (5, 5, false, '2022-07-30'),
       (6, 6, true, '2022-08-10');


INSERT INTO OrdenPeticiones (id_lider, id_peticion, direccion, descripcion, fecha)
VALUES (1, 1, 'Calle Principal 123', 'Reparación de equipos', '2022-07-02'),
       (2, 2, 'Avenida Comercial 456', 'Actualización de inventario', '2022-06-20'),
       (3, 3, 'Oficina Central', 'Instalación de software', '2022-07-06'),
       (4, 4, 'Calle Software 789', 'Actualización de software', '2022-08-08'),
       (5, 5, 'Avenida Consultores 543', 'Reparación de equipos', '2022-07-31'),
       (6, 6, 'Oficina Oeste', 'Informe financiero', '2022-08-15');


INSERT INTO DatosPersonales (id_personal, edad, nombre, apellido, telefono, direccion, altura, codigo_postal, localidad, provincia)
VALUES (1, 30, 'Lucía', 'López', '011-1111111', 'Calle Principal 123', '5A', 1234, 'Buenos Aires', 'Buenos Aires'),
       (2, 28, 'Martín', 'Fernández', '011-2222222', 'Avenida Comercial 456', '10B', 5678, 'Córdoba', 'Córdoba'),
       (3, 35, 'Carolina', 'Giménez', '011-3333333', 'Oficina Central', '2C', 9012, 'Rosario', 'Santa Fe'),
       (4, 27, 'Camila', 'Gómez', '011-4444444', 'Calle Software 789', '7B', 4567, 'La Plata', 'Buenos Aires'),
       (5, 32, 'Diego', 'Torres', '011-5555555', 'Avenida Consultores 543', '3A', 7890, 'Córdoba', 'Córdoba'),
       (6, 24, 'Luis', 'Díaz', '011-6666666', 'Oficina Oeste', '2C', 9012, 'Rosario', 'Santa Fe'),
       (9, 33, 'Miguel', 'García', '011-9999999', 'Calle Trabajador 9', '8A', 8901, 'La Plata', 'Buenos Aires'),
    (10, 29, 'Laura', 'Martínez', '011-1010101', 'Avenida Empleado 10', '3B', 2345, 'Córdoba', 'Córdoba'),
    (11, 37, 'Diego', 'López', '011-1212121', 'Calle Colaborador 11', '7A', 5678, 'Buenos Aires', 'Buenos Aires'),
    (12, 24, 'Carolina', 'Rodríguez', '011-1313131', 'Avenida Trabajador 12', '5B', 1234, 'Córdoba', 'Córdoba'),
    (13, 31, 'Javier', 'Pérez', '011-1414141', 'Calle Empleado 13', '2A', 4567, 'La Plata', 'Buenos Aires'),
    (14, 27, 'María', 'Hernández', '011-1515151', 'Avenida Colaborador 14', '6B', 3456, 'Córdoba', 'Córdoba'),
    (15, 34, 'Alejandro', 'Gómez', '011-1616161', 'Calle Trabajador 15', '9A', 6789, 'Buenos Aires', 'Buenos Aires'),
    (16, 26, 'Natalia', 'Díaz', '011-1717171', 'Avenida Empleado 16', '4B', 9012, 'Córdoba', 'Córdoba');


INSERT INTO Publicacion (id_publicacion, Id_empresa, Id_personal, titulo, descripcion, requisitos, fecha_creacion)
VALUES (1, 1, 1, 'Desarrollador Full Stack', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-07-01'),
       (2, 2, 2, 'Consultor de Negocios', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-06-15'),
       (3, 1, 3, 'Ejecutivo de Ventas', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-07-05'),
       (4, 3, 4, 'Desarrollador Frontend', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-08-01'),
       (5, 4, 5, 'Analista de Ventas', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-07-25'),
       (6, 3, 6, 'Analista Financiero', 'Descripción del puesto de trabajo', 'Requisitos del puesto de trabajo', '2022-08-02');


INSERT INTO Candidato (id_candidato, nombre, direccion, telefono, url_cv)
VALUES (1, 'Sofía Rodríguez', 'Calle Independencia 789', '011-4444444', 'http://example.com/sofia_cv'),
       (2, 'Javier Martínez', 'Avenida Principal 321', '011-5555555', 'http://example.com/javier_cv'),
       (3, 'Valentina Sánchez', 'Calle Comercial 987', '011-6666666', 'http://example.com/valentina_cv'),
       (4, 'Ana López', 'Calle Independencia 111', '011-7777777', 'http://example.com/ana_cv'),
       (5, 'Jorge Fernández', 'Avenida Principal 222', '011-8888888', 'http://example.com/jorge_cv'),
       (6, 'Lucas Soto', 'Calle Comercial 333', '011-9999999', 'http://example.com/lucas_cv'),
       (7, 'Federico Silva', 'Calle Trabajador 9', '011-1111111', 'federico.silva@gmail.com'),
       (8, 'Ana Fernández', 'Avenida Empleado 10', '011-1010101', 'ana.fernandez@gmail.com'),
       (9, 'Roberto Pérez', 'Avenida Trabajador 12', '011-1313131', 'roberto.perez@gmail.com'),
       (10, 'Carla López', 'Calle Empleado 13', '011-1414141', 'carla.lopez@gmail.com'),
       (11, 'Andrés González', 'Calle Colaborador 11', '011-1212121', 'andres.gonzalez@gmail.com'),
       (12, 'Marcela Ramírez', 'Avenida Empleado 16', '011-1717171', 'marcela.ramirez@gmail.com'),
       (13, 'Juan Torres', 'Calle Trabajador 15', '011-1616161', 'juan.torres@gmail.com'),
       (14, 'Lucía García', 'Avenida Colaborador 14', '011-1515151', 'lucia.garcia@gmail.com'),
       (15, 'Federico Silva', 'Calle Trabajador 9', '011-9999999', 'federico_silva_cv.pdf'),
       (16, 'Ana Fernández', 'Avenida Empleado 10', '011-1010101', 'ana_fernandez_cv.pdf'),
       (17, 'Roberto Pérez', 'Avenida Trabajador 12', '011-1313131', 'roberto_perez_cv.pdf'),
       (18, 'Carla López', 'Calle Empleado 13', '011-1414141', 'carla_lopez_cv.pdf');



INSERT INTO Postulacion (id_postulacion, id_publicacion, id_candidato, fecha_postulacion, estado)
VALUES (1, 1, 1, '2022-07-02', true),
       (2, 2, 2, '2022-06-20', false),
       (3, 3, 3, '2022-07-06', true),
       (4, 4, 4, '2022-08-06', true),
       (5, 5, 5, '2022-08-01', false),
       (6, 6, 6, '2022-08-07', true),
       (7, 2, 1, '2023-01-12', true),
       (8, 3, 2, '2023-02-22', true),
       (9, 4, 3, '2023-04-02', true),
       (10, 5, 4, '2023-04-15', true),
       (11, 6, 5, '2023-05-20', false),
       (12, 1, 6, '2023-06-28', true),
       (13, 2, 7, '2023-07-10', false),
       (14, 3, 8, '2023-08-18', true),
       (15, 4, 1, '2023-01-12', true),
       (16, 6, 1, '2023-01-12', true),
       (17, 2, 1, '2023-01-12', true),
       (18, 1, 1, '2023-01-12', true);

       

