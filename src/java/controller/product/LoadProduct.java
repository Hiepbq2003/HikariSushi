package controller.product;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;

@WebServlet(name = "LoadProductServlet", urlPatterns = {"/updateproduct"})
public class LoadProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy `productId` từ request
            String productIdParam = request.getParameter("productID");
            if (productIdParam == null || productIdParam.isEmpty()) {
                response.sendRedirect("manageProduct");
                return;
            }
            
            int productId = Integer.parseInt(productIdParam);
            
            // Gọi `ProductDAO` để lấy thông tin sản phẩm
            ProductDAO productDAO = new ProductDAO();
            Product productDetail = productDAO.getProductById(productId);

            if (productDetail != null) {
                // Gửi thông tin sản phẩm đến trang `JSP`
                request.setAttribute("detail", productDetail);
                request.getRequestDispatcher("dashboard/updateProduct.jsp").forward(request, response);
            } else {
                response.sendRedirect("manageProduct"); // Nếu sản phẩm không tồn tại
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("manageProduct");
        }
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
