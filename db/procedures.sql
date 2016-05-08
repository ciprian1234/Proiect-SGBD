CREATE OR REPLACE PACKAGE javaApp IS
  procedure registerUser(username IN VARCHAR2,password IN VARCHAR2,email IN VARCHAR2,address in VARCHAR2,telephone IN VARCHAR2);
  procedure getRandomProducts(productsCursor out SYS_REFCURSOR, nr_produse in integer);
  procedure setDiscount(p_category IN int, p_discount IN int);
  procedure buyProduct(p_user_id IN int , p_product_id IN int, p_transaction_quantity IN int);
END javaApp;
/

CREATE OR REPLACE PACKAGE db_management IS
  procedure import_products(p_filename IN varchar2);
  procedure export_products(filename IN varchar2);
  procedure insert_random_users(p_number int);
  procedure insert_random_products(p_number int);
END db_management;
/

CREATE OR REPLACE PACKAGE BODY db_management IS
  --procedura import date csv
  procedure import_products(p_filename IN varchar2)
  IS
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2 (1000);
    v_category products.product_category%type:= 1;
    v_image products.product_image%type:= 'img/default.jpg';
    v_price products.product_price%type := 999.99;
    v_name products.product_name%type := 'Default name';
    v_quantity products.product_quantity%type := 100;
  BEGIN
    v_file := UTL_FILE.FOPEN ('PRODUSE', p_filename, 'r');
    IF UTL_FILE.IS_OPEN(v_file) THEN
      LOOP
        BEGIN
          UTL_FILE.GET_LINE(v_file, v_line, 1000);
          IF v_line IS NULL THEN
            EXIT;
          END IF;
          v_category := REGEXP_SUBSTR(V_LINE, '[^;]+', 1, 1);
          v_image := REGEXP_SUBSTR(V_LINE, '[^;]+', 1, 2);
          v_price := REGEXP_SUBSTR(V_LINE, '[^;]+', 1, 3);
          v_name := REGEXP_SUBSTR(V_LINE, '[^;]+', 1, 4);
          v_quantity := REGEXP_SUBSTR(V_LINE, '[^;]+', 1, 5);
          INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
            VALUES(v_category, v_image, v_price, v_name, v_quantity);
          COMMIT;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              EXIT;
          END;
      END LOOP;
    END IF;
    UTL_FILE.FCLOSE(v_file);
  END import_products;
  
  --procedura export date csv
  procedure export_products(filename varchar2)
  IS
    v_file UTL_FILE.FILE_TYPE;
    CURSOR c_products IS SELECT * from products;
    v_row products%ROWTYPE;
  BEGIN
    v_file := UTL_FILE.FOPEN('PRODUSE', filename,'w',32767);
    FOR v_row IN c_products LOOP
        UTL_FILE.PUT(v_file, v_row.product_category||';');
        UTL_FILE.PUT(v_file, v_row.product_image||';');
        UTL_FILE.PUT(v_file, v_row.product_price||';');
        UTL_FILE.PUT(v_file, v_row.product_name||';');
        UTL_FILE.PUT(v_file, v_row.product_quantity);
        UTL_FILE.NEW_LINE(v_file);
    END LOOP;
    UTL_FILE.FCLOSE(v_file);  
  END export_products;
    
  --procedura insert random users with
  --all combinations from a-z 4 characters
  --aproximativ 500.000 inregistrari
  procedure insert_random_users(p_number int)
  IS
    v_username varchar2(50);
    v_password varchar2(50);
    v_email varchar2(50);
    v_telephone varchar2(20) := '0741231234';
    v_address varchar2(50);
    v_wallet users.user_wallet%type;
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
              v_wallet := dbms_random.value(10, 9999);
              v_contor := v_contor + 1;
              insert into users(user_username, user_password, user_email, user_telephone, user_adress, user_wallet) 
                values (v_username, v_password, v_email, v_telephone, v_address, v_wallet);
          END LOOP;
        END LOOP;
      END LOOP;
    END LOOP;
  END insert_random_users;
  
  
  --procedura de generare produse random pentru fiecare categorie
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
    --IF(productsCursor is null) THEN
    --  RAISE_APPLICATION_ERROR(-20003,'invalidCursor');
    --END IF;
    IF(nr_produse <= 0) THEN
      RAISE_APPLICATION_ERROR(-20004,'secondParameterInvalid');
    END IF;
    open productsCursor for select * from (select * from products order by product_price)
                              where rownum <= nr_produse;
  END getRandomProducts;
  
  procedure setDiscount(p_category IN int, p_discount IN int)
  IS
    v_upper_bound integer;
  BEGIN
    select max(category_id) into v_upper_bound from categories;
    IF(p_category < 1 or p_category > v_upper_bound) THEN
      RAISE_APPLICATION_ERROR(-20005,'invalidCategory');
    END IF;
    update products set product_discount = p_discount 
      where product_category = p_category;
  END setDiscount;
  
  
  procedure buyProduct(p_user_id IN int , p_product_id IN int, p_transaction_quantity IN int)
  IS
    v_product_price products.product_price%type;
    v_product_quantity integer;
    v_product_discount products.product_discount%type;
    v_discount products.product_price%type;
    v_total_price transactions.transaction_price%type;
    v_user_wallet users.user_wallet%type;
  BEGIN
    
    select product_price, product_quantity, product_discount 
      into v_product_price, v_product_quantity, v_product_discount
        from products where product_id = p_product_id;
    IF(v_product_quantity - p_transaction_quantity < 0) THEN
      RAISE_APPLICATION_ERROR(-20006, 'outOfStockQuantityExcedeed');
    END IF;  
    
    v_discount := trunc(v_product_price * v_product_discount/100, 2);
    v_total_price := trunc((v_product_price - v_discount)*p_transaction_quantity, 2);
    
    select user_wallet into v_user_wallet from users where user_id = p_user_id;
    IF(v_user_wallet - v_total_price < 0) THEN
      RAISE_APPLICATION_ERROR(-20007, 'notEnoughMoney');
    END IF;
    
    insert into transactions(user_id, product_id, transaction_quantity, transaction_date, transaction_price)
      values(p_user_id, p_product_id, p_transaction_quantity, to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'), v_total_price);
    update users set user_wallet = v_user_wallet - v_total_price
      where user_id = p_user_id;
    update products set product_quantity = v_product_quantity - p_transaction_quantity
      where product_id = p_product_id;
  END buyProduct;
  
END javaApp;
/