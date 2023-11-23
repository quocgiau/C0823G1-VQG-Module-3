CREATE DATABASE IF NOT EXISTS quan_ly_san_pham;
USE quan_ly_san_pham;

CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(10),
    `name` VARCHAR(50),
    price DOUBLE,
    amount INT,
    `description` TEXT,
    `status` VARCHAR(20)
);

INSERT INTO products
VALUES (1, 'SP-12', 'socola', 12, 2, 'rat ngot', 'có'),
(2, 'SP-34', 'kẹo', 10, 5, 'hình tròn', 'có'),
(3, 'SP-56', 'bánh', 20, 0, 'hộp lớn', 'không'),
(4, 'SP-78', 'nước ngọt', 13, 3, '200ml', 'có'),
(5, 'SP-91', 'trái cây', 18, 7, 'thập cẩm', 'có'),
(6, 'SP-23', 'chè', 15, 0, 'thập cẩm', 'có');

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
CREATE UNIQUE INDEX index_code 
ON products(`code`);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
CREATE INDEX index_name_price
ON products(`name`, price);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN SELECT *
FROM products
WHERE `code` = 'SP-12';

EXPLAIN SELECT *
FROM products
WHERE `name` = 'socola' AND price > 10;

-- So sánh câu truy vấn trước và sau khi tạo index

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
CREATE VIEW view_products AS
SELECT `code`, `name`, price, `status`
FROM products;

SELECT *
FROM view_products;

-- Tiến hành sửa đổi view
ALTER VIEW view_products AS
SELECT  `code`, `name`, price, `status`
FROM products
WHERE `code` = 'SP-23';

-- Tiến hành xoá view
DROP VIEW view_products;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE get_all()
BEGIN
	SELECT *
	FROM products;
END //
DELIMITER ;
CALL get_all();

-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE add_product(
    IN new_code VARCHAR(10),
    IN new_name VARCHAR(50),
	IN new_price DOUBLE,
    IN new_amount INT,
    IN new_description TEXT,
    IN new_status VARCHAR(20)
)
BEGIN
    INSERT INTO products (`code`, `name`, price, amount, `description`, `status`)
    VALUES (new_code, new_name, new_price, new_amount, new_description, new_status);
END //
DELIMITER ;
CALL add_product('SP-45', 'muối', 9.99, 2, 'hello', 'có');

-- Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE edit_product(
    IN new_id INT,
    IN new_code VARCHAR(10),
    IN new_name VARCHAR(50),
    IN new_price DOUBLE,
    IN new_amount INT,
    IN new_description TEXT,
    IN new_status VARCHAR(20)
)
BEGIN
    UPDATE products
    SET `code` = new_code,
        `name` = new_name,
        price = new_price,
        amount = new_amount,
        `description` = new_description,
        `status` = new_status
    WHERE id = new_id;
END //
DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE delete_product(
    IN delete_id INT
)
BEGIN
    DELETE FROM products
    WHERE id = delete_id;
END //
DELIMITER ;
CALL delete_product(7);