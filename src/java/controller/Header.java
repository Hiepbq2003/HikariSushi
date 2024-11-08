package controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors; // Thêm import này
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import dal.ProductDAO; // Thêm import này

@WebServlet(name="header", urlPatterns={"/header"})
public class Header extends HttpServlet {
    private ProductDAO productService = new ProductDAO(); // Khai báo ProductDAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Product> productList = productService.getAllProducts(); // Lấy tất cả sản phẩm từ DB

        if (query != null && !query.isEmpty()) {
            productList = productList.stream()
                .filter(product -> product.getProductName().toLowerCase().contains(query.toLowerCase())) // Lọc theo tên sản phẩm
                .collect(Collectors.toList());
        }

        // Thiết lập các thuộc tính cho request để gửi về view
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}
