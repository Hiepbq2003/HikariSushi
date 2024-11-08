<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/header.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="top">
            <a class="delivery-info">Giao hàng tận nơi: <span class="phone-number">0904034322</span></a>

            <div class="search-container">
                <form action="header" method="GET">
                    <input type="text" name="query" placeholder="Tìm kiếm sản phẩm..." />
                    <button type="submit">Tìm kiếm</button>
                </form>
            </div>
            
            <div >
            <c:if test="${loggedInUser.roleId == 3}">
                <a href="dashBoard" class="ad" style="font-size: 1.4em;margin-right: 20px;position: relative">
                                <i class="fa-solid fa-screwdriver-wrench"></i> Điều Khiển   
                            </a>
                        </c:if>
            </div>
            <div class="user-container">
                
                <c:choose>
                    
                    <c:when test="${not empty loggedInUser}"> <!-- Kiểm tra nếu người dùng đã đăng nhập -->
                        
                        <a href="#" class="user" onmouseover="showProfileMessage()" onmouseout="hideProfileMessage()">
                            <i class="fa-regular fa-circle-user"></i>
                        </a>                   
                        <span id="username" class="username">${loggedInUser.username}</span> <!-- Hiển thị tên người dùng -->
                        <div class="profile-menu"> <!-- Menu hiển thị khi hover -->
                            <a href="profile.jsp">Thông Tin</a>
                            <a href="logout">Đăng Xuất</a>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="user" onmouseover="showLoginMessage()" onmouseout="hideLoginMessage()">
                            <i class="fa-regular fa-circle-user"></i>
                        </a>
                        <div id="loginMessage" class="login-message hidden">Login</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <a href="cart.jsp" class="cart" onmouseover="showCartMessage()" onmouseout="hideCartMessage()">
                <i class="fa-solid fa-cart-shopping"></i>
                <span class="cart-count">0</span> <!-- Hiển thị số lượng sản phẩm -->
            </a>
            <div id="cartMessage" class="cart-message hidden">Giỏ hàng của bạn</div>
        </div>

        <div class="logo">
            <a>
                <img src="images/logomain.jpg" alt="hikari"/>
            </a>
        </div>

        <div class="null"></div>

        <div class="topnav" id="header">
            <a href="home">Trang Chủ</a>
            <a href="about.jsp">Giới Thiệu</a>
            <a href="menu">Thực Đơn</a>
            <a href="cart.jsp">Giỏ Hàng</a>
            <a href="contact.jsp">Liên Lạc</a>           
        </div>

        <script src="js/header.js"></script>
        <script src="js/cart.js"></script>

    </body>
</html>
