-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT 
    `order`.id, `order`.`date`, `order`.total_price
FROM
    `order`;
    
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT 
    customer.`name`, product.`name`
FROM
    customer
        JOIN
    `order` ON customer.id = `order`.c_id
        JOIN
    order_detail ON `order`.id = order_detail.o_id
        JOIN
    product ON product.id = order_detail.p_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT 
    customer.`name`
FROM
    customer
        LEFT JOIN
    `order` ON customer.id = `order`.c_id
WHERE
    `order`.id IS NULL;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT 
    `order`.id,
    `order`.`date`,
    SUM(order_detail.qty * product.price) AS total_price
FROM
    `order`
        JOIN
    order_detail ON `order`.id = order_detail.o_id
        JOIN
    product ON product.id = order_detail.p_id
GROUP BY `order`.id , `order`.`date`;