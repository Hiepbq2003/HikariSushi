<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" type="text/css" href="css/cart.css">

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

        <h1>Giỏ hàng của bạn</h1>

        <form id="updateCartForm" action="cart" method="post">
            <input type="hidden" name="action" value="update">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>
                    <th>Hành động</th>
                </tr>
                
                <c:choose>
                    <c:when test="${not empty cart}">
                        <c:forEach var="product" items="${cart}">
                            <tr>
                                <td>${product.productId}</td>
                                <td>${product.productName}</td>
                                <td>${product.price} VNĐ</td>
                                <td>
                                    <input type="number" name="quantity_${product.productId}" value="${product.quantity}" min="0">
                                </td>
                                <td><img src="${product.img}" alt="${product.productName}" width="100"></td>
                                <td>
                                    <button type="button" onclick="removeFromCart(${product.productId})">Xóa</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">Giỏ hàng trống!</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </table>

            <p>Tổng giá: 
                <c:set var="totalPrice" value="0" />
                <c:forEach var="product" items="${cart}">
                    <c:set var="totalPrice" value="${totalPrice + (product.price * product.quantity )}" />
                </c:forEach>
                ${totalPrice} VNĐ
            </p>

            <p>
                <input type="submit" value="Cập nhật giỏ hàng">
                <input type="button" value="Thanh toán" onclick="doPayment()">
            </p>
        </form>

        <div class="menu">
            <a href="menu">Quay lại thực đơn</a>
        </div>

        <!-- Footer -->
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
                <hr />
            </div>
        </div>

        <script src="js/cart.js"></script>
       
    </body>
</html>
