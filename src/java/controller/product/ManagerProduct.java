package controller.product;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;

@WebServlet(name = "ManagerProductServlet", urlPatterns = {"/manageProduct"})
public class ManagerProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        CategoryDAO categoryDAO = new CategoryDAO();    
            List<Category> listCC = categoryDAO.getAllCategories();
            request.setAttribute("listCC", listCC);

        ProductDAO productDAO = new ProductDAO();
        String searchValue = request.getParameter("valueSearch");
        List<Product> productList;

        // Nếu có giá trị tìm kiếm, gọi hàm tìm kiếm sản phẩm
        if (searchValue != null && !searchValue.trim().isEmpty()) {
            productList = productDAO.searchProductsByName(searchValue);
            request.setAttribute("searchValue", searchValue);
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("productsByPage", productList);

        int page = 1, numPerPage = 10;
        int size = productList.size();
        int numberOfPages = (size % numPerPage == 0) ? (size / numPerPage) : (size / numPerPage) + 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        int start = (page - 1) * numPerPage;
        int end = Math.min(page * numPerPage, size);

        List<Product> productsByPage = productDAO.getListByPage(productList, start, end);

        request.setAttribute("page", page);
        request.setAttribute("numberOfPages", numberOfPages);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.setAttribute("numberpage", numberOfPages);
        request.setAttribute("productsByPage", productsByPage);

        request.getRequestDispatcher("dashboard/productManage.jsp").forward(request, response);
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
