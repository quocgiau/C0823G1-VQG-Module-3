-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT 
    o.id, o.`date`, o.total_price
FROM
    `order` o;
    
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT 
    c.`name`,
    GROUP_CONCAT(p.`name`) AS 'product_name'
FROM
    customer c
        JOIN
    `order` o ON c.id = o.c_id
        JOIN
    order_detail od ON o.id = od.o_id
        JOIN
    product p ON p.id = od.p_id
GROUP BY c.`name`;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT 
    c.`name`
FROM
    customer c
        LEFT JOIN
    `order` o ON c.id = o.c_id
WHERE
    o.id IS NULL;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT 
    o.id,
    o.`date`,
    SUM(od.qty * p.price) AS total_price
FROM
    `order` o
        JOIN
    order_detail od ON o.id = od.o_id
        JOIN
    product p ON p.id = od.p_id
GROUP BY o.id;