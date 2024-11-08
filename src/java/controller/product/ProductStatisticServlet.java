package controller.product;

import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductStatisticServlet", urlPatterns = {"/ProductStatistic"})
public class ProductStatisticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy các tham số từ request
        String sortBy = request.getParameter("sortBy");
        String categoryIdStr = request.getParameter("categoryId");
        String priceStr = request.getParameter("price");
        String sortOrder = request.getParameter("sortOrder");

        // Xử lý tham số categoryId
        int categoryId = 0; // Giá trị mặc định nếu không có tham số hợp lệ
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid category ID");
                request.getRequestDispatcher("dashboard/productStatistic.jsp").forward(request, response);
                return;
            }
        }

        // Xử lý tham số price
        Double price = null;
        if (priceStr != null && !priceStr.isEmpty()) {
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid price format");
                request.getRequestDispatcher("dashboard/productStatistic.jsp").forward(request, response);
                return;
            }
        }

        // Khởi tạo ProductDAO và lấy danh sách sản phẩm
        ProductDAO productDAO = new ProductDAO();
        List<Product> products;

        // Lọc và sắp xếp sản phẩm theo các tiêu chí
        if ("price".equals(sortBy) && price != null) {
            products = productDAO.getProductsByPrice(categoryId, price, sortOrder);
        } else {
            products = productDAO.getTopProductsByCategory(categoryId, sortBy);
        }

        // Đưa danh sách sản phẩm vào request attribute
        request.setAttribute("product", products);
        
        // Chuyển tiếp đến JSP để hiển thị
        request.getRequestDispatcher("dashboard/productStatisic.jsp").forward(request, response);
    }
}
