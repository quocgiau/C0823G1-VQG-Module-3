CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

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
    
INSERT INTO class(`name`) 
VALUES ('C0823G1'),('C0923G1');

SELECT 
    *
FROM
    teacher;
    
INSERT INTO teacher (`name`, age, country)
VALUES ('Giau', 21, 'Da Nang'),
		('Cuong', 21, 'Ha Noi');