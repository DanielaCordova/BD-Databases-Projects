alter session set nls_date_format='DD/MM/YYYY';

-------------------------------------------------------
-- BD del ejercicio de la Librería de Babel
-------------------------------------------------------

drop table LB_Cliente cascade constraints;
drop table LB_Pedido cascade constraints;
drop table LB_Autor cascade constraints;
drop table LB_Autor_Libro cascade constraints;
drop table LB_Libro cascade constraints;
drop table LB_Libros_Pedido cascade constraints;

create table LB_Cliente
(IdCliente CHAR(10) PRIMARY KEY,
 Nombre VARCHAR(25) NOT NULL,
 Direccion VARCHAR(60) NOT NULL,
 NumTC CHAR(16) NOT NULL);
 
create table LB_Pedido
(IdPedido CHAR(10) PRIMARY KEY,
 IdCliente CHAR(10) NOT NULL REFERENCES LB_Cliente on delete cascade,
 FechaPedido DATE NOT NULL,
 FechaExped DATE);

create table LB_Autor
( idautor NUMBER PRIMARY KEY,
  Nombre VARCHAR(25));

create table LB_Libro
(ISBN CHAR(15) PRIMARY KEY,
Titulo VARCHAR(60) NOT NULL,
Anio CHAR(4) NOT NULL,
PrecioCompra NUMBER(6,2) DEFAULT 0,
PrecioVenta NUMBER(6,2) DEFAULT 0);

create table LB_Autor_Libro
(ISBN CHAR(15),
Autor NUMBER,
CONSTRAINT al_PK PRIMARY KEY (ISBN, Autor),
CONSTRAINT libroA_FK FOREIGN KEY (ISBN) REFERENCES LB_Libro on delete cascade,
CONSTRAINT autor_FK FOREIGN KEY (Autor) REFERENCES LB_Autor);


create table LB_Libros_Pedido(
ISBN CHAR(15),
IdPedido CHAR(10),
Cantidad NUMBER(3) CHECK (cantidad >0),
CONSTRAINT lp_PK PRIMARY KEY (ISBN, idPedido),
CONSTRAINT libro_FK FOREIGN KEY (ISBN) REFERENCES LB_Libro on delete cascade,
CONSTRAINT pedido_FK FOREIGN KEY (IdPedido) REFERENCES LB_Pedido on delete cascade);

insert into LB_Cliente values ('0000001','Margarita Sanchez', 'Arroyo del Camino 2','1234567890123456');
insert into LB_Cliente values ('0000002','Angel Garcia', 'Puente Viejo 13', '1234567756953456');
insert into LB_Cliente values ('0000003','Pedro Santillana', 'Molino de Abajo 42', '1237596390123456');
insert into LB_Cliente values ('0000004','Rosa Prieto', 'Plaza Mayor 46', '4896357890123456');
insert into LB_Cliente values ('0000005','Ambrosio Perez', 'Corredera de San Antonio 1', '1224569890123456');
insert into LB_Cliente values ('0000006','Lola Arribas', 'Lope de Vega 32', '2444889890123456' );


insert into LB_Pedido values ('0000001P','0000001', TO_DATE('01/12/2011'),TO_DATE('03/12/2011'));
insert into LB_Pedido values ('0000002P','0000001', TO_DATE('01/12/2011'),null);
insert into LB_Pedido values ('0000003P','0000002', TO_DATE('02/12/2011'),TO_DATE('03/12/2011'));
insert into LB_Pedido values ('0000004P','0000004', TO_DATE('02/12/2011'),TO_DATE('05/12/2011'));
insert into LB_Pedido values ('0000005P','0000005', TO_DATE('03/12/2011'),TO_DATE('03/12/2011'));
insert into LB_Pedido values ('0000006P','0000003', TO_DATE('04/12/2011'),null);

insert into LB_Autor values (1,'Matilde Asensi');
insert into LB_Autor values (2,'Ildefonso Falcones');
insert into LB_Autor values (3,'Carlos Ruiz Zafon');
insert into LB_Autor values (4,'Miguel de Cervantes');
insert into LB_Autor values (5,'Julia Navarro');
insert into LB_Autor values (6,'Miguel Delibes');
insert into LB_Autor values (7,'Fiodor Dostoievski');

insert into LB_Libro values ('8233771378567', 'Todo bajo el cielo', '2008', 9.45, 13.45);
insert into LB_Libro values ('1235271378662', 'La catedral del mar', '2009', 12.50, 19.25);
insert into LB_Libro values ('4554672899910', 'La sombra del viento', '2002', 19.00, 33.15);
insert into LB_Libro values ('5463467723747', 'Don Quijote de la Mancha', '2000', 49.00, 73.45);
insert into LB_Libro values ('0853477468299', 'La sangre de los inocentes', '2011', 9.45, 13.45);
insert into LB_Libro values ('1243415243666', 'Los santos inocentes', '1997', 10.45, 15.75);
insert into LB_Libro values ('0482174555366', 'Noches Blancas', '1998', 4.00, 9.45);


