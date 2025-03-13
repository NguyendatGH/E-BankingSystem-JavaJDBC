/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import bussiness.Account;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AccountDB {

    public static int createNewAccount(Account account) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "Insert into Account(CustNo, Balance, Password, LastAccess) values(?,?,?,?)";

        PreparedStatement ps = null;
        ResultSet rs = null;
        int accNo = -1;
        try {
            ps = connection.prepareStatement(sqlString, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, account.getCustNo());
            ps.setDouble(2, account.getBalance());
            ps.setString(3, account.getPassword());
            ps.setTimestamp(4, Timestamp.valueOf(account.getLastAccess()));

            int rowsInserted = ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rowsInserted > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    accNo = rs.getInt(1); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return accNo;
    }

    public static List<Account> getAllAccount() {
        List<Account> accList = new ArrayList<>();
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "Select * from Account";
        PreparedStatement ps = null;
        ResultSet rs = null;
        Account a;
        try {
            ps = connection.prepareStatement(sqlString);
            rs = ps.executeQuery();
            while (rs.next()) {
                int CustNo = rs.getInt("CustNo");
                int AccNo = rs.getInt("AccNo");
                Double Balance = rs.getDouble("Balance");

                String Password = rs.getString("Password");

                Timestamp LastAccessTimestamp = rs.getTimestamp("LastAccess");
                LocalDateTime LastAccess = (LastAccessTimestamp != null)
                        ? LastAccessTimestamp.toLocalDateTime() : null;

                a = new Account(CustNo, AccNo, Balance, Password, LastAccess);
                accList.add(a);
            }

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }

        return accList;
    }

    public static double login(int accNo, String password) throws SQLException {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "{call sp_Login(?, ?, ?)}";
        CallableStatement cs = null;
        double balance = -1;

        try {
            cs = connection.prepareCall(sqlString);

            cs.setInt(1, accNo);
            cs.setString(2, password);
            cs.registerOutParameter(3, Types.DECIMAL);

            cs.execute();

            balance = cs.getDouble(3);
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            if (cs != null) {
                cs.close();
            }
            if (connection != null) {
                pool.freeConnection(connection);
            }
        }
        return balance;
    }

    public static int getCustNoFromAccount(String accNoStr) {
        int custNo = -1;
        if (accNoStr == null || accNoStr.trim().isEmpty()) {
            return custNo;
        }
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        String sqlString = "SELECT CustNo FROM Account WHERE AccNo = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int accNo = Integer.parseInt(accNoStr);

            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, accNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                custNo = rs.getInt("CustNo");
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid account number format: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Database error when fetching customer number: " + e.getMessage());
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }

        return custNo;
    }
}
