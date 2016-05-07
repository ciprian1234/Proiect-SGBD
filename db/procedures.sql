CREATE OR REPLACE PACKAGE javaApp IS
  procedure registerUser(username IN VARCHAR2,password IN VARCHAR2,email IN VARCHAR2,address in VARCHAR2,telephone IN VARCHAR2);
  procedure getRandomProducts(productsCursor out SYS_REFCURSOR, nr_produse in integer);
  procedure setDiscount(procent IN int);
END javaApp;
/

CREATE OR REPLACE PACKAGE db_management IS
END db_management;
/



CREATE OR REPLACE PACKAGE BODY javaApp IS 

  PROCEDURE registerUser(username IN VARCHAR2, password IN VARCHAR2, email IN VARCHAR2, address in VARCHAR2, telephone IN VARCHAR2)
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
  END registerUser;


  PROCEDURE getRandomProducts(productsCursor OUT SYS_REFCURSOR, nr_produse IN integer)
  IS
  BEGIN
    open productsCursor for select * from products;
  END getRandomProducts;
  
  procedure setDiscount(procent IN int)
  IS
  BEGIN
    dbms_output.put_line('Discount: '||procent);
  END setDiscount;
  
END javaApp;
/



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