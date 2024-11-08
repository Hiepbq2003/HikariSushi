package dal;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;

public class ProductDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO(); // Khởi tạo ProductDAO
        List<Product> productList = productDAO.getAllProducts(); // Gọi phương thức lấy danh sách sản phẩm

         int categoryId = 1; // Thay đổi categoryId tùy theo nhu cầu (ví dụ: categoryId = 1)
        String sortBy = "price"; // Các giá trị có thể là "price", "rating", "purchase_count"
        
        // Lấy danh sách sản phẩm theo category và sắp xếp
        List<Product> products = productDAO.getTopProductsByCategory(categoryId, sortBy);
        
        // In kết quả ra màn hình
        if (products.isEmpty()) {
            System.out.println("No products found for the specified category and sorting method.");
        } else {
            System.out.println("Top 10 products in category " + categoryId + " sorted by " + sortBy + ":");
            for (Product product : products) {
                System.out.println("Product ID: " + product.getProductId());
                System.out.println("Product Name: " + product.getProductName());
                System.out.println("Price: " + product.getPrice());
                System.out.println("Rating: " + product.getRating());
                System.out.println("Purchase Count: " + product.getPurchaseCount());
                System.out.println("-------------");
            }
        }
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO Product (product_name, price, img, description, category_id ,releaseDate) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImg());
            ps.setString(4, product.getDescription());
            ps.setDate(6, new java.sql.Date(product.getReleaseDate().getTime()));
            ps.setInt(5, product.getCategoryId());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteProduct(int productId) {
        String query = "DELETE FROM Product WHERE product_id = ?";

        try (PreparedStatement preparedStatement = c.prepareStatement(query)) {
            preparedStatement.setInt(1, productId);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product with ID " + productId + " was deleted successfully.");
            } else {
                System.out.println("No product found with ID " + productId + ".");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        String query = "UPDATE Product SET product_name = ?, price = ?, img = ?, description = ?, releaseDate = ?, category_id = ? WHERE product_id = ?";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImg());
            ps.setString(4, product.getDescription());
            ps.setDate(5, new java.sql.Date(product.getReleaseDate().getTime()));
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getProductId());

            ps.executeUpdate();
            System.out.println("Product updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProducts(String categoryId, Double minPrice, Double maxPrice, String sortOrder) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE 1=1";

        if (categoryId != null && !categoryId.isEmpty()) {
            query += " AND category_id = ?";
        }
        if (minPrice != null) {
            query += " AND price >= ?";
        }
        if (maxPrice != null) {
            query += " AND price <= ?";
        }

        if ("asc".equals(sortOrder)) {
            query += " ORDER BY product_name ASC"; // A-Z
        } else if ("desc".equals(sortOrder)) {
            query += " ORDER BY product_name DESC"; // Z-A
        }

        try (PreparedStatement stmt = c.prepareStatement(query); ResultSet rs = stmt.executeQuery(query)) {

            int index = 1;
            if (categoryId != null && !categoryId.isEmpty()) {
                stmt.setString(index++, categoryId);
            }
            if (minPrice != null) {
                stmt.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                stmt.setDouble(index++, maxPrice);
            }

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public Map<String, Double> getProductStatistics() {
        Map<String, Double> statistics = new HashMap<>();

        String query = "SELECT MAX(price) as maxPrice, MIN(price) as minPrice, "
                + "AVG(price) as avgPrice, SUM(price) as totalPrice, COUNT(*) as count "
                + "FROM Product";

        try (Statement stmt = c.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            if (rs.next()) {
                statistics.put("max", rs.getDouble("maxPrice"));
                statistics.put("min", rs.getDouble("minPrice"));
                statistics.put("avg", rs.getDouble("avgPrice"));
                statistics.put("sum", rs.getDouble("totalPrice"));
                statistics.put("count", (double) rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statistics;
    }

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product";

        try (Statement statement = c.createStatement(); ResultSet rs = statement.executeQuery(query)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getFloat("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                product.setReleaseDate(rs.getDate("releaseDate"));
                product.setRating(rs.getFloat("rating"));
                product.setPurchaseCount(rs.getInt("purchase_count"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> getListByPage(List<Product> list, int start, int end) {
        // Kiểm tra giới hạn index start và end
        if (start < 0 || end > list.size() || start > end) {
            return new ArrayList<>(); // trả về danh sách trống nếu phạm vi không hợp lệ
        }
        return list.subList(start, end);
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT * FROM Product INNER JOIN Category ON Product.category_id = Category.category_id WHERE product_id = ?";

        try (PreparedStatement preparedStatement = c.prepareStatement(query)) {
            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Khởi tạo đối tượng Product và thiết lập các thuộc tính
                product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImg(resultSet.getString("img"));
                product.setDescription(resultSet.getString("description"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setReleaseDate(resultSet.getDate("releaseDate"));
                product.setRating(resultSet.getFloat("rating"));
                product.setPurchaseCount(resultSet.getInt("purchase_count"));
                product.setCategoryId(resultSet.getInt("category_id"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Lấy tất cả tên danh mục
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT category_name FROM Category";

        try (Statement statement = c.createStatement(); ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                categories.add(resultSet.getString("category_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE category_id = ?";
        try (PreparedStatement preparedStatement = c.prepareStatement(query)) {
            preparedStatement.setInt(1, categoryId); // Gán categoryId vào truy vấn
            ResultSet resultSet = preparedStatement.executeQuery();

            // Duyệt qua kết quả và thêm vào danh sách
            while (resultSet.next()) {
                Product product = new Product();
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImg(resultSet.getString("img"));
                product.setDescription(resultSet.getString("description"));
                products.add(product); // Thêm sản phẩm vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi nếu có
        }
        return products; // Trả về danh sách sản phẩm
    }

    // Lấy sản phẩm theo danh mục và giá
    public List<Product> getProductsByCategoryAndPrice(int categoryId, Double minPrice, Double maxPrice) {
        List<Product> productList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT product_id, product_name, price, img, description FROM Product WHERE 1=1");

        if (categoryId > 0) {
            query.append(" AND category_id = ?"); // Lọc theo category
        }
        if (minPrice != null) {
            query.append(" AND price >= ?"); // Lọc theo giá tối thiểu
        }
        if (maxPrice != null) {
            query.append(" AND price <= ?"); // Lọc theo giá tối đa
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
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    // Lấy sản phẩm nổi bật
    public List<Product> getFeaturedProducts() {
        List<Product> featuredProducts = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.price, p.img, p.description "
                + "FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE c.category_id = 1"; // Giả định bạn chỉ muốn sản phẩm trong danh mục có id = 1

        try (Statement statement = c.createStatement(); ResultSet resultSet = statement.executeQuery(sql)) {

            // Duyệt qua kết quả và thêm vào danh sách sản phẩm nổi bật
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id")); // Lấy product_id
                product.setProductName(resultSet.getString("product_name")); // Lấy product_name
                product.setPrice(resultSet.getDouble("price")); // Lấy price
                product.setImg(resultSet.getString("img")); // Lấy img
                product.setDescription(resultSet.getString("description")); // Lấy description
                featuredProducts.add(product); // Thêm sản phẩm vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
        return featuredProducts; // Trả về danh sách sản phẩm nổi bật
    }

    public List<Product> getFeaturedProductsByRating() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE rating >= 4.6"; // Cập nhật câu lệnh SQL cho phù hợp với cấu trúc CSDL
        try (Statement statement = c.createStatement(); ResultSet rs = statement.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Phương thức lấy danh sách sản phẩm top 10 theo purchase_count
    public List<Product> getTopPurchasedProducts() {
        List<Product> products = new ArrayList<>();
        // Thay thế LIMIT bằng TOP
        String sql = "SELECT TOP 12 * FROM Product ORDER BY purchase_count DESC";
        try (Statement statement = c.createStatement(); ResultSet rs = statement.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Phương thức lấy danh sách sản phẩm mới nhất (top 10)
    public List<Product> getNewestProducts() {
        List<Product> products = new ArrayList<>();
        // Thay thế LIMIT bằng TOP
        String sql = "SELECT TOP 12 * FROM Product ORDER BY releaseDate DESC";
        try (Statement statement = c.createStatement(); ResultSet rs = statement.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public int countAllProduct() {
        try {
            conn = new DBContext().c;
            String query = "SELECT COUNT(*) FROM Product";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return 0;
    }

    public int countAllTypeProduct() {
        try {
            conn = new DBContext().c;
            String query = "SELECT COUNT(DISTINCT category_id) FROM [Product]";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return 0;
    }

    // Phương thức tìm kiếm sản phẩm theo tên
    public List<Product> searchProductsByName(String productName) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE product_name LIKE ?";

        try (PreparedStatement preparedStatement = c.prepareStatement(query)) {
            preparedStatement.setString(1, "%" + productName + "%");
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setPrice(resultSet.getFloat("price"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setImg(resultSet.getString("img"));
                product.setDescription(resultSet.getString("description"));
                product.setReleaseDate(resultSet.getDate("releaseDate"));
                product.setRating(resultSet.getFloat("rating"));
                product.setPurchaseCount(resultSet.getInt("purchase_count"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    public List<Product> getTopProductsByCategory(int categoryId, String sortBy) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 10 * FROM Product WHERE category_id = ? ORDER BY " + sortBy + " DESC";
        
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getDouble("price"),
                    rs.getString("img"),
                    rs.getString("description"),
                    rs.getInt("quantity"),
                    rs.getDate("releaseDate"),
                    rs.getFloat("rating"),
                    rs.getInt("purchase_count"),
                    null, // Lớp Category nếu cần thiết
                    rs.getInt("category_id")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
      public List<Product> getProductsByPrice(int categoryId, double price, String sortOrder) {
    List<Product> products = new ArrayList<>();
    String sql = "SELECT * FROM Product WHERE category_id = ? AND price >= ? ORDER BY price " 
                + ("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
    try (PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, categoryId);
        ps.setDouble(2, price);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Product product = new Product(
                rs.getInt("product_id"),
                rs.getString("product_name"),
                rs.getDouble("price"),
                rs.getString("img"),
                rs.getString("description"),
                rs.getInt("quantity"),
                rs.getDate("releaseDate"),
                rs.getFloat("rating"),
                rs.getInt("purchase_count"),
                null, // Đặt null cho lớp Category nếu chưa cần thiết
                rs.getInt("category_id")
            );
            products.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return products;
}


}
