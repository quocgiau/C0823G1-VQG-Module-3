<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<h1 class="text-center">Danh sách sản phẩm</h1>
<a href="/product-servlet" class="btn btn-primary">Hiển thị danh sách sản phẩm</a>
<a href="/product-servlet?action=show" class="btn btn-primary">Thêm mới sản phẩm</a>
<div class="form-group">
    <input type="text" class="form-control">
    <button class="btn btn-primary">Tìm kiếm</button>
</div>
<table class="table">
    <thead>
    <tr>
        <th>STT</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Mô tả</th>
        <th>Nhà sản xuất</th>
        <th></th>
        <th></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="product" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${product.name}</td>
            <td>${product.price}$</td>
            <td>${product.describe}</td>
            <td>${product.producer}</td>
            <td>
                <button type="button" class="btn btn-primary" onclick="" data-bs-toggle="modal"
                        data-bs-target="#exampleModal1">
                    Sửa
                </button>
            </td>
            <td>
                <button type="button" class="btn btn-primary" onclick="infoDelete('${product.id}','${product.name}')"
                        data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Xoá
                </button>
            </td>
            <td>
                <button class="btn btn-info">Xem</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/product-servlet?action=delete" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Xác nhận</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input hidden="hidden" id="id" name="id">
                    <span>Bạn có muốm xoá </span>
                    <span id="delName"></span>
                    <span> không?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                    <button type="submit" class="btn btn-primary">Đúng</button>
                </div>
            </div>
        </form>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="/product-servlet?action=update">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel1">Sửa đổi thông tin</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    function infoDelete(id, name) {
        document.getElementById("delName").innerText = name;
        document.getElementById("id").value = id;
    }

    function infoEdit(id, name) {

    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>

</html>