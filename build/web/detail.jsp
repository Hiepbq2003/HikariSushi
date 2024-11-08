<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/Detail.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <title>Chi Tiết Sản Phẩm</title>
</head>
<body>
    <jsp:include page="headerNoLogin.jsp"/>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Chi tiết sản phẩm</h1>

        <div class="product-detail text-center">
            <c:if test="${not empty product}">
                <img src="${product.img}" alt="${product.productName}" class="img-fluid mb-3" style="max-width: 300px;">
                <h2 class="product-name">${product.productName}</h2>
                <p class="product-price">Giá: <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" /></p>
                <p class="product-description">Mô tả: ${product.description}</p>

                <c:if test="${not empty product.category}">
                    <p class="product-category">Danh mục: ${product.category.categoryName}</p>
                </c:if>

                <button class="btn btn-primary mt-2" onclick="addToCart(${product.productId})">Thêm vào giỏ hàng</button>
            </c:if>
            <c:if test="${empty product}">
                <p>Không tìm thấy sản phẩm.</p>
            </c:if>
        </div>

        <h3 class="mt-8">Sản phẩm cùng loại</h3>
<div id="relatedProductsCarousel" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
        <c:if test="${not empty relatedProducts}">
            <c:set var="count" value="0"/> <!-- Biến đếm -->
            <c:forEach var="relatedProduct" items="${relatedProducts}">
                <c:if test="${count % 4 == 0}"> <!-- Mỗi nhóm 4 sản phẩm -->
                    <div class="carousel-item <c:if test="${count == 0}">active</c:if>">
                        <div class="row">
                </c:if>
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="related-item">
                        <img src="${relatedProduct.img}" alt="${relatedProduct.productName}" class="img-fluid">
                        <h4>${relatedProduct.productName}</h4>
                        <p>Giá: <fmt:formatNumber value="${relatedProduct.price}" type="currency" currencySymbol="VNĐ" /></p>
                        <a href="detail?productId=${relatedProduct.productId}" class="btn btn-secondary">Xem chi tiết</a>
                    </div>
                </div>
                <c:if test="${count % 4 == 3 || count == relatedProducts.size() - 1}"> <!-- Kiểm tra nhóm 4 hoặc sản phẩm cuối -->
                        </div> <!-- row -->
                    </div> <!-- carousel-item -->
                </c:if>
                <c:set var="count" value="${count + 1}"/> <!-- Tăng biến đếm -->
            </c:forEach>
        </c:if>
        <c:if test="${empty relatedProducts}">
            <p>Không có sản phẩm cùng loại.</p>
        </c:if>
    </div>
    <a class="carousel-control-prev" href="#relatedProductsCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#relatedProductsCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

    </div>

    <div class="footer">
        <jsp:include page="footer.jsp"/>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="js/cart.js"></script>
</body>
</html>
