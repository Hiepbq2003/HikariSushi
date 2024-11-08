package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/checkout")
public class checkOut extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String city = request.getParameter("city");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String orderNotes = request.getParameter("orderNotes");
        
        // Kiểm tra tham số totalPrice
        String totalPriceParam = request.getParameter("totalPrice");
        float totalPrice = 0;

        if (totalPriceParam != null && !totalPriceParam.trim().isEmpty()) {
            totalPrice = Float.parseFloat(totalPriceParam);
        } else {
            request.setAttribute("error", "0");

        }

        // Kiểm tra người dùng đã đăng nhập chưa
        int userId;
        String userIdParam = request.getParameter("userId");
        if (userIdParam != null && !userIdParam.trim().isEmpty()) {
            userId = Integer.parseInt(userIdParam); // Nếu đã đăng nhập, lấy userId từ request
        } else {
            userId = 1; // Nếu chưa đăng nhập, mặc định là 1
        }

        // Tạo tên khách hàng từ họ và tên
        String userName = firstName + " " + lastName;

        // Tạo đối tượng OrderDAO để lưu đơn hàng
        OrderDAO orderDAO = new OrderDAO();

        // Thêm đơn hàng vào cơ sở dữ liệu
        boolean isSuccess = orderDAO.saveOrder(userId, userName, phone, email, address + ", " + city, totalPrice, orderNotes);

        if (!isSuccess) {
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình xử lý thanh toán.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Chuyển hướng tới trang cảm ơn sau khi đơn hàng thành công
        request.setAttribute("userName", userName);
        request.getRequestDispatcher("processPayment.jsp").forward(request, response);
    }
}

