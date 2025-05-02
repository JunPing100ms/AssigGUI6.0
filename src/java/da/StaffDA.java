package da;

import domain.Staff;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDA {

    private String host = "jdbc:derby://localhost:1527/Assignment";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Staff";
    private Connection conn;
    private PreparedStatement stmt;

    public StaffDA() {
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
    public void createRecord(Staff staff) {
        try {
            String insertSQL = "INSERT INTO " + tableName + " (STAFF_PERMISSION_KEY, STAFF_USER_ID) VALUES (?,?)";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, staff.getPermission_key());
            stmt.setString(2, staff.getUser_id());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Staff CREATE ISSUE");
            System.out.println("EX: " + ex);
        }
    }

    public Staff retrieveRecord(String id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE STAFF_USER_ID = ?";
        Staff staff = new Staff();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                staff = new Staff(rs.getInt("STAFF_ID"),
                        rs.getString("STAFF_PERMISSION_KEY"),
                        rs.getString("STAFF_USER_ID"));
            }
        } catch (SQLException ex) {
            return staff;
        }
        return staff;
    }

    public List<Staff> getAllRecords() throws SQLException {
        Staff staff = null;
        String queryStr = "SELECT * FROM " + tableName;
        List<Staff> staffList = new ArrayList<>();

        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                staff = new Staff(
                        rs.getInt("Staff_ID"),
                        rs.getString("Staff_Permission_Key"),
                        rs.getString("Staff_User_ID"));
                staffList.add(staff);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return staffList;
    }

    public void updateProfileRecord(Staff staff) {
        try {
            String insertSQL = "UPDATE " + tableName + " SET STAFF_ID, STAFF_PERMISSION_KEY=?, WHERE STAFF_USER_ID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, String.valueOf(staff.getId()));
            stmt.setString(2, staff.getPermission_key());
            stmt.setString(3, staff.getUser_id());

            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public void deleteProfileRecord(String id) {
        try {
            String insertSQL = "DELETE FROM " + tableName + " WHERE STAFF_USER_ID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }
}
