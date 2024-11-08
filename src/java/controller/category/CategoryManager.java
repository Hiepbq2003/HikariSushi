package controller.category;
import dal.DBContext;
import model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CategoryManager", urlPatterns = {"/manageCategory", "/addC", "/deleteCategory"})
public class CategoryManager extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/manageCategory".equals(action)) {
            listCategories(request, response);
        
        } else if ("/deleteCategory".equals(action)) {
            deleteCategory(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/addC".equals(action)) {
            addCategory(request, response);
        } 
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBContext dbContext = new DBContext();
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM Category";
            PreparedStatement ps = dbContext.c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                categories.add(category);
            }
            request.setAttribute("listAllC", categories);
            request.getRequestDispatcher("dashboard/categoryManage.jsp").forward(request, response); // Thay đường dẫn file JSP
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection();
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String companyName = request.getParameter("category_id");
        String cate = request.getParameter("category_name");
        DBContext dbContext = new DBContext();
        try {
            String query = "INSERT INTO Category (category_name) VALUES (?)";
            PreparedStatement ps = dbContext.c.prepareStatement(query);
            ps.setString(1, cate);
            ps.executeUpdate();
            response.sendRedirect("manageCategory");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection();
        }
    }


    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("category_id"));
        DBContext dbContext = new DBContext();
        try {
            String query = "DELETE FROM Category WHERE category_id = ?";
            PreparedStatement ps = dbContext.c.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            response.sendRedirect("manageCategory");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection();
        }
    }
}
