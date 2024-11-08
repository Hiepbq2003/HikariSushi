package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/choosePayment")
public class choosePayment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy phương thức thanh toán từ form
        String paymentMethod = request.getParameter("paymentMethod");

        // Kiểm tra phương thức thanh toán và chuyển hướng đến trang tương ứng
        if ("bankTransfer".equals(paymentMethod)) {
            // Nếu chọn chuyển khoản ngân hàng, chuyển hướng đến trang QR Code
            request.getRequestDispatcher("qrCode.jsp").forward(request, response);
        } else if ("cashOnDelivery".equals(paymentMethod)) {
            // Nếu chọn trả tiền mặt khi nhận hàng, có thể xử lý logic khác (ví dụ: chuyển hướng đến trang xác nhận)
            request.getRequestDispatcher("orderTracking.jsp").forward(request, response);
        } else {
            // Nếu không chọn phương thức thanh toán nào hoặc có lỗi, quay lại trang trước và báo lỗi
            request.setAttribute("error", "Vui lòng chọn phương thức thanh toán.");
            request.getRequestDispatcher("thankyou.jsp").forward(request, response);
        }
    }
}
