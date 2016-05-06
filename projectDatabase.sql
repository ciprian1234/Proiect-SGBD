drop table Comments;
drop table Products;
drop table Categories;
drop table Users;
drop sequence seq_category;
drop sequence seq_product;
drop sequence seq_comment;


CREATE TABLE Categories (
  category_id NUMBER(3) NOT NULL PRIMARY KEY,
  category_name VARCHAR(50) NOT NULL,
  category_description VARCHAR(100) NOT NULL
);
/

CREATE TABLE Products (
  product_id number(10) NOT NULL PRIMARY KEY,
  product_category number(3) NOT NULL,
  product_image VARCHAR2(200),
  product_price NUMBER(10,2) NOT NULL,
  product_name VARCHAR2(200) NOT NULL,
  product_quantity NUMBER(5) NOT NULL,
  CONSTRAINT fk_Category FOREIGN KEY(product_category)
  REFERENCES Categories(category_id)
);
/

CREATE TABLE Users (
  user_id NUMBER(3) NOT NULL PRIMARY KEY,
  user_username VARCHAR2(50) NOT NULL UNIQUE,
  user_password VARCHAR2(50) NOT NULL,
  user_email VARCHAR2(100) NOT NULL,
  user_telephone VARCHAR2(20) NOT NULL,
  user_adress VARCHAR2(100) NOT NULL
);
/

CREATE TABLE Comments (
  comment_id integer NOT NULL PRIMARY KEY,
  user_id NUMBER(3) NOT NULL,
  product_id number(10) NOT NULL,
  text varchar2(1000),
  rating number(2,1),
  pros integer,
  cons integer,
  CONSTRAINT fk_comment_user FOREIGN KEY (user_id) 
    REFERENCES Users(user_id),
  CONSTRAINT fk_comment_product FOREIGN KEY (product_id) 
    REFERENCES Products(product_id)
);
/

CREATE SEQUENCE seq_user;
CREATE SEQUENCE seq_category;
CREATE SEQUENCE seq_product;
CREATE SEQUENCE seq_comment;