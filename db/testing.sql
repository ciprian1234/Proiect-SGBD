set serveroutput on;
DECLARE
  lista_produse SYS_REFCURSOR;
  v_linie products%rowtype;
BEGIN
  javaApp.getRandomProducts(lista_produse, 5);
  LOOP
    fetch lista_produse into v_linie;
    EXIT WHEN lista_produse%NOTFOUND;
    dbms_output.put_line(v_linie.product_name);
  END LOOP;
END;
/