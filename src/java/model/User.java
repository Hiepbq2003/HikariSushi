package model;

public class User {
    private String username;
    private String email;
    private String password;
    private String address;
    private String gender;
    private String phone;
    private int roleId; // Khóa ngoại liên kết đến bảng Roles

    // Constructor không tham số
    public User() {
    }

    // Constructor đầy đủ
    public User(String username, String email, String password, String address, String gender, String phone, int roleId) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.address = address;
        this.gender = gender;
        this.phone = phone;
        this.roleId = roleId;
    }

    // Getters và Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    // Phương thức toString để hiển thị thông tin người dùng
    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                ", roleId=" + roleId +
                '}';
    }
}
