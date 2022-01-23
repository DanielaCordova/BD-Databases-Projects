alter session set nls_date_format='DD/MM/YYYY';

drop table certificado cascade constraints;
drop table empleado cascade constraints;
drop table avion cascade constraints;
drop table vuelo cascade constraints;

create table vuelo(
	flno number(4,0) primary key,
	origen varchar2(20),
	destino varchar2(20),
	distancia number(6,0),
	salida date,
	llegada date,
	precio number(7,2));

create table avion(
	aid number(9,0) primary key,
	nombre varchar2(30),
	autonomia number(6,0));

create table empleado(
	eid number(9,0) primary key,
	nombre varchar2(30),
	salario number(10,2));

create table certificado(
	eid number(9,0),
	aid number(9,0),
	primary key(eid,aid),
	foreign key(eid) references empleado,
	foreign key(aid) references avion); 



INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (99.0,'Los Angeles','Washington D.C.',2308.0,to_date('04/12/2005 09:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:40', 'dd/mm/yyyy HH24:MI'),235.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (13.0,'Los Angeles','Chicago',1749.0,to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (346.0,'Los Angeles','Dallas',1251.0,to_date('04/12/2005 11:50', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),225-43);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (387.0,'Los Angeles','Boston',2606.0,to_date('04/12/2005 07:03', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 05:03', 'dd/mm/yyyy HH24:MI'),261.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (7.0,'Los Angeles','Sydney',7487.0,to_date('04/12/2005 05:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:10', 'dd/mm/yyyy HH24:MI'),278.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (2.0,'Los Angeles','Tokyo',5478.0,to_date('04/12/2005 06:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:55', 'dd/mm/yyyy HH24:MI'),780.99);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (33.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 09:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:15', 'dd/mm/yyyy HH24:MI'),375.23);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (34.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 12:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:18', 'dd/mm/yyyy HH24:MI'),425.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (76.0,'Chicago','Los Angeles',1749.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:03', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (68.0,'Chicago','New York',802.0,to_date('04/12/2005 09:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:02', 'dd/mm/yyyy HH24:MI'),202.45);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (7789.0,'Madison','Detroit',319.0,to_date('04/12/2005 06:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:19', 'dd/mm/yyyy HH24:MI'),120.33);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (701.0,'Detroit','New York',470.0,to_date('04/12/2005 08:55', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:26', 'dd/mm/yyyy HH24:MI'),180.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (702.0,'Madison','New York',789.0,to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),202.34);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (4884.0,'Madison','Chicago',84.0,to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:02', 'dd/mm/yyyy HH24:MI'),112.45);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (2223.0,'Madison','Pittsburgh',517.0,to_date('04/12/2005 08:02', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:01', 'dd/mm/yyyy HH24:MI'),189.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (5694.0,'Madison','Minneapolis',247.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:33', 'dd/mm/yyyy HH24:MI'),120.11);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (304.0,'Minneapolis','New York',991.0,to_date('04/12/2005 10:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 01:39', 'dd/mm/yyyy HH24:MI'),101.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (149.0,'Pittsburgh','New York',303.0,to_date('04/12/2005 09:42', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:09', 'dd/mm/yyyy HH24:MI'),1165.00);

Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('1','Boeing 747-400','8430');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('3','Airbus A340-300','7120');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('4','British Aerospace Jetstream 41','1502');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('5','Embraer ERJ-145','1530');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('7','Piper Archer III','520');


Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('567354612','Lisa Walker','256481');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('254099823','Patricia Jones','223000');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('355548984','Angela Martinez','212156');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('310454876','Joseph Thompson','212156');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('269734834','George Wright','289950');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('552455348','Dorthy Lewis','251300');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('486512566','David Anderson','43001');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('573284895','Eric Cooper','114323');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('574489457','Milo Brooks','20');


Insert into CERTIFICADO (EID,AID) values ('269734834','1');
Insert into CERTIFICADO (EID,AID) values ('269734834','3');
Insert into CERTIFICADO (EID,AID) values ('269734834','4');
Insert into CERTIFICADO (EID,AID) values ('269734834','5');
Insert into CERTIFICADO (EID,AID) values ('269734834','7');
Insert into CERTIFICADO (EID,AID) values ('567354612','1');
Insert into CERTIFICADO (EID,AID) values ('567354612','3');
Insert into CERTIFICADO (EID,AID) values ('567354612','4');
Insert into CERTIFICADO (EID,AID) values ('567354612','5');
Insert into CERTIFICADO (EID,AID) values ('567354612','7');
Insert into CERTIFICADO (EID,AID) values ('573284895','3');
Insert into CERTIFICADO (EID,AID) values ('573284895','4');
Insert into CERTIFICADO (EID,AID) values ('573284895','5');
Insert into CERTIFICADO (EID,AID) values ('574489457','7');

commit;

--Ejercicio 1. Escribe un procedimiento PL/SQL denominado AvionesVuelo que reciba como par´ametro de entrada
--un numero de vuelo y que que escriba en pantalla (PUT LINE) 
--todos los modelos de avion que pueden realizar el
--trayecto. Por cada modelo de avi´on, debe escribir el n´umero total de empleados
--certificados para ese modelo y su
--salario medio. Por ejemplo1
--:
---------------------------------------------------------------
--Aviones para el vuelo 2 (5478 millas)
---------------------------------------------------------------
--AID Modelo de avion Num.emp. Salario medio
---------------------------------------------------------------
--1 Boeing 747-400 4 244,776.75
--3 Airbus A340-300 6 217,597.67
--9 Lockheed L1011 4 242,685.75
--11 Boeing 777-300 3 257,973.33
--12 Boeing 767-400ER 6 209,557.00
---------------------------------------------------------------
--OPCIONAL: Por cada modelo de avi´on, escribe la lista de los empleados certificados y sus salarios; una vez
--escritos los empleados, debe escribir el n´umero total de empleados certificados para ese modelo y su salario medio.
--Por ejemplo1
--:
---------------------------------------------------
--Aviones para el vuelo 2 (5478 millas)
---------------------------------------------------
--1 Boeing 747-400
--Betty Adams 227,489.00
--George Wright 289,950.00
--Karen Scott 205,187.00
--Lisa Walker 256,481.00
--1 Num.empleados: 4 - Sal.medio: 244,776.75
---------------------------------------------------
--3 Airbus A340-300
--Betty Adams 227,489.00
--Eric Cooper 114,323.00
--George Wright 289,950.00
--Lawrence Sperry 212,156.00
--Lisa Walker 256,481.00
--Mark Young 205,187.00
--3 Num.empleados: 6 - Sal.medio: 217,597.67
---------------------------------------------------
--9 Lockheed L1011
--Angela Martinez 212,156.00
--George Wright 289,950.00

 
CREATE OR REPLACE PROCEDURE AvionesVuelo1(v_flno IN vuelo.flno%TYPE) IS
  v_distancia vuelo.distancia%TYPE;
  v_avion     avion.aid%TYPE;
  CURSOR c_AvionesVuelo IS
    SELECT a.aid, a.nombre, count(*) numEmp, avg(e.salario) mediaEmp
    FROM avion a 
    JOIN certificado c ON a.aid = c.aid
    JOIN empleado e ON c.eid = e.eid
    WHERE a.autonomia >= v_distancia -- Se utiliza la var. local v_distancia 
                                     -- para seleccionar los aviones con 
                                     -- autonomia suficiente.
    GROUP BY a.aid, a.nombre
    ORDER BY a.aid;
BEGIN
  -- Primero recuperamos en v_distancia la distancia que deben
  -- poder recorrer los aviones seleccionados.
  SELECT vuelo.distancia INTO v_distancia
  FROM vuelo WHERE flno = v_flno;

  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Aviones para el vuelo ' || v_flno || ' (' || v_distancia || ' millas)');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('AID Modelo de avion                Num.emp.    Salario medio');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
  FOR r_av IN c_AvionesVuelo LOOP
    DBMS_OUTPUT.PUT_LINE(to_char(r_av.aid,'99') || ' ' 
      || rpad(r_av.nombre,35) || to_char(r_av.numEmp,'999') || '      ' 
      || to_char(r_av.mediaEmp,'999G999D99'));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
END;
/

-- Para probar el procedimiento utilizamos un bloque anÃ³nimo:
BEGIN
  AvionesVuelo1(2);
END;
/

CREATE OR REPLACE PROCEDURE AvionesVuelo2(v_flno IN vuelo.flno%TYPE) IS
  v_distancia vuelo.distancia%TYPE;
  v_avion     avion.aid%TYPE;
  
  CURSOR c_AvionesVuelo IS
    SELECT a.aid, a.nombre, count(*) numEmp, avg(e.salario) mediaEmp
    FROM avion a 
    JOIN certificado c ON a.aid = c.aid
    JOIN empleado e ON c.eid = e.eid
    WHERE a.autonomia >= v_distancia -- Se utiliza la var. local v_distancia 
                                     -- para seleccionar los aviones con 
                                     -- autonomia suficiente.
    GROUP BY a.aid, a.nombre
    ORDER BY a.aid;
    
     CURSOR cr_Empleados IS
     SELECT e.nombre, e.salario
     FROM certificado c JOIN empleado e ON c.eid = e.eid
    WHERE c.aid = v_avion  
    ORDER BY e.nombre;

BEGIN
  -- Primero recuperamos en v_distancia la distancia que deben
  -- poder recorrer los aviones seleccionados.
  SELECT vuelo.distancia INTO v_distancia
  FROM vuelo WHERE flno = v_flno;

  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Aviones para el vuelo ' || v_flno || ' (' || v_distancia || ' millas)');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');

  FOR r_av IN c_AvionesVuelo LOOP
    DBMS_OUTPUT.PUT_LINE(to_char(r_av.aid,'99') || ' ' 
      || rpad(r_av.nombre,35));
      
      v_avion := r_av.aid;
      FOR r_emp IN cr_Empleados LOOP
      DBMS_OUTPUT.PUT_LINE( '    ' || RPAD(r_emp.nombre,30)|| ' ' || to_char(r_emp.salario, '999G999D99'));
      END LOOP;
      
       DBMS_OUTPUT.PUT_LINE(to_char(r_av.aid,'99') || ' Num de Empleados:' 
      ||  to_char(r_av.numEmp) || ' Sal. Medio: ' 
      || to_char(r_av.mediaEmp,'999G999D99'));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
END;
/

-- Para probar el procedimiento utilizamos un bloque anÃ³nimo:
BEGIN
  AvionesVuelo2(2);
END;
/
 

--Ejercicio 2. Debes escribir dos triggers como se indican a continuaci´on:
--El primer trigger debe dispararse cuando se modifique el salario de un empleado. 
--Si el salario se ha incrementado, debe 
--insertar una fila en una tabla de log denominada incidencias con las siguientes columnas y
--contenidos:
--• Fecha y hora de la incidencia: debe contener el instante en el que ha ocurrido la incidencia (SYSDATE).
--• Usuario: el identificador del usuario con el que se ha producido la incidencia (USER).
--• Descripcion: Texto de la incidencia. En este caso: ’Se ha incrementado el salario del empleado
--X de Y a Z.’, donde X es el nombre del empleado, Y es el sueldo antes del cambio y Z es el sueldo
--despu´es del cambio.

DROP TABLE incidencias;
CREATE TABLE incidencias
    ( fecha DATE NOT NULL,
    usuario varchar2(20) NOT NULL,
    descripcion varchar2(80) NOT NULL
    );
    
-- TRIGGER 1--------------------------------------------------------------

CREATE OR REPLACE TRIGGER mdf_empleado_salario
BEFORE UPDATE OF salario ON empleado
FOR EACH ROW
BEGIN
        IF :OLD.salario < :NEW.salario THEN
            INSERT INTO incidencias VALUES (SYSDATE, USER, 'Se ha incrementado el salario del empleado ' ||
            :NEW.nombre || ' de ' || :OLD.salario || ' a ' || :NEW.salario || '.');
        END IF;
END;
/

--SELECT * FROM empleado;
--update empleado set salario = salario*10 where eid=574489457;
--select* FROM incidencias;
--CREATE OR REPLACE TRIGGER 

-- TRIGGER 2--------------------------------------------------------------

--Crea otro trigger sobre la tabla certificado que se dispare cuando se inserte o elimine una fila de la tabla.
--Cuando se inserte una fila, debe incrementar el salario del empleado afectado un 3 %. Cuando se elimine una
--fila, debe comprobar que el avi´on pueda realizar alg´un vuelo. Si es as´?, debe insertar en la tabla incidencias
--una fila con el texto ’El avi´on X tiene un empleado certificado menos.’.
--Comprueba el funcionamiento de los triggers realizando modificaciones en las tablas afectadas. En particular,
--comprueba que cuando se inserta una fila en la tabla certificado se a˜nade autom´aticamente una fila en la tabla
--incidencias.

CREATE OR REPLACE TRIGGER mdf_certificado
BEFORE INSERT OR DELETE ON certificado
FOR EACH ROW
DECLARE
    v_vuelos NUMBER :=0;
BEGIN
        IF INSERTING THEN 
            UPDATE empleado SET salario = round(salario * 1.03,2)
            WHERE eid = :NEW.eid;
        ELSIF DELETING THEN 
            select count(*) into v_vuelos
            FROM avion a JOIN vuelo v ON a.autonomia >= distancia
            WHERE a.aid = :OLD.aid;
            
           if v_vuelos>0 then
           insert into incidencias VALUES (SYSDATE, USER, 'El avion '|| :OLD.aid || ' tiene un empleado certificado menos.');
           end if;  
        END IF;
END;
/


select* from incidencias;
select*from empleado;
Insert into CERTIFICADO (EID,AID) values ('574489457','1');
delete from certificado where aid = 1 and eid = 574489457;
SELECT* FROM certificado;
