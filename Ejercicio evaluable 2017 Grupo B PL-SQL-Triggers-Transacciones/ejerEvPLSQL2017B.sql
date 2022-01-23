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



--Ejercicio 0. Para estos ejercicios debes utilizar las tablas y los datos del fichero Script Libreria.sql de los
--Ejercicios de SQL (II) del Campus Virtual. Ejecuta este script completo antes de continuar. Vamos a a˜nadir a
--la base de datos de la librer´?a una tabla para controlar el stock del almac´en de la tienda (n´umero de ejemplares de
--cada libro en el almac´en).
--a) Crea una tabla denominada Existencias que contendr´a los datos de los libros que tiene el almac´en de la
--librer´?a. Debe tener las siguientes columnas:
--• ISBN: C´odigo ISBN de los libros de la librer´?a.
--• Stock: n´umero de ejemplares disponibles en el almac´en de este libro.
--• StockMin: n´umero de ejemplares m´?nimo que debe haber en el almac´en; por debajo de este valor se
--deben pedir m´as ejemplares a la editorial.
--b) Escribe una sentencia INSERT que realice una carga inicial de la tabla Existencias. Esta sentencia debe
--insertar en esta tabla una fila por cada libro de la tabla Libro con los siguientes datos:
--• ISBN: C´odigo ISBN del libro correspondiente.
--• Stock: el resultado de la expresi´on 10 ? X, donde X es el n´umero total de ejemplares pedidos de ese
--libro hasta el momento (contenidos en la tabla Libros Pedido).
--• StockMin: el valor 5 en todas las filas.
-- 
DROP TABLE existencias;
CREATE TABLE Existencias (
  ISBN CHAR(15) PRIMARY KEY,
  Stock NUMBER(6) NOT NULL,
  StockMin NUMBER(6) NOT NULL
);

INSERT into existencias 
    SELECT l.isbn, 10 - sum(lp.cantidad), 5
    FROM LB_Libro l JOIN LB_Libros_Pedido lp ON l.isbn = lp.isbn
    Group by l.isbn;
    
select* from existencias;


--Ejercicio 1. Escribe un trigger que cuando se realice alg´un cambio en la tabla Libros Pedido,
--actualice la informaci´on de la columna Stock en la tabla Existencias: al a˜nadir una nueva entrada de un pedido,
--al eliminar
--una entrada de un pedido y al modificar la cantidad de una entrada de un pedido. Si la cantidad en Stock se hace
--negativa debe mostrar un mensaje de error por pantalla en el que se indique que el libro con ese ISBN tiene stock
--negativo.
--Inserta y actualiza algunos pedidos para que se ejecute el trigger y de esta forma se modifiquen los datos de la tabla
--Existencias de manera que haya varias filas en las que se cumpla Stock < StockMin.

drop trigger mdf_Libros_Pedido ;

create or replace trigger mdf_Libros_Pedido 
BEFORE INSERT OR UPDATE OR DELETE ON LB_Libros_Pedido FOR EACH ROW
DEClARE
    v_stock existencias.stock%TYPE;
BEGIN
    IF INSERTING THEN
        UPDATE existencias set stock = stock + :NEW.cantidad
        where isbn = :NEW.isbn;
    ELSIF DELETING THEN
        UPDATE existencias set stock = stock - :OLD.cantidad
        where isbn = :OLD.isbn;
    ELSE 
        UPDATE existencias set stock = stock - :OLD.cantidad + :NEW.cantidad
        where isbn = :OLD.isbn;
    
    SELECT e.stock INTO v_stock
    FROM existencias e
    WHERE e.isbn = :OLD.isbn;
    
    IF v_stock < 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: SIN EXISTENCIAS DEL LIBRO ' || :OLD.isbn);
    END IF;
        
    END IF;
    
    
END;
/

SET SERVEROUTPUT ON;

-- Para probar el trigger hay que ver el contenido de la tabla Existencias 
-- antes y despuÃ©s de modificar la tabla Libros_Pedido, en cada una de las
-- operaciones.  Ejecuta las siguientes sentencias paso a paso para ver
-- como se modifican los datos de las tablas.
--SELECT * FROM Existencias;
--SELECT * FROM lb_Libros_Pedido;
--
---- Caso de insercion.
--INSERT INTO LB_Libros_Pedido VALUES ('1243415243666','0000002P',6);
--
--SELECT * FROM Existencias WHERE ISBN = '1243415243666';
--
---- Caso de actualizacion.
--update lB_libros_pedido set cantidad = 4 
--where isbn='8233771378567' and idpedido='0000001P';
--
--SELECT * FROM Existencias WHERE ISBN = '8233771378567';
--
---- Caso de borrado.
--DELETE FROM LB_Libros_Pedido 
--WHERE ISBN = '1243415243666' AND idpedido = '0000002P';
--
--SELECT * FROM Existencias WHERE ISBN = '1243415243666';

--Ejercicio 2. Escribe un procedimiento PL/SQL denominado ListaPedidosUrgentes que escriba en pantalla
--(PUT LINE) todos los libros de los que se disponen menos existencias en stock de las indicadas en StockMin. De cada
--libro se deben mostrar en pantalla los siguientes datos: ISBN, t´?tulo, el n´umero de ejemplares que hay que pedir a
--la editorial para que en el almac´en se disponga de un stock igual a 2*StockMin, y por ´ultimo el importe de compra
--de estos ejemplares. Al final del listado se debe mostrar el importe total de los pedidos a realizar a la editorial.


create or replace procedure ListaPedidosUrgentes is

cursor cr_exis is
    select e.isbn, l.titulo, e.stock, e.stockmin, l.preciocompra
    FROM existencias e JOIN LB_Libro l ON e.isbn = l.isbn
    where e.stock < e.StockMin
    GROUP BY e.isbn, l.titulo, e.stock, e.stockmin, l.preciocompra;
BEGIN
     DBMS_OUTPUT.PUT_LINE('EXISTENCIAS CON STOCK< STOCKMIN ');
     for r_exis in cr_exis LOOP
     DBMS_OUTPUT.PUT_LINE('ISBN: ' || r_exis.isbn || ' Titulo: ' || r_exis.titulo || ' # ejemplares a pedir: '
     ||to_char( 2*r_exis.stockmin - r_exis.stock) || 'Importe de compra: ' || to_char(r_exis.preciocompra*(2*r_exis.stockmin - r_exis.stock)));
     end loop;
END;
/

BEGIN
  ListaPedidosUrgentes;
END;
/

SELECT * FROM Existencias;
