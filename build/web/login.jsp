<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/login.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Amatic+SC:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="glass-container">
            <div class="login-box">
                <h2>Đăng Nhập</h2>

                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>

                <form action="login" method="POST">
                    <input type="text" id="username" name="username" required placeholder="Tên đăng nhập" 
                           value="${param.username != null ? param.username : ''}">

                    <input type="password" id="password" name="password" required placeholder="Mật khẩu">

                    <div class="options">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Ghi nhớ đăng nhập</label>
                        <a href="#">Quên mật khẩu ?</a>
                    </div>
                    <div class="g-recaptcha" data-sitekey="6LcXOm8qAAAAAJRqDr6UNd9VWGCrlA59T6J1b6l9"></div>
                    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                    <button type="submit" onclick="checkcapcha(event)">Đăng Nhập</button>

                    <p>Tạo tài khoản mới <a href="register.jsp" id="register">Đăng Ký</a></p>
                </form>
            </div>
        </div>
        <script>
            function checkcapcha(event) {
                var response = grecaptcha.getResponse();
                if (response.length === 0) { // Kiểm tra nếu CAPTCHA chưa được hoàn thành
                    alert("Vui lòng xác nhận CAPTCHA.");
                    event.preventDefault(); // Ngăn form gửi đi nếu CAPTCHA chưa được xác thực
                }
            }
        </script>
    </body>
</html>
