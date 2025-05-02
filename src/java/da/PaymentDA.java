package da;

import domain.Order;
import domain.Payment;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentDA {

    private String host = "jdbc:derby://localhost:1527/Assignment";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Payment";
    private Connection conn;
    private PreparedStatement stmt;

    public PaymentDA() {
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
    public void createRecord(Payment payment) {
        try {
            String insertSQL = "INSERT INTO " + tableName + " VALUES (?,?,?,?,?,?)";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, payment.getPaymentID());
            stmt.setDouble(2, payment.getTotalPrice());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getPaymentStatus());
            stmt.setString(5, payment.getPaymentDate());
            stmt.setString(6, payment.getUserID());
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public Payment retrieveRecord(String id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE paymentID = ?";
        Payment payment = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                payment = new Payment(
                        rs.getString("paymentID"),
                        rs.getString("userID"),
                        rs.getDouble("totalPrice"),
                        rs.getString("paymentMethod"),
                        rs.getString("paymentStatus"),
                        rs.getString("orderDate"));
            }
            return payment;
        } catch (SQLException ex) {
            return payment = new Payment();
        }

    }

    //Added by Yizhe
    public ResultSet getRecordResultSet() {
        String getRecordStr = "SELECT * FROM " + tableName;
        ResultSet rs = null;

        try {
            stmt = conn.prepareStatement(getRecordStr);
            rs = stmt.executeQuery();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return rs;
    }

    public void updateProfileRecord(Payment payment) {
        try {
            String insertSQL = "UPDATE " + tableName + " SET paymentMethod=?, paymentStatus=?, WHERE paymentID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, payment.getPaymentMethod());
            stmt.setString(2, payment.getPaymentStatus());
            stmt.setString(3, payment.getPaymentID());

            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public void deleteProfileRecord(Payment payment) {
        try {
            String insertSQL = "DELETE FROM " + tableName + " WHERE paymentID=?";
            stmt = conn.prepareStatement(insertSQL);
            stmt.setString(1, payment.getPaymentID());
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public List<Payment> getUserPayment(String userID) throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payment p LEFT JOIN Orders o ON p.payment_id = o.payment_id WHERE p.user_id = ?";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, userID);
        ResultSet rs = stmt.executeQuery();

        Map<String, Payment> paymentMap = new HashMap<>();

        while (rs.next()) {
            String paymentID = rs.getString("paymentID");
            Payment payment = paymentMap.get(paymentID);

            if (payment == null) {
                payment = new Payment(
                        paymentID,
                        rs.getString("userID"),
                        rs.getDouble("totalPrice"),
                        rs.getString("paymentMethod"),
                        rs.getString("paymentStatus"),
                        rs.getString("paymentDate")
                );
                paymentMap.put(paymentID, payment);
            }

            Order order = new Order(
                    rs.getString("orderID"),
                    paymentID,
                    rs.getString("itemID"),
                    rs.getInt("quantity"),
                    rs.getDouble("price"),
                    rs.getString("orderDate")
            );
            payment.getOrders().add(order);
        }

        payments.addAll(paymentMap.values());
        return payments;
    }

    public boolean updatePaymentStatus(String paymentID, String paymentMethod) throws SQLException {
        String updateSQL = "UPDATE Payment SET paymentStatus = 'Paid', paymentMethod = ? WHERE paymentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
            stmt.setString(1, paymentMethod);
            stmt.setString(2, paymentID);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
