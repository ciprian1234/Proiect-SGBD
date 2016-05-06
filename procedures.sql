CREATE OR REPLACE PROCEDURE registerUser(username IN VARCHAR2,password IN VARCHAR2,email IN VARCHAR2,address in VARCHAR2,telephone IN VARCHAR2)
IS
alreadyRegistered exception;
passwordToShort exception;
e_username number(2);
BEGIN
   
  select count(*) INTO e_username from users where user_username = username;
    if (e_username = 0) then
      if(length(password) < 6) then
        RAISE_APPLICATION_ERROR(-20001,'passwordToShort');
      end if;
      INSERT INTO users(user_username,user_password,user_email,user_adress,user_telephone) VALUES(username,password,email,address,telephone);
    ELSE
      RAISE_APPLICATION_ERROR(-20002,'usernameAlreadyUsed');
    end if;
END;
/


CREATE OR REPLACE PROCEDURE getRandomProducts(productsCursor OUT SYS_REFCURSOR, nr_produse IN integer)
IS
BEGIN
  open productsCursor for select * from products;
END;
/

set serveroutput on;
DECLARE
  prodCursor SYS_REFCURSOR;
BEGIN
  getRandomProducts(prodCursor, 5);
  dbms_output.put_line(prodCursor%rowcount);
  --FOR v_row_products IN prodCursor LOOP
  --  dbms_output.put_line(v_row_products.product_name);
  --END LOOP;
END;
/