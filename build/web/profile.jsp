<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thông Tin Người Dùng</title>
        <link rel="stylesheet" href="css/profile.css"> <!-- Đường dẫn tới tệp CSS -->
        <script>
            function togglePasswordForm() {
                var form = document.getElementById("passwordForm");
                form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
            }
        </script>
    </head>
    <body>
        <jsp:include page="headerNoLogin.jsp"/>
        <h1 class="profile-title">Thông tin người dùng</h1>

        <c:if test="${not empty updateMessage}">
            <p class="profile-message">${updateMessage}</p>
        </c:if>
        <div class="all">
            <!-- Form cập nhật thông tin người dùng -->
            <form action="profile" method="post" class="profile-form">
                <input type="hidden" name="action" value="updateInfo">

                <label for="username">Tên đăng nhập:</label>
                <input type="text" name="username" value="${loggedInUser.username}" required>

                <label for="email">Email:</label>
                <input type="email" name="email" value="${loggedInUser.email}" required>

                <label for="phone">Số điện thoại:</label>
                <input type="text" name="phone" value="${loggedInUser.phone}" required>

                <label for="address">Địa chỉ</label>
                <input type="text" name="address" value="${loggedInUser.address}" required>

                <label for="gender">Giới tính:</label>
                <label for="gender">Giới tính:</label>
                <select name="gender" required>
                    <option value="1" ${loggedInUser.gender == '1' ? 'selected' : ''}>Nam</option>
                    <option value="0" ${loggedInUser.gender == '0' ? 'selected' : ''}>Nữ</option>
                </select>


                <input type="submit" value="Cập nhật thông tin">
            </form>

            <!-- Nút để hiển thị form đổi mật khẩu -->
            <button onclick="togglePasswordForm()">Đổi mật khẩu</button>

            <!-- Form đổi mật khẩu, ẩn theo mặc định -->
            <form action="profile" method="post" class="profile-form" id="passwordForm" style="display:none;">
                <input type="hidden" name="action" value="updatePassword">

                <label for="oldPassword">Mật khẩu cũ:</label>
                <input type="password" name="oldPassword" required>

                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" name="newPassword" required>

                <label for="confirmPassword">Xác nhận mật khẩu:</label>
                <input type="password" name="confirmPassword" required>

                <input type="submit" value="Cập nhật mật khẩu">
            </form>

            <!-- Cảnh báo khi xóa tài khoản -->
            <div class="delete-warning">
                <p><strong>Cảnh báo:</strong> Việc xóa tài khoản sẽ xóa toàn bộ dữ liệu của bạn vĩnh viễn và không thể khôi phục. Vui lòng cân nhắc kỹ trước khi thực hiện.</p>
            </div>

            <!-- Nút xóa tài khoản -->
            <form action="profile" method="post" class="profile-form">
                <input type="hidden" name="action" value="deleteAccount">
                <input type="submit" value="Xóa tài khoản" onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản?');">
            </form>

            <a href="logout" class="logout-link">Đăng xuất</a>
        </div>
    </body>
</html>
