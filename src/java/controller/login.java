package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.UserDAO; 
import jakarta.servlet.http.Cookie;
import model.User;

@WebServlet(name = "Login", urlPatterns = {"/login"})
public class login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(username, password);

        if (user != null) {
            // Tạo session cho người dùng
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Gọi getUserId để lấy userId từ username
            Integer userId = userDAO.getUserId(username);
            session.setAttribute("userId", userId); // Lưu userId vào session

            // Tạo cookie lưu thông tin đăng nhập
            Cookie cookieUsername = new Cookie("cUName", username);
            Cookie cookiePassword = new Cookie("pUName", password);
            Cookie cookieRemember = new Cookie("reMem", remember);

            int maxAge = 60 * 60 * 24 * 30 * 3; // 3 tháng
            cookieUsername.setMaxAge(maxAge);
            
            if (remember != null) {
                cookiePassword.setMaxAge(maxAge);
                cookieRemember.setMaxAge(maxAge);
            } else {
                cookiePassword.setMaxAge(0); // Xóa cookie nếu không nhớ
                cookieRemember.setMaxAge(0);
            }
            
            // Thêm cookie vào response
            response.addCookie(cookieUsername);
            response.addCookie(cookiePassword);
            response.addCookie(cookieRemember);
            
            switch (user.getRoleId()) {
                case 3:
                    response.sendRedirect("dashBoard");
                    break;
                default:
                    response.sendRedirect("home.jsp"); // Trang chủ cho các vai trò khác
                    break;
            }
        } else {
            // Nếu thông tin đăng nhập không chính xác
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
