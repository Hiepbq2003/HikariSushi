package dal;

import model.Product;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private DBContext dbContext;

    public UserDAO() {
        dbContext = new DBContext(); // Khởi tạo DBContext
    }

    public static void main(String[] args) {
        // Tạo một đối tượng UserDAO
        User user = new User();
        user.setUsername("testuser"); // Tên đăng nhập (user_name trong DB)
        user.setEmail("testuser@example.com"); // Email mới
        user.setPassword("newpassword123"); // Mật khẩu mới
        user.setAddress("123 Main St"); // Địa chỉ mới
        user.setGender("1"); // Giới tính
        user.setPhone("01234567890"); // Số điện thoại mới
        user.setRoleId(2); // Vai trò (1 cho người dùng)

        // Khởi tạo UserDAO để gọi phương thức update
        UserDAO userDAO = new UserDAO();

        // Cập nhật người dùng
        boolean success = userDAO.updateUsers(user);

        if (success) {
            System.out.println("Cập nhật tài khoản thành công.");
        } else {
            System.out.println("Cập nhật tài khoản thất bại.");
        }

    }

    // Phương thức kiểm tra thông tin đăng nhập
    public User checkLogin(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getString("user_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getInt("role_id")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Phương thức cập nhật mật khẩu người dùng
    public void updatePassword(User user) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getPassword());
            ps.setString(2, user.getEmail()); // Sử dụng email để tìm kiếm người dùng
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy role của người dùng
    public List<String> getUserRoles(int userId) {
        List<String> roles = new ArrayList<>();
        String sql = "SELECT r.role_name FROM Roles r "
                + "JOIN UserRoles ur ON r.role_id = ur.role_id "
                + "WHERE ur.user_id = ?";

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                roles.add(rs.getString("role_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }

    // Đăng ký người dùng
    public boolean registerUser(User user) {
        boolean isSuccess = false;
        String sql = "INSERT INTO [Users] (user_name, email, password, address, gender, phone, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setInt(5, "Nam".equals(user.getGender()) ? 1 : ("Nữ".equals(user.getGender()) ? 0 : 2));
            ps.setString(6, user.getPhone());
            ps.setInt(7, user.getRoleId());

            int rowsInserted = ps.executeUpdate();
            isSuccess = rowsInserted > 0; // Đăng ký thành công nếu có dòng bị ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess; // Trả về kết quả
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu số lượng lớn hơn 0, tức là email đã tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Nếu không có lỗi, coi như email chưa tồn tại
    }

    // Xóa người dùng
    public void deleteUser(User user) {
        String sql = "DELETE FROM Users WHERE email = ?";

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.executeUpdate(); // Thực hiện xóa
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addToCart(int userId, int productId, int quantity) {
        String sql = "INSERT INTO UserCart (userId, productId, quantity) VALUES (?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

        try (Connection conn = dbContext.c; PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, quantity);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateCart(int userId, int productId, int quantity) {
        String sql = "UPDATE UserCart SET quantity = ? WHERE userId = ? AND productId = ?";

        try (Connection conn = dbContext.c; PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, productId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void removeFromCart(int userId, int productId) {
        String sql = "DELETE FROM UserCart WHERE userId = ? AND productId = ?";

        try (Connection conn = dbContext.c; PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy giỏ hàng của người dùng
    public List<Product> getCart(int userId) {
        List<Product> cart = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.price, uc.quantity "
                + "FROM UserCart uc JOIN Product p ON uc.productId = p.product_id "
                + "WHERE uc.userId = ?";

        try (Connection conn = dbContext.c; PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                cart.add(product); // Thêm sản phẩm vào giỏ hàng
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }

    public int countAllUser() {
        try {
            conn = new DBContext().c;
            String query = "SELECT COUNT(*) FROM Users";
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

    private void closeConnection() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("role_id"));
                list.add(user); // Thêm người dùng vào danh sách
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO Users (user_name, email, password, address, gender, phone, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // Nên mã hóa mật khẩu
            ps.setString(4, user.getAddress());
            int genderBit = "male".equals(user.getGender()) ? 1 : 0; // 1 cho "male", 0 cho "female"
            ps.setInt(5, genderBit);
            ps.setString(6, user.getPhone());
            ps.setInt(7, user.getRoleId());

            return ps.executeUpdate() > 0; // Trả về true nếu có dòng bị ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa người dùng theo email
    public boolean deleteUser(String email) {
        String sql = "DELETE FROM Users WHERE user_name = ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            return ps.executeUpdate() > 0; // Trả về true nếu có dòng bị ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin người dùng
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET user_name = ?, password = ?, address = ?, gender = ?, phone = ? WHERE email = ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Nên mã hóa mật khẩu
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getEmail());

            return ps.executeUpdate() > 0; // Trả về true nếu có dòng bị ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUsers(User user) {
        String sql = "UPDATE Users SET user_name = ?, password = ?, address = ?, gender = ?, phone = ?, role_id = ? WHERE email = ?";
        boolean rowUpdated = false;

        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getPhone());
            ps.setInt(6, user.getRoleId());
            ps.setString(7, user.getEmail());

            rowUpdated = ps.executeUpdate() > 0; // Nếu có dòng nào được cập nhật
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    // Tìm kiếm người dùng theo tên hoặc email
    public List<User> searchUser(String keyword) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE user_name LIKE ? OR email LIKE ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("role_id"));
                list.add(user); // Thêm người dùng vào danh sách
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // Trả về danh sách người dùng tìm thấy
    }

    public List<User> getUsersBySearchName(String searchName) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE user_name LIKE ? OR email LIKE ? OR address LIKE ?";

        try (Connection conn = new DBContext().c; // Mở kết nối từ DBContext
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Thiết lập tham số tìm kiếm
            pstmt.setString(1, "%" + searchName + "%"); // Tìm kiếm theo tên đăng nhập
            pstmt.setString(2, "%" + searchName + "%"); // Tìm kiếm theo email
            pstmt.setString(3, "%" + searchName + "%"); // Tìm kiếm theo địa chỉ

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Thông thường không nên lấy mật khẩu
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("roleId")); // Lưu ý: sử dụng getInt() cho roleId
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> searchUserByName(String username) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE user_name LIKE ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + username + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("role_id"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean checkUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE user_name = ?";
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu đếm lớn hơn 0 thì có nghĩa là tên người dùng đã tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Nếu không có lỗi và không tìm thấy
    }

    public User getUserByName(String name) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE user_name = ?"; // Lọc theo user_name
        try (Connection conn = dbContext.c; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name); // Sử dụng setString vì name là chuỗi
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("role_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public Integer getUserId(String username) {
        Integer userId = null; // Biến để lưu ID người dùng
        String sql = "SELECT user_id FROM Users WHERE user_name = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("user_id"); // Lấy ID người dùng từ kết quả
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userId;
    }
   

}
