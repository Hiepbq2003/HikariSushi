package controller;

import dal.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Hiển thị thông tin người dùng
            request.setAttribute("loggedInUser", loggedInUser);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            // Nếu không có người dùng, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            String action = request.getParameter("action");

            if ("updateInfo".equals(action)) {
                // Cập nhật thông tin cá nhân
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String add = request.getParameter("address");
                String genderValue = request.getParameter("gender");

             

                loggedInUser.setUsername(username);
                loggedInUser.setEmail(email);
                loggedInUser.setPhone(phone);
                loggedInUser.setAddress(add);
                loggedInUser.setGender(genderValue);
                // Cập nhật thông tin vào cơ sở dữ liệu
                UserDAO userDAO = new UserDAO();
                userDAO.updateUser(loggedInUser);

                session.setAttribute("loggedInUser", loggedInUser);
                request.setAttribute("updateMessage", "Cập nhật thông tin thành công!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else if ("updatePassword".equals(action)) {
                // Cập nhật mật khẩu
                String newPassword = request.getParameter("newPassword");
                loggedInUser.setPassword(newPassword);

                UserDAO userDAO = new UserDAO();
                userDAO.updatePassword(loggedInUser);

                request.setAttribute("updateMessage", "Cập nhật mật khẩu thành công!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else if ("deleteAccount".equals(action)) {
                // Xóa tài khoản
                UserDAO userDAO = new UserDAO();
                userDAO.deleteUser(loggedInUser); // Gọi phương thức xóa

                // Xóa thông tin người dùng khỏi session
                session.invalidate(); // Đăng xuất người dùng
                response.sendRedirect("login.jsp"); // Chuyển hướng đến trang đăng nhập
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

}
