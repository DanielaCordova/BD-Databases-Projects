SET SERVEROUTPUT ON;
-- -------------------------------------------------------------
-- EJERCICIO EVALUABLE GRUPO A. 14.12.2018
-- -------------------------------------------------------------
alter session set nls_date_format = 'DD/MM/YYYY';

drop table ej_noticia cascade constraints;
drop table ej_autor cascade constraints;
drop table ej_periodico cascade constraints;

create table ej_periodico(
    IdPer integer primary key,
    Nombre varchar2(50),
    url varchar2(200),
    Idioma varchar2(3) -- puede ser 'en' (ingl√©s), 'es' (espa√±ol), 'fr', etc.
);

create table ej_autor(
    IdAutor integer primary key,
    nombre varchar2(30),
    totalVisitas integer
);

create table ej_noticia(
    IdNoticia integer primary key,
    titular varchar2(100),
    url varchar2(200),
    IdPer references ej_periodico,
    IdAutor references ej_autor,
    FechaPub date,
    NumVisitas integer
);


INSERT INTO ej_periodico VALUES (1, 'El Noticiero', 'http://www.elnoticiero.es','es');
INSERT INTO ej_periodico VALUES (2, 'El Diario de Zaragoza', 'http://www.diariozaragoza.es','es');
INSERT INTO ej_periodico VALUES (3, 'La Gaceta', 'http://www.gacetaguadalajara.es','en');
INSERT INTO ej_periodico VALUES (4, 'Toledo Tribune', 'http://www.toledotribune.es','en');
INSERT INTO ej_periodico VALUES (5, 'Alvarado Times', 'http://www.alvaradotimes.es','en');
INSERT INTO ej_periodico VALUES (6, 'El Retiro Noticias', 'http://www.elretironoticias.es','es');

insert into ej_autor values (201,'Margarita Sanchez',0);
insert into ej_autor values (203,'Pedro Santillana',0);
insert into ej_autor values (204,'Rosa Prieto',0);
insert into ej_autor values (206,'Lola Arribas',0);

INSERT INTO ej_noticia VALUES (101, 'El Banco de Inglaterra advierte de los peligros del Brexit',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 370);
INSERT INTO ej_noticia VALUES (102, 'La UE acabar√° con el 100% de las emisiones de CO2 para 2050',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 1940);
INSERT INTO ej_noticia VALUES (103, 'Madrid Central starts tomorrow',
			   'http://www.gacetaguadalajara.es/nacional24',
			   3,201, TO_DATE('01/06/2018'), 490);
INSERT INTO ej_noticia VALUES (104, 'El Ayuntamiento prepara diez nuevos carriles bici',
			   'http://www.diariozaragoza.es/movilidad33',
			   2,203, TO_DATE('01/06/2018'), 2300);
INSERT INTO ej_noticia VALUES (105, 'Un aragon√©s cruzar√° Siberia, de punta a punta en bici',
			   'http://www.diariozaragoza.es/ibex9000',
			   2,203, TO_DATE('01/11/2018'), 2300);
INSERT INTO ej_noticia VALUES (106, 'Hecatombe financiera ante un Brexit duro',
			   'http://www.diariozaragoza.es/ibex9000',
			   2,204, TO_DATE('01/11/2018'), 2220);

INSERT INTO ej_noticia VALUES (107, 'Fomento anuncia una estrategia nacional para fomentar la intermodalidad y el uso de la bicicleta',
			   'http://www.elnoticiero.es/ibex9001',
			   1,206, TO_DATE('22/06/2018'), 390);
INSERT INTO ej_noticia VALUES (108, 'As√≠ ser√° el carril bici que pasar√° por la puerta del Cl√≠nico',
			   'http://www.diariozaragoza.es/nacional22062018',
			   2,206, TO_DATE('13/11/2018'), 230);
INSERT INTO ej_noticia VALUES (109, 'How will traffic constraints affect you? La Gaceta answers your questions',
			   'http://www.gacetaguadalajara.es/deportes33',
			   3,204, TO_DATE('22/11/2018'), 123);
INSERT INTO ej_noticia VALUES (110, 'How will traffic constraints affect you? Toledo Tribune answers your questions',
			   'http://www.toledotribune.es/deportes33',
			   4,204, TO_DATE('22/11/2018'), 880);
INSERT INTO ej_noticia VALUES (111, 'Financial havoc if there is a hard Brexit',
			   'http://www.toledotribune.es/deportes44',
			   4,201, TO_DATE('22/11/2018'), 110);
INSERT INTO ej_noticia VALUES (112, 'Financial havoc if there is a hard Brexit',
			   'http://www.alvaradotimes.es/deportes44',
			   5,204, TO_DATE('22/10/2018'), 130);

COMMIT;


--1. Escribe un procedimiento almacenado NoticiasMasVistas que reciba como parametro un
--aòno y que muestre el nombre de cada periodico y a continuacion la lista de las noticias
--mas visitadas cada mes de ese aòno. Si un peri¥odico no tiene noticias durante ese aòno, debe
--mostrar para ese peri¥odico íNo se han publicado noticias durante XXXXí (donde XXXX  es el aòno).

