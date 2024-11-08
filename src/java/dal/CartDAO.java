package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.UserCart;

public class CartDAO {
    private DBContext dbContext;

    // Constructor để khởi tạo DBContext
    public CartDAO() {
        this.dbContext = new DBContext();
    }

    // Phương thức để thêm hoặc cập nhật sản phẩm trong giỏ hàng
    public void addOrUpdateProductInCart(String userId, String productId, int quantity) {
        String checkQuery = "SELECT quantity FROM UserCart WHERE userId = ? AND productId = ?";
        try (Connection conn = dbContext.c;
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, userId);
            checkStmt.setString(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Nếu sản phẩm đã có trong giỏ hàng, cập nhật số lượng
                int currentQuantity = rs.getInt("quantity");
                int newQuantity = currentQuantity + quantity;
                updateProductInCart(conn, userId, productId, newQuantity);
            } else {
                // Nếu sản phẩm chưa có, thêm mới vào giỏ hàng
                insertProductInCart(userId, productId, quantity);
            }
        } catch (SQLException e) {
            System.err.println("Error in addOrUpdateProductInCart: " + e.getMessage());
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    private void updateProductInCart(Connection conn, String userId, String productId, int newQuantity) throws SQLException {
        String updateQuery = "UPDATE UserCart SET quantity = ? WHERE userId = ? AND productId = ?";
        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setInt(1, newQuantity);
            updateStmt.setString(2, userId);
            updateStmt.setString(3, productId);
            updateStmt.executeUpdate();
        }
    }

    // Thêm sản phẩm mới vào giỏ hàng
    private void insertProductInCart(String userId, String productId, int quantity) {
        String insertQuery = "INSERT INTO UserCart (userId, productId, quantity) VALUES (?, ?, ?)";
        try (Connection conn = dbContext.c;
             PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, userId);
            insertStmt.setString(2, productId);
            insertStmt.setInt(3, quantity);
            insertStmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in insertProductInCart: " + e.getMessage());
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void removeProductFromCart(String userId, String productId) {
        String deleteQuery = "DELETE FROM UserCart WHERE userId = ? AND productId = ?";
        try (Connection conn = dbContext.c;
             PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setString(1, userId);
            deleteStmt.setString(2, productId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in removeProductFromCart: " + e.getMessage());
        }
    }

     public List<UserCart> getCartItems(int userId) {
        List<UserCart> cartItems = new ArrayList<>();
        String selectQuery = "SELECT productId, quantity FROM UserCart WHERE userId = ?";
        try (Connection conn = dbContext.c;
             PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
            selectStmt.setInt(1, userId); // Sử dụng setInt vì userId là kiểu int
            ResultSet rs = selectStmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("productId"); // Lấy productId
                int quantity = rs.getInt("quantity");   // Lấy quantity
                cartItems.add(new UserCart(userId, productId, quantity)); // Tạo đối tượng UserCart
            }
        } catch (SQLException e) {
            System.err.println("Error in getCartItems: " + e.getMessage());
        }
        return cartItems; // Trả về danh sách sản phẩm trong giỏ hàng
    }
     public double totalMoneyMonth(int month, int year) {
        double total = 0;
        String sql = "SELECT SUM(total) as totalMoney FROM [Order] " + // Chú ý đến tên bảng
                     "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ?";

        try (Connection conn = dbContext.c;PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("totalMoney");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
