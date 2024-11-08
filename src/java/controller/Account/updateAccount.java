
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet(name = "EditAccountServlet", urlPatterns = {"/editAccount"})
public class updateAccount extends HttpServlet {
    
        UserDAO userDAO = new UserDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String Name = request.getParameter("userName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender"); // Nam hoặc Nữ
        String phone = request.getParameter("phone");
        String roleIdParam = request.getParameter("roleId");
        String password = request.getParameter("password");//khi dung update phải thay doi update moi dung duoc dkm , vi du them dau cach

        int roleId = 1;
        if (roleIdParam != null && !roleIdParam.isEmpty()) {
            roleId = Integer.parseInt(roleIdParam);
        }
        User use = new User();
        use.setUsername(Name);
        use.setAddress(address);
        use.setGender(gender);
        use.setPassword(password);
        use.setPhone(phone);
        use.setRoleId(roleId);
        use.setEmail(email);
        // Cập nhật thông tin tài khoản qua DAO
        boolean success = userDAO.updateUsers(use);

        if (success) {
            request.setAttribute("mess", "Cập nhật tài khoản thành công.");
            
        } else {
            request.setAttribute("error", "Cập nhật tài khoản thất bại." + Name +" "+ email +" "+ password +" "+ address +" "+ gender +" "+ phone + roleId);
            
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        request.getRequestDispatcher("managerAccount").forward(request, response);
    }


}
