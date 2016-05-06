CREATE OR REPLACE TRIGGER userid_autoincrement 
BEFORE INSERT ON users
FOR EACH ROW
DECLARE 
  max_id number;
  cur_seq number;
BEGIN 
  if :new.user_id is null then
        -- No ID passed, get one from the sequence
        select seq_user.nextval into :new.user_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(user_id),0), :new.user_id) into max_id from users;
        select seq_product.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_user.nextval into cur_seq from dual;
        end loop;
    end if;
END;
/


CREATE OR REPLACE TRIGGER productid_autoincrement 
BEFORE INSERT ON products
FOR EACH ROW
DECLARE 
  max_id number;
  cur_seq number;
BEGIN 
  if :new.product_id is null then
        -- No ID passed, get one from the sequence
        select seq_product.nextval into :new.product_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(product_id),0), :new.product_id) into max_id from products;
        select seq_product.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_PRODUCT.nextval into cur_seq from dual;
        end loop;
    end if;
END;
/

CREATE OR REPLACE TRIGGER categoryid_autoincrement 
BEFORE INSERT ON categories
FOR EACH ROW
DECLARE 
  max_id number;
  cur_seq number;
BEGIN 
  if :new.category_id is null then
        -- No ID passed, get one from the sequence
        select seq_category.nextval into :new.category_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(category_id),0), :new.category_id) into max_id from categories;
        select seq_category.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_category.nextval into cur_seq from dual;
        end loop;
    end if;
END;
/

CREATE OR REPLACE TRIGGER commentid_autoincrement 
BEFORE INSERT ON comments
FOR EACH ROW
DECLARE 
  max_id number;
  cur_seq number;
BEGIN 
  if :new.comment_id is null then
        -- No ID passed, get one from the sequence
        select seq_comment.nextval into :new.comment_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(comment_id),0), :new.comment_id) into max_id from Comments;
        select seq_category.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_comment.nextval into cur_seq from dual;
        end loop;
    end if;
END;
