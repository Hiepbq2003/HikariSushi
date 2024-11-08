package dal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBContext {

        public Connection c;
	private final String DATABASE="HikariSuShi"; //Sua
	private final String USERNAME = "sa";
	    private final String PASSWORD = "123123123";
	
	    public DBContext() {
	        try {
	            String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DATABASE;
	
	            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	            c = DriverManager.getConnection(url, USERNAME, PASSWORD);
	            System.out.println("Connected, Database: " + DATABASE);
	        } catch (ClassNotFoundException | SQLException ex) {
	            System.err.println(ex);
	        }
	    }
	
public void closeConnection() {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
