create database if not exists bai1;
use bai1;
CREATE TABLE class (
    id INT KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);
CREATE TABLE teacher (
    id INT KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    age INT,
    country VARCHAR(50)
);
SELECT 
    *
FROM
    class;
insert into class(`name`) 
values ('C0823G1'),('C0923G1');
SELECT 
    *
FROM
    teacher;
insert into teacher (`name`, age, country)
values ('Giau', 21, 'Da Nang'),
		('Cuong', 21, 'Ha Noi');