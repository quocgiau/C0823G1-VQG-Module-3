CREATE DATABASE IF NOT EXISTS quan_ly_don_hang;
USE quan_ly_don_hang;

CREATE TABLE bill (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `day` DATE
);

CREATE TABLE supplies (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE export_slip_details (
    price INT NOT NULL,
    quantity INT NOT NULL,
    bill_id INT,
    supplies_id INT,
    UNIQUE (bill_id , supplies_id),
    FOREIGN KEY (bill_id)
        REFERENCES bill (id),
    FOREIGN KEY (supplies_id)
        REFERENCES supplies (id)
);

CREATE TABLE import_coupon (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `day` DATE
);

CREATE TABLE entry_details (
    price INT NOT NULL,
    `number` INT NOT NULL,
    import_coupon_id INT,
    supplies_id INT,
    UNIQUE (import_coupon_id , supplies_id),
    FOREIGN KEY (import_coupon_id)
        REFERENCES import_coupon (id),
    FOREIGN KEY (supplies_id)
        REFERENCES supplies (id)
);

CREATE TABLE supplier (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    address VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE the_order (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `day` DATE,
    supplier_id INT NOT NULL,
    FOREIGN KEY (supplier_id)
        REFERENCES supplier (id)
);

CREATE TABLE order_details (
    the_order_id INT,
    supplies_id INT,
    UNIQUE (the_order_id , supplies_id),
    FOREIGN KEY (the_order_id)
        REFERENCES the_order (id),
    FOREIGN KEY (supplies_id)
        REFERENCES supplies (id)
);

CREATE TABLE phone (
    id INT KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    phone VARCHAR(20),
    FOREIGN KEY (supplier_id)
        REFERENCES supplier (id)
);