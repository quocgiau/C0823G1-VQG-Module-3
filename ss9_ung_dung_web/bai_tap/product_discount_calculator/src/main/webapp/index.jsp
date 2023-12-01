<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<form action="/display-discount" method="post">
    <p>Product Description:</p>
    <input type="text" name="describe">
    <p>List Price:</p>
    <input type="text" name="price">
    <p>Discount Percent:</p>
    <input type="text" name="percent">
    <br>
    <br>
    <input type="submit" value="Calculate Discount">
</form>
</body>
</html>