CREATE DATABASE rrhh;

USE rrhh;


CREATE TABLE Empresa (
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


CREATE TABLE Modulo (
    id_modulo INT PRIMARY KEY,
    activado BOOLEAN,
    costo FLOAT,
    id_empresa INT,
    FOREIGN KEY (id_empresa) REFERENCES Empresa(Id_empresa)
);


CREATE TABLE Sector (
    Id_sector INT PRIMARY KEY,
    id_empresa INT,
    direccion VARCHAR(100),
    descripcion VARCHAR(250),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(Id_empresa)
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


CREATE TABLE DatosPersonales (
id_personal INT PRIMARY KEY,
edad INT,
nombre VARCHAR(25),
apellido VARCHAR(25),
telefono VARCHAR(25),
direccion VARCHAR(100),
altura VARCHAR(10),
sueldo FLOAT,
codigo_postal INT,
localidad VARCHAR(100),
provincia VARCHAR(100),
FOREIGN KEY (id_personal) REFERENCES Personal(Id_personal)
);


CREATE TABLE Peticiones (
    id_peticion INT PRIMARY KEY,
    id_personal INT,
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
    FOREIGN KEY (id_peticion) REFERENCES Peticiones(id_peticion)
);


CREATE TABLE HistorialCamposCambiados (
    id_personal INT,
    campo VARCHAR(50),
    valor_anterior VARCHAR(100),
    valor_nuevo VARCHAR(100), 
    nombre_actualizo VARCHAR(50),
    fecha_actualizado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_personal) REFERENCES Personal(Id_personal)
);


CREATE TABLE Publicacion (
id_publicacion INT PRIMARY KEY,
Id_empresa INT,
Id_personal INT,
titulo VARCHAR(100),
descripcion VARCHAR(250),
requisitos VARCHAR(300),
fecha_creacion DATE,
FOREIGN KEY (Id_empresa) REFERENCES EMPRESA(Id_empresa),
FOREIGN KEY (Id_personal) REFERENCES Personal(Id_personal)
);


CREATE TABLE Postulacion (
    id_postulacion INT PRIMARY KEY,
    id_publicacion INT,
    id_candidato INT,
    fecha_postulacion DATE,
    estado VARCHAR(100),
    FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);
CREATE TABLE Candidato (
    id_candidato INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    url_cv VARCHAR(100),
    id_postulacion INT,
	FOREIGN KEY (id_postulacion) REFERENCES Postulacion(id_postulacion)
);


CREATE TABLE HistorialPostulacion (
    id_historial_postulacion INT PRIMARY KEY,
    postulacion_id INT,
    publicacion_id INT,
    candidato_id INT,
    fecha_postulacion DATE,
    estado VARCHAR(100),
    hora_actualizado TIME,
    fecha_actualizado DATE,
    FOREIGN KEY (postulacion_id) REFERENCES Postulacion(id_postulacion)
);


CREATE TABLE Costo (
    id_costo INT PRIMARY KEY,
    id_empresa INT,
    monto FLOAT,
    numero_factura VARCHAR(100), 
    mes_factura DATE,
    concepto VARCHAR(100),
    descripcion VARCHAR(250),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(Id_empresa)
);