package controller;

import dal.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class register extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");

        User newUser = new User(username, email, password, address, gender, phone, 1);

        UserDAO userDAO = new UserDAO();
        boolean check = userDAO.isEmailExists(email);
        // Kiểm tra email đã tồn tại
//        if (check) {
//        request.setAttribute("error", "Email đã tồn tại!"); // Thông báo lỗi
//        request.getRequestDispatcher("register.jsp").forward(request, response); // Quay lại trang đăng ký
//        return;
//    }
        boolean isRegistered = userDAO.registerUser(newUser); // Đăng ký người dùng
        if (isRegistered) {
            request.setAttribute("successMessage", "Đăng ký thành công!"); // Thông báo thành công
            request.getRequestDispatcher("login.jsp").forward(request, response); // Chuyển hướng đến trang đăng nhập
            return; // Ngăn chặn việc xử lý tiếp tục
        } else {
            request.setAttribute("error", "Đăng ký không thành công!"); // Thông báo lỗi
            request.getRequestDispatcher("register.jsp").forward(request, response); // Quay lại trang đăng ký
            return; // Ngăn chặn việc xử lý tiếp tục
        }

    }
}
