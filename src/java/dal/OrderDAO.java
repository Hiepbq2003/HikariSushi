package dal;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public OrderDAO() {
        DBContext dbContext = new DBContext();
        this.conn = dbContext.c;
    }

    public static void main(String[] args) {
        // Khởi tạo DBContext
        DBContext dbContext = new DBContext();

        // Tạo đối tượng để gọi phương thức getAll
        OrderDAO yourClass = new OrderDAO(); // Thay thế bằng tên lớp của bạn

        // Gọi phương thức getAll
        List<Order> orders = yourClass.getAll();

        // In ra danh sách đơn hàng
        for (Order order : orders) {
            System.out.println(order);
        }
    }

    // Phương thức lưu đơn hàng vào cơ sở dữ liệu
    public boolean saveOrder(int userId, String userName, String phone, String email, String address, float total, String notes) {
        String sql = "INSERT INTO [Order] (user_id, user_name, phone_number, email, address, total, order_date, order_status, notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), 'Đang xử lý', ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);  // Đặt userId vào câu lệnh SQL
            ps.setString(2, userName);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, address);
            ps.setFloat(6, total);
            ps.setString(7, notes);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu insert thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Trả về false nếu có lỗi
        }
    }

    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countTotalSold() {
        try {
            conn = new DBContext().c;
            String query = "SELECT COUNT(*) FROM [Order]";
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

    public double calculateTotalSales() {
        try {
            conn = new DBContext().c;
            String query = "SELECT SUM(total) FROM [Order]";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return 0;
    }

    public List<Order> getAll() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [Order]";
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Order từ kết quả truy vấn
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserName(rs.getString("user_name"));
                order.setPhoneNumber(rs.getString("phone_number"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setDate(rs.getDate("order_date"));  // Chú ý: sử dụng getDate() cho kiểu dữ liệu DATE
                order.setTotal(rs.getFloat("total"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setNotes(rs.getString("notes"));

                // Thêm vào danh sách
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();  // Đóng kết nối
        }
        return orders;  // Trả về danh sách đơn hàng
    }

   public double totalMoneyWeek(int dayOfWeek, int from, int to, int year, int month) {
    double total = 0.0;
    String sql = "SELECT SUM(total) AS totalMoney FROM [Order] " +
                 "WHERE YEAR(order_date) = ? AND MONTH(order_date) = ? " +
                 "AND DATEPART(dw, order_date) = ? " +
                 "AND DAY(order_date) BETWEEN ? AND ?";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, year);
        ps.setInt(2, month);
        ps.setInt(3, dayOfWeek); // Ngày trong tuần
        ps.setInt(4, from);      // Ngày bắt đầu trong khoảng
        ps.setInt(5, to);        // Ngày kết thúc trong khoảng

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getDouble("totalMoney");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return total;
}

     public double totalMoneyMonth(int month, int year) {
        double total = 0;
        String sql = "SELECT SUM(total) as totalMoney FROM [Order] " + 
                     "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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
