CREATE DATABASE IF NOT EXISTS user_manager;
USE user_manager;

CREATE TABLE users (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120)
);
select *
from users;
insert into users(`name`,email,country)
value(?,?,?);
delete from users 
where users.id =?;