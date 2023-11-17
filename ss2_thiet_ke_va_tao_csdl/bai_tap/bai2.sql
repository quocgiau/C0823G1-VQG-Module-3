CREATE DATABASE IF NOT EXISTS quan_ly_ban_hang;
USE quan_ly_ban_hang;

 CREATE TABLE customer (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    age int not null
);

 CREATE TABLE `order` (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `date` DATE,
    total_price VARCHAR(50),
    c_id INT NOT NULL,
    FOREIGN KEY (c_id)
        REFERENCES customer (id)
);

CREATE TABLE product (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    price VARCHAR(50)
);

CREATE TABLE order_detail (
    o_id INT NOT NULL,
    p_id INT NOT NULL,
    FOREIGN KEY (o_id)
        REFERENCES `order` (id),
    FOREIGN KEY (p_id)
        REFERENCES product (id),
    qty VARCHAR(50),
    PRIMARY KEY (o_id , p_id)
); 