insert into LB_Autor_Libro values ('8233771378567',1);
insert into LB_Autor_Libro values ('1235271378662',2);
insert into LB_Autor_Libro values ('4554672899910',3);
insert into LB_Autor_Libro values ('5463467723747',4);
insert into LB_Autor_Libro values ('0853477468299',5);
insert into LB_Autor_Libro values ('1243415243666',6);
insert into LB_Autor_Libro values ('0482174555366',7);

insert into LB_Libros_Pedido values ('8233771378567','0000001P', 1);
insert into LB_Libros_Pedido values ('5463467723747','0000001P', 2);
insert into LB_Libros_Pedido values ('0482174555366','0000002P', 1);
insert into LB_Libros_Pedido values ('4554672899910','0000003P', 1);
insert into LB_Libros_Pedido values ('8233771378567','0000003P', 1);
insert into LB_Libros_Pedido values ('1243415243666','0000003P', 1);
insert into LB_Libros_Pedido values ('8233771378567','0000004P', 1);
insert into LB_Libros_Pedido values ('4554672899910','0000005P', 1);
insert into LB_Libros_Pedido values ('1243415243666','0000005P', 1);
insert into LB_Libros_Pedido values ('5463467723747','0000005P', 3);
insert into LB_Libros_Pedido values ('8233771378567','0000006P', 5); 

commit;

--Ejercicio 1. Descarga del campus virtual el script 05sql2EjLibreria.sql que contiene la descripci´on de las tablas
--de la base de datos La Librer´?a de Babel junto con algunas sentencias de inserci´on de datos. Construye consultas
--SQL para recuperar la siguiente informaci´on y comprueba despu´es de ejecutar cada consulta que los resultados son
--correctos:

--1. Lista de libros disponibles con su autor y ano de publicaci´on ordenada por este ´ultimo.

SELECT l1.ISBN, l1.TITULO, la1.autor, l1.anio 
FROM LB_Libro l1 JOIN LB_Autor_Libro la1 ON l1.ISBN= la1.ISBN
ORDER BY l1.anio;

--2. Lista de libros disponibles publicados despu´es del a˜no 2000.
SELECT *
FROM LB_Libro
WHERE anio>2000;

--3. Lista de Clientes que han realizado alg´un pedido.
SELECT DISTINCT lc.idcliente, lc.nombre 
FROM  LB_Cliente lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente;

--4. Lista de clientes que han adquirido el libro con ISBN= 4554672899910.
SELECT DISTINCT lc.idcliente, lc.nombre 
FROM  LB_Cliente lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente 
JOIN LB_LIBROS_PEDIDO llp ON llp.idpedido = lp.idpedido
WHERE llp.isbn=4554672899910;

--5. Lista de los clientes y los libros adquiridos por ellos cuyo nombre (del cliente) 
--contenga ’San’.
SELECT DISTINCT lc.idcliente, lc.nombre, ll.titulo
FROM  LB_Cliente lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente 
JOIN LB_LIBROS_PEDIDO llp ON llp.idpedido = lp.idpedido
JOIN LB_LIBRO ll ON ll.isbn=llp.isbn
WHERE lc.nombre LIKE '%San%' ;

--6. Lista de Clientes que hayan comprado libros de m´as de 10 euros.
SELECT DISTINCT lc.idcliente, lc.nombre
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente
JOIN lb_libros_pedido llp ON llp.idpedido=lp.idpedido
JOIN LB_LIBRO ll ON ll.ISBN=llp.isbn
WHERE ll.precioventa>10;

--7. Clientes y fecha de pedidos que han realizado que no han sido expedidos a´un.
SELECT lc.idcliente, lc.nombre, lp.fechapedido
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente
WHERE lp.fechaexped is null;

--8. Lista de clientes que NO han comprado libros de precio superior a 10 euros.

Select lc2.nombre
FROM LB_CLIENTE lc2 
WHERE lc2.idcliente not in
(SELECT DISTINCT lc.idcliente
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lc.idcliente=lp.idcliente
JOIN lb_libros_pedido llp ON llp.idpedido=lp.idpedido
JOIN LB_LIBRO ll ON ll.ISBN=llp.isbn
WHERE ll.precioventa>10);

--9. Lista de libros vendidos con precio superior a 30 euros 
--o publicados antes del ano 2000.
SELECT DISTINCT ll.titulo, ll.anio, ll.precioventa
FROM LB_PEDIDO lp JOIN LB_LIBROS_PEDIDO llp ON llp.idpedido= lp.idpedido
JOIN LB_LIBRO ll ON ll.isbn=llp.isbn
WHERE ll.precioventa>30 or ll.anio<2000;

