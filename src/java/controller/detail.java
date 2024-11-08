package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.ShoppingCart;

@WebServlet(name = "ct", urlPatterns = {"/detail"})
public class detail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                System.out.println("Sản phẩm tìm thấy: " + product.getProductName());
                int randomNumber = (int) (Math.random() * 6) + 1;
                List<Product> relatedProducts = productDAO.getProductsByCategoryId(randomNumber);
                System.out.println("Số lượng sản phẩm cùng loại tìm thấy: " + relatedProducts.size());
                request.setAttribute("relatedProducts", relatedProducts);
            } else {
                System.out.println("Không tìm thấy sản phẩm với ID: " + productId);
            }

            request.setAttribute("product", product);
            request.getRequestDispatcher("detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println("ID sản phẩm không hợp lệ.");
        }
    }
}
