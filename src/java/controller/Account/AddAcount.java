package controller.Account;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;

@WebServlet(name = "AddAcount", urlPatterns = {"/addAcount"})
public class AddAcount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String userName = request.getParameter("name");
        String password = request.getParameter("pass");
        String roleIdRaw = request.getParameter("role");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");

        int roleId = (roleIdRaw != null) ? Integer.parseInt(roleIdRaw) : 3;
        String msg;

        UserDAO dao = new UserDAO();
        
        // Kiểm tra xem tên người dùng có tồn tại không
//        boolean userExists = dao.checkUsernameExists(userName);
//        if (userExists) {
//            msg = "Tên người dùng đã tồn tại!";
//            request.setAttribute("error", msg);
//            request.getRequestDispatcher("managerAccount").forward(request, response);
//            return; // Kết thúc xử lý
//        }
        
        // Kiểm tra xem email có tồn tại không
//        boolean emailExists = dao.isEmailExists(email);
//        if (emailExists) {
//            msg = "Email đã tồn tại!";
//            request.setAttribute("error", msg);
//            request.getRequestDispatcher("managerAccount").forward(request, response);
//            return; // Kết thúc xử lý
//        }

        // Tạo đối tượng User
        User newUser = new User(userName, email, password, address, gender, phone, roleId);
        
        // Thêm người dùng mới vào cơ sở dữ liệu
        boolean success = dao.addUser(newUser);
        if (success) {
            msg = "Thêm tài khoản " + userName + " thành công!";
            request.setAttribute("mess", msg);
        } else {
            msg = "Thêm tài khoản thất bại!";
            request.setAttribute("error", msg);
        }

        
        request.getRequestDispatcher("managerAccount").forward(request, response);
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
    
    @Override
    public String getServletInfo() {
        return "Servlet quản lý tài khoản";
    }
}
 