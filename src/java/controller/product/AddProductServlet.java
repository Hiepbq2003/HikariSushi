package controller.product;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Product;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Category;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/addproductmn"})
public class AddProductServlet extends HttpServlet {

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
       String msg = "";
       String er = "";
    // Lấy các tham số từ form
    String productName = request.getParameter("productName");
    String price = request.getParameter("price");
    String description = request.getParameter("describe");
    String dateString = request.getParameter("date");
    String categoryId = request.getParameter("category");
    String imgPath = request.getParameter("image");

    

    // Khởi tạo biến cho ngày
    java.sql.Date releaseDate = null;

    // Kiểm tra và chuyển đổi ngày
    if (dateString != null && !dateString.isEmpty()) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-dd-MM"); // Định dạng ngày
            Date parsedDate = sdf.parse(dateString); // Chuyển đổi thành Date
            releaseDate = new java.sql.Date(parsedDate.getTime()); // Chuyển đổi thành java.sql.Date
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Định dạng ngày không hợp lệ. Vui lòng sử dụng yyyy-MM-dd.");
            request.getRequestDispatcher("addProductPage").forward(request, response);
            return; // Dừng thực hiện tiếp nếu có lỗi
        }
    }

    double doubleValue = 0.0;
    int ngu = 0;
    ngu = Integer.parseInt(categoryId);
    

    if (price != null && !price.isEmpty()) {
        try {
            doubleValue = Double.parseDouble(price);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    Product product = new Product();
    product.setProductName(productName);
    product.setPrice(doubleValue);
    product.setDescription(description);
//    product.setReleaseDate(new java.util.Date()); 
    product.setReleaseDate(releaseDate);
    product.setImg("images/ManageProduct/" + imgPath);
    product.setCategoryId(ngu);
    product.setReleaseDate(new java.util.Date()); 
    ProductDAO productDAO = new ProductDAO();

    boolean success = productDAO.addProduct(product);
        if (!success) {
            msg = "thành công!";
            request.setAttribute("mess", msg);
        } else {
            er = "Thêm món thất bại!" + productName + " "+ doubleValue + " "+ description +" "+ ngu  + " " + imgPath + releaseDate;
            request.setAttribute("error", er);
        }
        
        request.getRequestDispatcher("manageProduct").forward(request, response);
    
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
