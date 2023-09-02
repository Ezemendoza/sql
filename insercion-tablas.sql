CREATE DATABASE rrhh;

USE rrhh;
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

CREATE TABLE HistorialCamposCambiados (
id_personal INT,
edad INT,
nombre VARCHAR(25),
apellido VARCHAR(25),
sueldo FLOAT,
telefono VARCHAR(25),
direccion VARCHAR(100),
altura VARCHAR(10),
codigo_postal INT,
localidad VARCHAR(100),
provincia VARCHAR(100),
nombre_actualizo VARCHAR(50),
fecha_actualizado DATE,
hora_actualizado TIME,
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
estado VARCHAR(100),
FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion),
FOREIGN KEY (id_candidato) REFERENCES Candidato(id_candidato)
);

CREATE TABLE HistorialPostulacion (
id_postulacion INT,
id_publicacion INT,
id_candidato INT,
fecha_postulacion DATE,
estado VARCHAR(100),
hora_actualizado TIME,
fecha_actualizado DATE
);

CREATE TABLE COSTO(
id_costo  INT PRIMARY KEY,
id_empresa int,
monto FLOAT,
numero_factura FLOAT,
mes_factura DATE,
concepto VARCHAR(100),
descripcion VARCHAR(250));

