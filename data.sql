--useri
insert into users(user_username, user_password, user_email, user_telephone, user_adress) 
  values ('ciprian', 'ciprian', 'asd@gmail.com', '0747190637', 'Str Crizantemelor Nr 7');
insert into users(user_username, user_password, user_email, user_telephone, user_adress)
  values ('marius', 'marius', 'bcdef@gmail.com', '0741234123', 'Bacau ...');
insert into users(user_username, user_password, user_email, user_telephone, user_adress) 
  values ('admin', 'admin', 'admin@gmail.com', '0740000000', 'Not Needed');



--produse
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('SmartPhones','Smartphones description...');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('SmartPhones','Laptops description...');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('Books','All the books you want to read are here');
INSERT INTO CATEGORIES(category_name ,category_description) 
  VALUES('Video Games','Games description...');

INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
  VALUES(1,'img/samsung6e.jpg',3600,'Samsung Galaxy S6 Edge',100);
INSERT INTO Products(PRODUCT_CATEGORY,PRODUCT_IMAGE,PRODUCT_PRICE,PRODUCT_NAME,PRODUCT_QUANTITY) 
  VALUES(1,'img/csgo.jpg',40,'Counter Strike Global Offensive',1000);
