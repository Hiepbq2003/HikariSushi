<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cảm ơn</title>
        <link rel="stylesheet" type="text/css" href="css/process.css">
    </head>
    <body>

        <h1>Cảm ơn ${userName} đã đặt hàng!</h1>
        <p>Đơn hàng của bạn đang được xử lý. Bạn sẽ sớm nhận được thông báo về đơn hàng qua email.</p>

        <h2>Chọn phương thức thanh toán</h2>
        <form action="choosePayment" method="POST">
            <label>
                <input type="radio" name="paymentMethod" value="bankTransfer" required>
                Chuyển khoản ngân hàng
                <span>(Thực hiện thanh toán vào ngay tài khoản ngân hàng của chúng tôi. Vui lòng sử dụng Mã đơn hàng của bạn trong phần Nội dung thanh toán. Đơn hàng sẽ được giao sau khi tiền đã chuyển.)</span>
            </label><br>

            <label>
                <input type="radio" name="paymentMethod" value="cashOnDelivery" required>
                Trả tiền mặt khi nhận hàng
            </label><br>

            <input type="submit" value="Xác nhận thanh toán">
        </form>
        <p><a href="menu">Quay lại thực đơn</a></p>
    </body>
</html>
