CREATE OR REPLACE PACKAGE javaApp IS
  procedure registerUser(username IN VARCHAR2,password IN VARCHAR2,email IN VARCHAR2,address in VARCHAR2,telephone IN VARCHAR2);
  procedure getRandomProducts(productsCursor out SYS_REFCURSOR, nr_produse in integer);
  procedure setDiscount(procent IN int);
END javaApp;
/

CREATE OR REPLACE PACKAGE db_management IS
  procedure export_products(filename varchar2);
  procedure insert_random_users(p_number int);
  procedure insert_random_products(p_number int);
END db_management;
/

CREATE OR REPLACE PACKAGE BODY db_management IS

  procedure export_products(filename varchar2) IS
  BEGIN
    dbms_output.put_line('export');
  END export_products;
  
  procedure insert_random_users(p_number int)
  IS
    v_username varchar2(50);
    v_password varchar2(50);
    v_email varchar2(50);
    v_telephone varchar2(20) := '0741231234';
    v_address varchar2(50);
    v_contor integer := 1;
  BEGIN
    FOR index_1 IN 97..122 LOOP
      FOR index_2 IN 97..122 LOOP
        FOR index_3 IN 97..122 LOOP
          FOR index_4 IN 97..122 LOOP
              v_username := chr(index_1)||chr(index_2)||chr(index_3)||chr(index_4);
              v_password := 'p'||v_username;
              v_email := 'random_email'||to_char(v_contor)||'@gmail.com';
              v_address := 'random address '||to_char(v_contor);
              v_contor := v_contor + 1;
              insert into users(user_username, user_password, user_email, user_telephone, user_adress) 
                values (v_username, v_password, v_email, v_telephone, v_address);
          END LOOP;
        END LOOP;
      END LOOP;
    END LOOP;
  END insert_random_users;
  
  
  procedure insert_random_products(p_number int)
  IS
    v_category int:= 1;
    v_image varchar2(50) := 'img/default.jpg';
    v_price products.product_price%type := 999.99;
    v_name products.product_name%type := 'Default name';
    v_quantity products.product_quantity%type := 100;
  BEGIN
  
      v_category := 1;
      v_image := 'img/telefon.jpg';
      FOR v_index IN 1..p_number LOOP
        v_price := dbms_random.value(100, 1000);
        v_quantity := dbms_random.value(10, 100);
        v_name := 'Model telefon '||to_char(v_index);
        INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
          VALUES(v_category, v_image, v_price, v_name, v_quantity);
      END LOOP;
      
      v_category := 2;
      v_image := 'img/laptop.jpg';
      FOR v_index IN 1..p_number LOOP
        v_price := dbms_random.value(1000, 5000);
        v_quantity := dbms_random.value(10, 100);
        v_name := 'Model laptop '||to_char(v_index);
        INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
          VALUES(v_category, v_image, v_price, v_name, v_quantity);
      END LOOP;
      
      v_category := 3;
      v_image := 'img/book.jpg';
      FOR v_index IN 1..p_number LOOP
        v_price := dbms_random.value(4, 150);
        v_quantity := dbms_random.value(10, 100);
        v_name := 'Nume carte '||to_char(v_index);
        INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
          VALUES(v_category, v_image, v_price, v_name, v_quantity);
      END LOOP;
      
      v_category := 4;
      v_image := 'img/game.jpg';
      FOR v_index IN 1..p_number LOOP
        v_price := dbms_random.value(5, 300);
        v_quantity := dbms_random.value(10, 100);
        v_name := 'Nume joc '||to_char(v_index);
        INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
          VALUES(v_category, v_image, v_price, v_name, v_quantity);
      END LOOP;
      
  END insert_random_products;
  
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