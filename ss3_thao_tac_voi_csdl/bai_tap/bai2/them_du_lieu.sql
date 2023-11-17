INSERT INTO customer (`name`,age)
VALUES ('Minh Quan', 10),
('Ngoc Oanh', 20),
('Hong Ha', 50);

INSERT INTO `order` (`date`, c_id)
VALUES ('2006-03-21', 1),
('2006-03-23', 2),
('2006-03-16', 1);

INSERT INTO product (`name`, price)
VALUES ('May Giat', 3),
('Tu Lanh', 5),
('Dieu Hoa', 7),
('Quat', 1),
('Bep Dien', 2);

INSERT INTO order_detail (o_id, p_id, qty)
VALUES (1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);