--10. Clientes que han hecho m´as de un pedido el mismo d´?a
SELECT lc.nombre
FROM LB_CLIENTE lc 
WHERE lc.idcliente = (SELECT lp.idcliente
FROM  LB_PEDIDO lp
GROUP BY lp.fechapedido, lp.idcliente
HAVING COUNT(*)>1);

--11. Lista de titulos de libros vendidos y cantidad.

SELECT ll.isbn, ll.titulo, sum (llp.cantidad)
FROM LB_PEDIDO lp JOIN LB_LIBROS_PEDIDO llp ON llp.idpedido=lp.idpedido
JOIN LB_LIBRO ll ON ll.isbn=llp.isbn
GROUP BY ll.isbn, ll.titulo;

--12. Lista de Clientes junto al importe total gastado en la librer´?a.
SELECT lc.idcliente, lc.nombre, sum(ll.precioventa*llp.cantidad)
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lp.idcliente=lc.idcliente
JOIN LB_LIBROS_PEDIDO llp ON lp.idpedido=llp.idpedido
JOIN LB_LIBRO ll ON ll.isbn= llp.isbn
GROUP BY lc.idcliente, lc.nombre;

--13. Ganancias obtenidas por la librer´?a con las ventas.
SELECT sum(ll.precioventa*llp.cantidad), sum(ll.preciocompra*llp.cantidad), sum((ll.precioventa-ll.preciocompra)*llp.cantidad)
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lp.idcliente=lc.idcliente
JOIN LB_LIBROS_PEDIDO llp ON lp.idpedido=llp.idpedido
JOIN LB_LIBRO ll ON ll.isbn= llp.isbn;


--14. Lista de importe total de pedidos por fecha, que se hayan realizado despu´es del 01/12/2011 y no hayan sido expedidos.
SELECT lp.fechapedido, sum(ll.precioventa*llp.cantidad)
FROM LB_CLIENTE lc JOIN LB_PEDIDO lp ON lp.idcliente=lc.idcliente
JOIN LB_LIBROS_PEDIDO llp ON lp.idpedido=llp.idpedido
JOIN LB_LIBRO ll ON ll.isbn= llp.isbn
where lp.fechaexped IS NULL
Group by lp.fechapedido
having lp.fechapedido>= '01-12-2011';

--15. Pedidos con importe superior a 100 euros.
SELECT lp.idpedido, lp.fechapedido, sum(ll.precioventa*llp.cantidad)
FROM LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido
Group by lp.idpedido, lp.fechapedido
having sum(ll.precioventa*llp.cantidad)>100;

--16. Pedidos con importe total que contengan m´as de un t´?tulo.
SELECT lp.idpedido, lp.fechapedido,sum(ll.precioventa*llp.cantidad)
FROM LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido
Group by lp.idpedido, lp.fechapedido
having count(*)>1;

--17. Pedidos con importe total que contengan m´as de 4 libros (ejemplares).
SELECT lp.idpedido, lp.fechapedido,sum(ll.precioventa*llp.cantidad), sum (llp.cantidad) as NumEjemplares
FROM LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido
Group by lp.idpedido, lp.fechapedido
having sum (llp.cantidad)>4;


--18. Lista de los libros m´as caros.
SELECT llf.titulo, llf.precioventa
from LB_LIBRO llf
where llf.precioventa = (
Select max(ll.precioventa)
        from (LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido));

--19. Libros de los que no se haya vendido ning´un ejemplar o cuyo beneficio sea inferior a 5 euros.
SELECT llf.isbn, llf.titulo
FROM LB_LIBRO llf
WHERE llf.isbn not in
(SELECT ll.isbn
FROM LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido
Group by lp.idpedido, ll.isbn)
or (llf.precioventa - llf.preciocompra)<5;

--20. Clientes que hayan pedido m´as de un ejemplar de un t´?tulo en alguna ocasi´on.
SELECT lc.idcliente, lc.nombre, lp.idpedido, ll.titulo
FROM LB_LIBRO ll JOIN LB_LIBROS_PEDIDO llp ON ll.isbn=llp.isbn
JOIN LB_PEDIDO lp ON lp.idpedido=llp.idpedido
JOIN LB_CLIENTE lc ON lc.idcliente = lp.idcliente
where llp.cantidad>1;

--21. Lista de Nombre de cliente, numero de pedido, isbn y t´?tulo de libros adquiridos. Si no han adquirido ning´un
--libro mostrar el nombre del cliente tambi´en.

SELECT lc.idcliente, lc.nombre, NVL(lp.idpedido, '') as IDPedido,NVL( ll.ISBN, '') as ISBN, NVL(ll.titulo,'')as Titulo
FROM LB_CLIENTE lc LEFT JOIN LB_PEDIDO lp ON lc.idcliente = lp.idcliente
left joiN LB_LIBROS_PEDIDO llp  ON lp.idpedido=llp.idpedido
left JOIN LB_LIBRO ll  ON ll.isbn=llp.isbn
