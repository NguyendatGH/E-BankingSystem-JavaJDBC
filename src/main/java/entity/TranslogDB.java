package entity;

import bussiness.Translog;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TranslogDB {

    public static boolean processTransaction(int accNo, String task, Double amount, Integer receiverAccNo) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        if (connection == null) {
            System.out.println("Error: Connection is null");
            return false;
        }

        CallableStatement cs = null;

        try {
            connection.setAutoCommit(false);

            if ("Withdraw".equals(task)) {
                cs = connection.prepareCall("{call sp_withdraw(?, ?)}");
                cs.setInt(1, accNo);
                cs.setDouble(2, amount);
                cs.execute();
            } else if ("Transfer".equals(task)) {
                cs = connection.prepareCall("{call sp_transfer(?, ?, ?)}");
                cs.setInt(1, accNo);
                cs.setInt(2, receiverAccNo);
                cs.setDouble(3, amount);
                cs.execute();
            } else {
                System.out.println("Invalid transaction type");
                return false;
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Rollback failed: " + ex);
            }
            System.out.println("Transaction error: " + e);
            return false;
        } finally {
            DBUtils.closePreparedStatement(cs);
            pool.freeConnection(connection);
        }
    }

    public static List<Translog> getTranslogsByAccount(int accNo) {
        List<Translog> translogList = new ArrayList<>();
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            cs = connection.prepareCall("{call sp_getTranslogsByAccount(?)}");
            cs.setInt(1, accNo);
            rs = cs.executeQuery();

            while (rs.next()) {
                int logID = rs.getInt("logID");
                LocalDateTime time = rs.getTimestamp("time").toLocalDateTime();
                String task = rs.getString("task");
                double amount = rs.getDouble("amount");
                double posBalance = rs.getDouble("PostBalance");

                Translog translog = new Translog(accNo, logID, time, task, amount, posBalance);
                translogList.add(translog);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(cs);
            pool.freeConnection(connection);
        }

        return translogList;
    }

    public static double getBalance(int accNo) {
        double balance = 0.0;
        String sqlString = "SELECT balance FROM Account WHERE accNo = ?";
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, accNo);
            rs = ps.executeQuery();
            if (rs.next()) {
                balance = rs.getDouble("balance");
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid account number format: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Database error when fetching balance " + e.getMessage());
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return balance;
    }

}
