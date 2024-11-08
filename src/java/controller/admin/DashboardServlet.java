package controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.ProductDAO;
import dal.UserDAO;
import dal.OrderDAO;


@WebServlet("/dashBoard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sử dụng DAO
        ProductDAO productDAO = new ProductDAO();
        UserDAO userDAO = new UserDAO();
        OrderDAO orderDAO = new OrderDAO();

        // Lấy số liệu từ database
        int countProduct = productDAO.countAllProduct();
        int countProductType = productDAO.countAllTypeProduct();
        int countUser = userDAO.countAllUser();
        int totalSold = orderDAO.countTotalSold();
        double totalSales = orderDAO.calculateTotalSales();

        // Đặt attribute cho request để chuyển về JSP
        request.setAttribute("countProduct", countProduct);
        request.setAttribute("countProductType", countProductType);
        request.setAttribute("countUser", countUser);
        request.setAttribute("totalSold", totalSold);
        request.setAttribute("totalSales", totalSales);

        // Forward dữ liệu về trang JSP
        request.getRequestDispatcher("dashboard/dashboard.jsp").forward(request, response);
    }
}
