package controller.product;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/editproduct"})
public class editProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy các tham số từ form
            String idStr = request.getParameter("id");
            String productName = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("describe");
            String categoryIdStr = request.getParameter("category");
            String imgPath = request.getParameter("image");
            String dateString = request.getParameter("date");
String errorMessage = String.format("Thông tin nhận được từ form:\nID món: %s\nTên món: %s\nGiá: %s\nMô tả: %s\nDanh mục: %s\nHình ảnh: %s\nNgày tạo: %s",
                    idStr, productName, priceStr, description, categoryIdStr, imgPath, dateString);
            
            // Lưu thông tin vào request để hiển thị trong JSP
            request.setAttribute("inputInfo", errorMessage);

            // Chuyển đổi các giá trị từ String sang kiểu dữ liệu tương ứng
            int productId = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            // Chuyển đổi releaseDate từ String sang java.sql.Date
            Date releaseDate = Date.valueOf(dateString); // Chỉ cần sử dụng valueOf

            // Tạo đối tượng Product từ các thông tin đã lấy
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setReleaseDate(releaseDate);
            product.setCategoryId(categoryId);
            product.setImg("images/ManageProduct/"+imgPath);

            // Cập nhật sản phẩm trong cơ sở dữ liệu
            ProductDAO productDAO = new ProductDAO();
            productDAO.updateProduct(product);
             

            // Chuyển hướng lại trang quản lý sản phẩm sau khi cập nhật thành công
            request.setAttribute("mess", "Cập nhật sản phẩm thành công!");
            request.getRequestDispatcher("manageProduct").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm. Vui lòng thử lại!");
            request.getRequestDispatcher("manageProduct").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
