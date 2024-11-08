<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- Nếu bạn cần định dạng số hoặc ngày -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/menu.css"/>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Amatic+SC:wght@400;700&display=swap" rel="stylesheet">

    </head>

    <body>

        <jsp:include page="headerNoLogin.jsp"/>

        <!--        hiển thị product-->
        <div class="container-fluid">
            <div class="row">
                <!-- Cột bên trái cho danh mục -->

                <div class="col-md-2">
                    <h4>Lọc theo giá</h4>
                    <form action="menu" method="GET">
                        <input type="number" name="minPrice" placeholder="Giá tối thiểu" step="1000">
                        <input type="number" name="maxPrice" placeholder="Giá tối đa" step="1000">
                        <button type="submit">Lọc</button>
                    </form>

                    <h4>Lọc theo danh mục</h4>
                    <form id="categoryForm" action="menu" method="GET">
                        <label for="category">Chọn danh mục:</label>
                        <select name="categoryId" id="category" onchange="document.getElementById('categoryForm').submit();">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}">
                                    ${category.categoryName} (${category.productCount})
                                </option>
                            </c:forEach>
                        </select>
                    </form>

                    <h4>Sắp xếp theo giá</h4>
                    <form id="sortForm" action="menu" method="GET">
                        <select name="sortOrder" id="sortOrder" onchange="document.getElementById('sortForm').submit();">
                            <option value="">Mặc định</option>
                            <option value="asc">Giá từ thấp đến cao</option>
                            <option value="desc">Giá từ cao đến thấp</option>
                        </select>
                    </form>

                    <div class="stats">
                        <h4>Thống Kê Sản Phẩm</h4>
                        <p>Giá cao nhất: <fmt:formatNumber value="${maxPrice}" type="currency" currencySymbol="VNĐ" /></p>
                        <p>Giá thấp nhất: <fmt:formatNumber value="${minPrice}" type="currency" currencySymbol="VNĐ" /></p>
                        <p>Giá trung bình: <fmt:formatNumber value="${avgPrice}" type="currency" currencySymbol="VNĐ" /></p>
                        <p>Tổng giá: <fmt:formatNumber value="${sumPrice}" type="currency" currencySymbol="VNĐ" /></p>
                        <p>Số lượng sản phẩm: ${count}</p>
                    </div>
                </div>


                <!-- Cột bên phải cho sản phẩm -->
                <div class="col-md-10">
                    <h1>TRADITIONAL MENU</h1>

                    <!-- Hiển thị sản phẩm -->
                    <div class="product-container">
                        <c:if test="${not empty productList}">
                            <c:forEach var="product" items="${productList}">
                                <div class="product-item">
                                    <a href="./detail?productId=${product.productId}"> <!-- Thêm liên kết đến detail.jsp -->
                                        <img src="${product.img}" alt="${product.productName}">
                                        <h2>${product.productName}</h2>
                                        <p>Giá: <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" /></p>
                                    </a>
                                    <p class="add-to-cart" onclick="addToCart('${product.productId}')">Thêm vào giỏ hàng</p>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty productList}">
                            <p>No products available.</p>
                        </c:if>
                    </div>

                    <!-- Hiển thị nút phân trang -->
                    <div class="page-btn">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <span>
                                <a href="menu?categoryId=${selectedCategoryId}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&page=${i}">
                                    ${i}</a>
                            </span>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="footer-col-1">
                        <h3>Giờ Hoạt Động</h3>
                        <p>THỨ 2 - THỨ 7 : 11:00 AM - 10:00 PM</p>
                        <p>CHỦ NHẬT : 11:00 AM - 9:30 PM</p>
                        <img src="images/Hikari sushi logo white.png" width="300px" height="150px" alt="alt"/>
                    </div>
                    <div class="footer-col-2">
                        <h3>Địa Chỉ</h3>
                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d878.9154256880357!2d105.5199199341659!3d21.004144548371816!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b975c8eb30d%3A0x970dd8ffd8f1de29!2zTmjDoCBIw6BuZyBHw6AgUmkgUGjDuiBCw6xuaCAy!5e0!3m2!1svi!2s!4v1728432167384!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                    <div class="footer-col-4">
                        <h3>Liên Hệ</h3>
                        <ul>
                            <li><a href="https://www.facebook.com/profile.php?id=61551550319360" target="_blank"><i class="fa-brands fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/neil_kiwi_/" target="_blank"><i class="fa-brands fa-instagram"></i></a></li></br>
                            <li>Gmail : hanh.hiep.777@gmail.com</a></li></br>
                            <li>Số Điện Thoại : 0904034322</li>
                        </ul>
                    </div>
                </div>
                <hr/>
            </div>
        </div>

        <script src="js/cart.js"></script> 
    </body>
</html>
