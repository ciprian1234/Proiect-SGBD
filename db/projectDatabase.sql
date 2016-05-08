drop table Transactions;
drop table Comments;
drop table Products;
drop table Categories;
drop table Users;
drop sequence seq_user;
drop sequence seq_category;
drop sequence seq_product;
drop sequence seq_comment;
drop sequence seq_transaction;


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
  product_discount NUMBER(2,0) DEFAULT 0,
  CONSTRAINT fk_Category FOREIGN KEY(product_category)
  REFERENCES Categories(category_id)
);
/

CREATE TABLE Users (
  user_id integer NOT NULL PRIMARY KEY,
  user_username VARCHAR2(50) NOT NULL,
  user_password VARCHAR2(50) NOT NULL,
  user_email VARCHAR2(100) NOT NULL,
  user_telephone VARCHAR2(20) NOT NULL,
  user_adress VARCHAR2(100) NOT NULL,
  user_wallet number(10,2) DEFAULT 0 NOT NULL
);
/

CREATE TABLE Comments (
  comment_id integer NOT NULL PRIMARY KEY,
  user_id integer NOT NULL,
  product_id integer NOT NULL,
  comment_text varchar2(1000),
  comment_rating number(2,1),
  comment_pros integer,
  comment_cons integer,
  CONSTRAINT fk_comment_user FOREIGN KEY (user_id) 
    REFERENCES Users(user_id),
  CONSTRAINT fk_comment_product FOREIGN KEY (product_id) 
    REFERENCES Products(product_id)
);
/

CREATE TABLE Transactions (
  transaction_id integer NOT NULL PRIMARY KEY,
  user_id integer NOT NULL,
  product_id integer NOT NULL,
  transaction_quantity number(5) default 1 not null,
  transaction_date date,
  transaction_price number(10,2),
  CONSTRAINT fk_transaction_user FOREIGN KEY (user_id) 
    REFERENCES Users(user_id),
  CONSTRAINT fk_transaction_product FOREIGN KEY (product_id) 
    REFERENCES Products(product_id)
);

CREATE SEQUENCE seq_user;
CREATE SEQUENCE seq_category;
CREATE SEQUENCE seq_product;
CREATE SEQUENCE seq_comment;
CREATE SEQUENCE seq_transaction;