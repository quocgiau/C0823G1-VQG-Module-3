<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Customer</title>
    <style>
        table {
            color: #333;
            background-color: #f7f7f7;
            font-family: Arial, sans-serif;
            border-collapse: collapse;
        }

        td, th {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
            width: 400px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        img {
            height: 200px;
        }
    </style>
</head>
<body>
<a href="/customer-servlet">Hiển thị</a>
<h1>Danh sách khách hàng</h1>
<table border="1px">
    <tr>
        <th>Tên</th>
        <th>Ngày sinh</th>
        <th>Địa chỉ</th>
        <th>Ảnh</th>
    </tr>
    <c:forEach items="${list}" var="customer" varStatus="cus">
        <tr>
            <td>${customer.name}</td>
            <td>${customer.birthday}</td>
            <td>${customer.address}</td>
            <td><img src="${customer.img}"></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>