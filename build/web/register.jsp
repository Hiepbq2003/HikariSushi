<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <script>
        // Hàm hiển thị thông báo alert
        function showAlert(message) {
            alert(message);
        }

        // Kiểm tra xem có thông báo thành công không
        <c:if test="${not empty successMessage}">
            showAlert("${successMessage}");
        </c:if>
    </script>
</head>
<body>
    <div class="container">
        <h1>Đăng Ký Tài Khoản</h1>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <%
            String errorMessage = (String) request.getAttribute("error");
            if (errorMessage != null) {
        %>
            <div class="error-message">
                <strong>Lỗi:</strong> <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form action="register" method="post">
            <label for="username">Họ và Tên:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Mật Khẩu:</label>
            <input type="password" id="password" name="password" required>

            <label for="address">Địa Chỉ:</label>
            <input type="text" id="address" name="address">

            <label for="gender">Giới Tính:</label>
            <select id="gender" name="gender">
                <option value="Nam">Nam</option>
                <option value="Nữ">Nữ</option>
                <option value="Khác">Khác</option>
            </select>

            <label for="phone">Số Điện Thoại:</label>
            <input type="text" id="phone" name="phone" required>

            <button type="submit">Đăng Ký</button>
        </form>
        <p>Đã có tài khoản? <a href="login.jsp">Đăng Nhập</a></p>
    </div>
</body>
</html>
