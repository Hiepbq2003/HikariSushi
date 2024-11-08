package controller.Account;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "DeleteAccountControl", urlPatterns = {"/deleteaccount"})
public class DeleteAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tên người dùng từ tham số request
        String username = request.getParameter("username");
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();
        String message = "";

        if (username != null && !username.isEmpty()) {
            // Xóa người dùng theo username
            dao.deleteUser(username);
            message = "Đã xóa tài khoản " + username + " thành công!";
        } else {
            message = "Xóa thất bại!";
        }


        // Đặt thông báo và chuyển về trang quản lý tài khoản
        request.setAttribute("mess", message);
        request.getRequestDispatcher("managerAccount").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý bằng phương thức GET
    }

}