--NOTICIAS MAS VISITADAS 2018
--Periodico : El Noticiero
--Mes: 6: La UE acabar¥a con el 100% de las emisiones de CO2 para 2050
--1940 Visitas.
--Periodico : El Diario de Zaragoza
--Mes: 6: El Ayuntamiento prepara diez nuevos carriles bici
--2300 Visitas.
--Mes: 11: Un aragon¥es cruzar¥a Siberia, de punta a punta en bici
--2300 Visitas.
--Periodico : El Retiro Noticias
--No se han publicado noticias durante 2018


create or replace procedure NoticiasMasVistas (p_anio NUMBER)is
v_IdPer ej_periodico.idper%TYPE;
v_numNoticias Integer;


cursor cr_periodico is
    select p.nombre, p.idper
    from ej_periodico p;
    
cursor cr_NoticiasMes is
    select extract(MONTH FROM n.fechapub)mes, n.idnoticia, n.titular, n.numvisitas
    from ej_noticia n
    where extract(YEAR FROM n.fechapub)= p_anio 
    and n.idper= v_IdPer
    and n.numvisitas = ( SELECT MAX(n2.numvisitas)
                        FROM ej_noticia n2
                        where extract(YEAR FROM n2.fechapub)= p_anio
                        and n2.idper=n.idper
                        and extract(MONTH FROM n2.fechapub)= extract(MONTH FROM n.fechapub)
                        );
begin
    DBMS_OUTPUT.PUT_LINE( 'NOTICIAS MAS VISITADAS ' || p_anio);
   for r_periodico in cr_periodico loop
    DBMS_OUTPUT.PUT_LINE( 'Periodico : ' || r_periodico.nombre);
    v_IdPer:=r_periodico.idper;
    v_numnoticias:=0;
    
    for r_noticias in cr_NoticiasMes loop
    v_numNoticias := v_numNoticias +1;
         DBMS_OUTPUT.PUT_LINE( 'Mes:' || to_char(r_noticias.mes, '99')||
                                ' : ' || RPAD(r_noticias.titular, 70));
    DBMS_OUTPUT.PUT_LINE( '          ' || r_noticias.numvisitas || ' Visitas ');                         
   end loop;
   if v_numNoticias=0 then 
     DBMS_OUTPUT.PUT_LINE( 'No se han publicado noticias durante ' || p_anio);
     end if;
   end loop;
end;
/

--begin 

 --   NoticiasMasVistas(2018);
  --  end;
 --   /




--2. Escribe un disparador ActualizaTotalAutor que, cuando se produzca cualquier cambio
--en la tabla ej noticia (por cualquier operaci¥on: inserci¥on, actualizaci¥on o borrado de
--filas), actualice correctamente el valor de la columna totalVisitas en las filas afectadas de
--ej autor. Se puede suponer que inicialmente este valor es correcto.
--Adem¥as, si el cambio de ej noticia es un incremento del n¥umero de visitas de la noticia,
--el disparador debe modificar la fecha de publicaci¥on de la noticia para que sea la
--fecha actual (SYSDATE).
--Incluye en la soluci¥on las sentencias necesarias para probar el disparador.


CREATE OR REPLACE TRIGGER ActualizaTotalAutor
BEFORE INSERT OR DELETE OR UPDATE ON ej_noticia
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE ej_autor SET TotalVisitas = TotalVisitas + :NEW.numVisitas
    WHERE :NEW.IdAutor = IdAutor;
  ELSIF DELETING THEN
    UPDATE ej_autor SET TotalVisitas = TotalVisitas - :OLD.numVisitas
    WHERE :OLD.IdAutor = IdAutor;
  ELSE
    IF :OLD.IdAutor != :NEW.IdAutor THEN
      UPDATE ej_autor SET TotalVisitas = TotalVisitas + :NEW.numVisitas
      WHERE :NEW.IdAutor = IdAutor;

      UPDATE ej_autor SET TotalVisitas = TotalVisitas - :OLD.numVisitas
      WHERE :OLD.IdAutor = IdAutor;
    ELSE
      UPDATE ej_autor 
      SET TotalVisitas = TotalVisitas - :OLD.numVisitas + :NEW.numVisitas
      WHERE :OLD.IdAutor = IdAutor;
    END IF;
    
    IF :OLD.NumVisitas < :NEW.NumVisitas THEN
      :NEW.FechaPub := SYSDATE;
    END IF;

  END IF;
END;
/


SELECT * FROM ej_autor;
SELECT * FROM ej_noticia;

INSERT INTO ej_noticia VALUES (113, 'Prueba', 'url', 5, 204, TO_DATE('22/10/2018'), 10);

UPDATE ej_noticia SET IdAutor = 201 WHERE IdNoticia = 113;

UPDATE ej_noticia SET NumVisitas = 30 WHERE IdNoticia = 113;

DELETE FROM ej_noticia WHERE IdNoticia = 113;



