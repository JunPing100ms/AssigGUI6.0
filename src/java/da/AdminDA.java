package da;

import domain.Admin;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDA {

    private String host = "jdbc:derby://localhost:1527/Assignment";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Admin";
    private Connection conn;
    private PreparedStatement stmt;

    public AdminDA() {
        createConnection();
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException ex) {
//            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
//                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    //CRUD
    public void createRecord(Admin admin) {
        try {
            String insertSQL = "INSERT INTO " + tableName + " (ADMIN_PERMISSION_KEY, ADMIN_USER_ID) VALUES (?,?)";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, admin.getPermission_key());
            stmt.setString(2, admin.getUser_id());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("EX: " + ex);
        }
    }

    public Admin retrieveRecord(String id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ADMIN_USER_ID = ?";
        Admin admin = new Admin();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                admin = new Admin(rs.getInt("ADMIN_ID"),
                        rs.getString("ADMIN_PERMISSION_KEY"),
                        rs.getString("ADMIN_USER_ID"));
            }
        } catch (SQLException ex) {
            return admin;
        }
        return admin;
    }

    public List<Admin> getAllRecords() throws SQLException {
        Admin admin = null;
        String queryStr = "SELECT * FROM " + tableName;
        List<Admin> adminList = new ArrayList<>();

        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                admin = new Admin(
                        rs.getInt("Admin_ID"),
                        rs.getString("Admin_Permission_Key"),
                        rs.getString("Admin_User_ID"));
                adminList.add(admin);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return adminList;
    }

    public void updateProfileRecord(Admin admin) {
        try {
            String insertSQL = "UPDATE " + tableName + " SET ADMIN_ID, ADMIN_PERMISSION_KEY=?, WHERE ADMIN_USER_ID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, String.valueOf(admin.getId()));
            stmt.setString(2, admin.getPermission_key());
            stmt.setString(3, admin.getUser_id());

            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public void deleteProfileRecord(String id) {
        try {
            String insertSQL = "DELETE FROM " + tableName + " WHERE ADMIN_USER_ID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }
}
