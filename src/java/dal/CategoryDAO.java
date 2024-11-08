package dal;

import model.Category;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends DBContext {
    
    // Lấy danh sách sản phẩm theo danh mục
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE category_id = ?";
        try (PreparedStatement preparedStatement = c.prepareStatement(query)) {
            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImg(resultSet.getString("img"));
                product.setDescription(resultSet.getString("description"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy tất cả danh mục
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT c.category_id, c.category_name, COUNT(p.product_id) AS product_count " +
                       "FROM Category c " +
                       "LEFT JOIN Product p ON c.category_id = p.category_id " +
                       "GROUP BY c.category_id, c.category_name";

        try (Statement statement = c.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setProductCount(resultSet.getInt("product_count")); // Thiết lập số lượng sản phẩm
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
    public void updateCategory(Category category) {
        String query = "UPDATE Category SET category_name = ? WHERE category_id = ?";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, category.getCategoryName());
            ps.setInt(2, category.getCategoryId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Lấy sản phẩm theo danh mục và giá
    public List<Product> getProductsByCategoryAndPrice(int categoryId, Double minPrice, Double maxPrice) {
        List<Product> productList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT product_id, product_name, price, img, description FROM Product WHERE 1=1");

        try {
            if (categoryId > 0) {
                query.append(" AND category_id = ?");
            }
            if (minPrice != null) {
                query.append(" AND price >= ?");
            }
            if (maxPrice != null) {
                query.append(" AND price <= ?");
            }

            try (PreparedStatement preparedStatement = c.prepareStatement(query.toString())) {
                int index = 1;
                if (categoryId > 0) {
                    preparedStatement.setInt(index++, categoryId); // Lọc theo category
                }
                if (minPrice != null) {
                    preparedStatement.setDouble(index++, minPrice); // Lọc theo giá tối thiểu
                }
                if (maxPrice != null) {
                    preparedStatement.setDouble(index++, maxPrice); // Lọc theo giá tối đa
                }

                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    Product product = new Product();
                    product.setProductId(resultSet.getInt("product_id"));
                    product.setProductName(resultSet.getString("product_name"));
                    product.setPrice(resultSet.getDouble("price"));
                    product.setImg(resultSet.getString("img"));
                    product.setDescription(resultSet.getString("description"));
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    public List<Category> getAll() {
        List<Category> categoryList = new ArrayList<>();
        String query = "SELECT * FROM Category";
        
        try (
             PreparedStatement ps = c.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                
                categoryList.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryList;
    }
    public Category getCategoryById(int id) {
        String query = "SELECT * FROM Category WHERE category_id = ?";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
