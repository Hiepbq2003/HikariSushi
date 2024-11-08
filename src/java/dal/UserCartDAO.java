package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.UserCart;
import java.sql.ResultSet;

public class UserCartDAO {
    private DBContext dbContext = new DBContext();

    public void addOrUpdateProductInCart(int userId, int productId, int quantity) {
        String query = """
                MERGE INTO UserCart AS target
                USING (VALUES (?, ?, ?)) AS source (userId, productId, quantity)
                ON (target.userId = source.userId AND target.productId = source.productId)
                WHEN MATCHED THEN 
                    UPDATE SET target.quantity = target.quantity + source.quantity
                WHEN NOT MATCHED THEN 
                    INSERT (userId, productId, quantity) 
                    VALUES (source.userId, source.productId, source.quantity);
                """;

        try (Connection conn = dbContext.c;
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in addOrUpdateProductInCart: " + e.getMessage());
        }
    }

    public int getTotalQuantityByUserId(int userId) {
        String query = "SELECT SUM(quantity) AS totalQuantity FROM UserCart WHERE userId = ?";
        int totalQuantity = 0;

        try (Connection conn = dbContext.c;
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalQuantity = rs.getInt("totalQuantity");
            }
        } catch (SQLException e) {
            System.err.println("Error in getTotalQuantityByUserId: " + e.getMessage());
        }
        return totalQuantity;
    }
}


