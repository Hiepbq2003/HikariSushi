package controller.category;

import dal.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import java.io.IOException;

@WebServlet(name = "updateCategory", urlPatterns = {"/updateCategory"})
public class updateCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("category_id");
        int id = Integer.parseInt(idStr);

        CategoryDAO categoryDAO = new CategoryDAO();
        Category category = categoryDAO.getCategoryById(id);

        request.setAttribute("detail", category);
        request.getRequestDispatcher("dashboard/categoryUpdate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String categoryName = request.getParameter("cName");

        Category category = new Category();
        category.setCategoryId(id);
        category.setCategoryName(categoryName);

        CategoryDAO categoryDAO = new CategoryDAO();
        categoryDAO.updateCategory(category);

        response.sendRedirect("manageCategory"); // Chuyển về trang quản lý danh mục
    }
}
