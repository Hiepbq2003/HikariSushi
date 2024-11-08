package controller.Account;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.util.List;
import model.Order;

@WebServlet(name = "ManagerAccountControl", urlPatterns = {"/managerAccount"})
public class ManagerAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String searchValue = request.getParameter("Search");
        UserDAO dao = new UserDAO();
        List<User> list;

        if (searchValue != null && !searchValue.isEmpty()) {
            // Tìm kiếm người dùng theo tên
            list = dao.searchUserByName(searchValue);
            request.setAttribute("searchValue", searchValue);
        } else {
            // Lấy tất cả người dùng nếu không có từ khóa tìm kiếm
            list = dao.getAllUsers();
        }

        request.setAttribute("listUser", list);
        request.getRequestDispatcher("dashboard/mngaccount.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
