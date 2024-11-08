
package controller.Account;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author bachk
 */
@WebServlet(name="loadAccount", urlPatterns={"/updateaccount"})
public class loadAccount extends HttpServlet {
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         UserDAO userDAO = new UserDAO();
        String userName = request.getParameter("username");
        User existingUser = userDAO.getUserByName(userName); // Phương thức lấy người dùng theo userName
        request.setAttribute("user", existingUser);
        request.getRequestDispatcher("dashboard/updateAccount.jsp").forward(request, response);
    }
}
