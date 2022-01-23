ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

DROP TABLE prestamo;
DROP TABLE ejemplarLibro;
DROP TABLE socio;
DROP TABLE publicacion;
DROP TABLE libro;
DROP TABLE biblioteca;
DROP TABLE editorial;

CREATE TABLE editorial
(   Nombre VARCHAR(30) PRIMARY KEY,
    Direccion VARCHAR(60),
    Telefono NUMBER(9)
);

CREATE TABLE biblioteca
(   Distrito VARCHAR(20) PRIMARY KEY,
    Direccion VARCHAR(60)
);

CREATE TABLE libro
(   ISBN CHAR(17) PRIMARY KEY,
    Edicion VARCHAR(20),
    Ano NUMBER(4)
);

CREATE TABLE publicacion
(   ISBN CHAR(17) PRIMARY KEY,
    Titulo VARCHAR2(50),
    Autores VARCHAR2(100), 
    Idioma VARCHAR2(20),
    nEditorial VARCHAR2(30) REFERENCES editorial
);

CREATE TABLE socio
(   NCarnet NUMBER(10) PRIMARY KEY,
    Nombre VARCHAR(20),
    DNI CHAR(9),
    Email VARCHAR(30),
    Distrito VARCHAR(20) REFERENCES biblioteca
);

CREATE TABLE ejemplarLibro
(   ISBN CHAR(17) REFERENCES libro,
    Distrito VARCHAR(20) REFERENCES biblioteca,
    NumEjemplar NUMBER(5),
    FechaCompra DATE,
    PRIMARY KEY(ISBN, Distrito, NumEjemplar)
);

CREATE TABLE prestamo
(   NSocio NUMBER(10) REFERENCES socio, 
    FechaPrestamo DATE, 
    ISBN CHAR(17), 
    Distrito VARCHAR(20),
    NumEjemplar NUMBER(5),
    NumDias NUMBER(2),
    PRIMARY KEY(NSocio, FechaPrestamo),
    FOREIGN KEY(ISBN, Distrito, NumEjemplar) REFERENCES ejemplarLibro
);


INSERT INTO editorial VALUES ('Addison-Wesley', 'Ribera del Loira, 28. 28042 Madrid', 911234567);
INSERT INTO biblioteca VALUES ('Retiro', 'Dr. Esquerdo, 189');
INSERT INTO biblioteca VALUES ('Moratalaz', 'Corregidor Alonso de Tobar, 5');
INSERT INTO publicacion VALUES ('978-84-782-9085-7', 'Fundamentos de Sistemas de Bases de Datos',
                                'R. Elmasri, S.B. Navathe', 'Espanol', 'Addison-Wesley');
                                
SELECT * FROM publicacion;
SELECT * FROM editorial;
SELECT * FROM biblioteca;