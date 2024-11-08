package controller;

import dal.ProductDAO; // Nhập lớp ProductDAO để lấy dữ liệu sản phẩm
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product; // Nhập lớp Product để sử dụng danh sách sản phẩm
import java.io.IOException;
import java.util.List;

/**
 * Servlet để xử lý các yêu cầu liên quan đến sản phẩm nổi bật.
 */
@WebServlet("/home")
public class ProductHome extends HttpServlet {

    /**
     * Phương thức doGet để xử lý các yêu cầu GET.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Khởi tạo đối tượng ProductDAO để lấy danh sách sản phẩm
        ProductDAO productDAO = new ProductDAO();
        
        // Lấy danh sách sản phẩm theo 3 tiêu chí
        List<Product> featuredProductsRating = productDAO.getFeaturedProductsByRating(); // Sản phẩm nổi bật (Rating >= 4.6)
        List<Product> topPurchaseProducts = productDAO.getTopPurchasedProducts(); // Sản phẩm top 10 theo purchase_count
        List<Product> newestProducts = productDAO.getNewestProducts(); // Sản phẩm mới nhất

        // Đưa danh sách sản phẩm vào request
        request.setAttribute("featuredProductsRating", featuredProductsRating);
        request.setAttribute("topPurchaseProducts", topPurchaseProducts);
        request.setAttribute("newestProducts", newestProducts);

        // Chuyển đến trang JSP để hiển thị danh sách sản phẩm
        request.getRequestDispatcher("home.jsp").forward(request, response);
        
    }

    /**
     * Phương thức doPost để xử lý các yêu cầu POST (nếu cần thiết).
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Chuyển tiếp yêu cầu POST đến phương thức doGet
    }
}
