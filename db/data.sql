--useri
insert into users(user_username, user_password, user_email, user_telephone, user_adress) 
  values ('ciprian', 'ciprian', 'asd@gmail.com', '0747190637', 'Str Crizantemelor Nr 7');
insert into users(user_username, user_password, user_email, user_telephone, user_adress)
  values ('marius', 'marius', 'bcdef@gmail.com', '0741234123', 'Bacau ...');

BEGIN
  db_management.insert_random_users(1);
END;
/

--Categorii
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('SmartPhones','Smartphones description...');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('Laptops','Laptops description...');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('Books','All the books you want to read are here');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('Video Games','Games description...');

INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
  VALUES(1,'img/samsung6e.jpg',3600,'Samsung Galaxy S6 Edge',100);
INSERT INTO Products(PRODUCT_CATEGORY, PRODUCT_IMAGE, PRODUCT_PRICE,PRODUCT_NAME, PRODUCT_QUANTITY) 
  VALUES(2,'img/laptop.jpg', 2999, 'Laptop Asus K53SD', 10);
INSERT INTO Products(PRODUCT_CATEGORY, PRODUCT_IMAGE, PRODUCT_PRICE,PRODUCT_NAME, PRODUCT_QUANTITY) 
  VALUES(3,'img/book.jpg', 199,'A game of thrones, George R.R. Martin', 99);
INSERT INTO Products(PRODUCT_CATEGORY, PRODUCT_IMAGE, PRODUCT_PRICE,PRODUCT_NAME, PRODUCT_QUANTITY) 
  VALUES(4,'img/csgo.jpg', 59,'Counter Strike Global Offensive', 1000);

BEGIN
  db_management.insert_random_products(100);
END;
/