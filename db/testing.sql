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


--log as SYS and execute grant execute on utl_file to system
--create directory produse as '/home/ciprian/Desktop/proiecte_fac/sgbd/proiect/db';
--trebuie privilegii write
BEGIN
  db_management.export_products('products.csv');
END;
/

--import
select * from products;
delete from products;
BEGIN
  db_management.import_products('products.csv');
END;
/
