-- -------------------------------------------------------------
-- SOLUCIONES EXAMEN DE JUNIO 2018. BASES DE DATOS GRUPOS B Y D
-- -------------------------------------------------------------
alter session set nls_date_format = 'DD/MM/YYYY';

drop table noticia cascade constraints;
drop table autor cascade constraints;
drop table periodico cascade constraints;

create table periodico(
    pid integer primary key,
    nombre varchar2(40),
    url varchar2(200)
);

create table autor(
    aid integer primary key,
    nombre varchar2(30),
    seccion varchar2(30)
);

create table noticia(
    nid integer primary key,
    titular varchar2(50),
    resumen varchar2(1000),
    url varchar2(200),
    pid references periodico,
    aid references autor,
    fecha date,
    numVisitas integer
);


INSERT INTO periodico VALUES (1, 'El Noticiero', 'http://www.elnoticiero.es');
INSERT INTO periodico VALUES (2, 'El Diario de Zaragoza', 'http://www.diariozaragoza.es');
INSERT INTO periodico VALUES (3, 'La Gaceta de Guadalajara', 'http://www.gacetaguadalajara.es');

insert into autor values (201,'Margarita Sanchez', 'nacional');
insert into autor values (202,'Angel Garcia', 'internacional');
insert into autor values (203,'Pedro Santillana', 'deportes');
insert into autor values (204,'Rosa Prieto', 'deportes');
insert into autor values (205,'Ambrosio Perez', 'nacional');
insert into autor values (206,'Lola Arribas', 'cultura');

INSERT INTO noticia VALUES (101, 'noticia 101',
       	    	    	   'noticia 101...',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 370);
INSERT INTO noticia VALUES (102, 'noticia 102',
       	    	    	   'noticia 102...',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 1940);
INSERT INTO noticia VALUES (103, 'noticia 103',
       	    	    	   'noticia 103...',
			   'http://www.gacetaguadalajara.es/nacional24',
			   3,204, TO_DATE('01/06/2018'), 490);
INSERT INTO noticia VALUES (104, 'noticia 104',
       	    	    	   'noticia 104...',
			   'http://www.diariozaragoza.es/deportes33',
			   2,203, TO_DATE('01/06/2018'), 2300);
INSERT INTO noticia VALUES (105, 'noticia 105',
       	    	    	   'noticia 105...',
			   'http://www.diariozaragoza.es/ibex9000',
			   2,202, TO_DATE('01/06/2018'), 2300);

INSERT INTO noticia VALUES (106, 'noticia 106',
       	    	    	   'noticia 106...',
			   'http://www.elnoticiero.es/ibex9001',
			   1,206, TO_DATE('22/06/2018'), 23);
INSERT INTO noticia VALUES (107, 'noticia 107',
       	    	    	   'noticia 107...',
			   'http://www.diariozaragoza.es/nacional22062018',
			   2,205, TO_DATE('22/06/2018'), 23);
INSERT INTO noticia VALUES (108, 'noticia 108',
       	    	    	   'noticia 108...',
			   'http://www.gacetaguadalajara.es/deportes33',
			   3,204, TO_DATE('22/06/2018'), 23);

COMMIT;


CREATE OR REPLACE PROCEDURE noticiasAutor(p_aid autor.aid%TYPE) AS
  CURSOR c_noticias IS
    SELECT a.titular, a.fecha, a.numVisitas
    FROM noticia a
    WHERE a.aid = p_aid
    ORDER BY a.fecha ASC;
  v_totalVisitas NUMBER := 0;
  v_nombre autor.nombre%TYPE;
  v_noticia c_noticias%ROWTYPE;
BEGIN
  -- Comprueba si existe el autor.
  SELECT nombre INTO v_nombre FROM autor WHERE aid = p_aid;
  OPEN c_noticias;
  FETCH c_noticias INTO v_noticia;
  -- Comprueba si tiene alguna noticia (tb. se puede hacer con
  -- un bucle FOR .. LOOP de cursor y una variable contador).
  IF c_noticias%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('El autor ' || p_aid ||
      ' no ha publicado ninguna noticia');
  ELSE
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(' Fecha       Visit Titular ');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    WHILE c_noticias%found LOOP
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_noticia.fecha,'DD-MM-YYYY') || '  ' ||
        TO_CHAR(v_noticia.numVisitas,'9G999') || ' ' ||
        v_noticia.titular);

      v_totalVisitas := v_totalVisitas + v_noticia.numVisitas;
      FETCH c_noticias INTO v_noticia;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total:      ' || TO_CHAR(v_totalVisitas,'9G999'));
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
  END IF;
  CLOSE c_noticias;
EXCEPTION                                  -- errata corregida 16.01.2019
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('El autor ' || p_aid || ' no existe.');
END;
/

-- Bloque anonimo para probar el procedimiento.
SET SERVEROUTPUT ON;
BEGIN
  noticiasAutor(204);
END;
/

create or replace procedure noticiasAutor2(idAutor autor.aid%TYPE) as

v_autor_existe integer;
v_numNoticias integer;
v_sumaVisitas integer;
v_nombre autor.nombre%type;
v_seccion autor.seccion%type;

cursor cr_autor is 
    select n.titular, n.fecha, n.numVisitas
    from  noticia n 
    where n.aid = idAutor
    order by n.fecha ASC;
    
no_noticias exception;

begin

select 0 into v_autor_existe from autor where aid = idAutor;
select count(*) into v_numNoticias from noticia n where n.aid = idAutor;
select nombre into v_nombre from autor where aid = idAutor;
select seccion into v_seccion from autor where aid = idAutor;

DBMS_OUTPUT.PUT_LINE('Autor: '|| rpad (v_nombre, 20) || ' Aid: ' || to_char(idautor)||' seccion: ' ||v_seccion );
DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE('--------FECHA----------------VISITAS------------TITULAR----');
DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
v_sumaVisitas:=0;

for r_autor in cr_autor loop
DBMS_OUTPUT.PUT_LINE(r_autor.fecha||'        ' || to_char (r_autor.numVisitas) || '       ' || r_autor.titular);
 
v_sumaVisitas := v_sumaVisitas +r_autor.numVisitas;
end loop;

DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE('Total: '|| to_char(v_sumaVisitas));

if v_numNoticias =0 then
    raise no_noticias;
end if;

exception 
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Este autor no existe');
    when no_noticias then
        DBMS_OUTPUT.PUT_LINE('Este autor no ha publicado noticias');
        
END;
/


SET SERVEROUTPUT ON;
BEGIN
  noticiasAutor2(204);
END;
/