package dal;

import java.sql.Connection;
import dal.DBContext;
import model.Admin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.text.html.HTMLDocument;
       

public class DAO extends DBContext{
    //check authen
    public Admin checkAuthen(String username,String password){
    String sql = "select * from admin where username = ? and password = ?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            
            if(rs.next()){// Nếu tồn tại user, tạo đối tượng Admin
                Admin ad = new Admin();
                ad.setUsername(rs.getString("username"));
                ad.setPassword(rs.getString("password"));
                return ad;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;// Trả về null nếu thông tin đăng nhập sai
    }
}
