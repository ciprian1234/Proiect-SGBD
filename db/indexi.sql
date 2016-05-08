create unique index index_login on users (user_username, user_password);
select * from users where user_username = 'azab';