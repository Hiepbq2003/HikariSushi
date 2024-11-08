package perfumeshop.controller.admin.revenue;

import dal.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "MonthlyRevenueServlet", urlPatterns = {"/monthlyrevenue"}) // Sửa lỗi chính tả đường dẫn
public class MonthlyRevenueServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String year_raw = request.getParameter("year");
        int year = (year_raw == null ? 2024 : Integer.parseInt(year_raw));

        OrderDAO dao = new OrderDAO();
        double[] totalMoneyMonths = new double[12];

        // Lấy doanh thu cho từng tháng
        for (int month = 1; month <= 12; month++) {
            totalMoneyMonths[month - 1] = dao.totalMoneyMonth(month, year);
        }

        // Lưu trữ doanh thu vào request
        for (int month = 0; month < 12; month++) {
            request.setAttribute("totalMoneyMonth" + (month +1 ), totalMoneyMonths[month] );
        }
        
        request.setAttribute("year", year);
        request.getRequestDispatcher("dashboard/monthlyrevenue.jsp").forward(request, response);
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
        return "Monthly Revenue Servlet";
    }
}
