CREATE DATABASE quan_ly_sinh_vien;
USE quan_ly_sinh_vien;

CREATE TABLE class (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(60) NOT NULL,
    `date` DATETIME NOT NULL,
    `status` BIT
);

CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL,
    address VARCHAR(50),
    phone VARCHAR(20),
    `status` BIT,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id)
        REFERENCES class (id)
);

CREATE TABLE `subject` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL,
    credit TINYINT NOT NULL DEFAULT 1 CHECK (credit >= 1),
    `status` BIT DEFAULT 1
);

CREATE TABLE mark (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sub_id INT NOT NULL,
    student_id INT NOT NULL,
    mark FLOAT DEFAULT 0 CHECK (mark BETWEEN 0 AND 100),
    exam_times TINYINT DEFAULT 1,
    UNIQUE (sub_id , student_id),
    FOREIGN KEY (sub_id)
        REFERENCES `subject` (id),
    FOREIGN KEY (student_id)
        REFERENCES student (id)
);