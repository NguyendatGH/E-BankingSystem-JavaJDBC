/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import bussiness.Customer;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author rio
 */
public class CustomerDB {

    public static void addCustomer(Customer customer) {
        ConnectionPool pool = ConnectionPool.getInstance();
        if (pool == null) {
            System.out.println("error, pool is null");
        }
        Connection connection = pool.getConnection();

        if (connection == null) {
            System.out.println("error, connection is null");
        }
        String sqlString = "Insert into Customer(CustFname, CustLName, IDNo, Tel, Address, Email, Photo) values(?,?,?,?,?,?,?)";

        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sqlString);
            ps.setString(1, customer.getCustFname());
            ps.setString(2, customer.getCustLname());

            ps.setInt(3, customer.getIdNo());
            ps.setString(4, customer.getTel());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getEmail());

            byte[] photoBytes = customer.getPhoto();
            if (photoBytes == null) {
               ps.setNull(7, java.sql.Types.VARBINARY); //if user don't want to push a img to db
            } else {
                ps.setBytes(7, photoBytes);
            }

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }

    public static Customer getCustomer(int idNo) {
        Customer customer = null;

        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "Select * from Customer where idNo = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, idNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                int CustNo = rs.getInt("CustNo");
                String CustFname = rs.getString("CustFname");
                String CustLName = rs.getString("CustLName");
                String Tel = rs.getString("Tel");
                String Address = rs.getString("Address");
                String Email = rs.getString("Email");
                byte[] photo = rs.getBytes("Photo");
                customer = new Customer(CustNo, CustFname, CustLName, idNo, Tel, Address, Email, photo);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            DBUtils.closePreparedStatement(ps);
            DBUtils.closeResultSet(rs);
            pool.freeConnection(connection);
        }
        return customer;
    }

    public static Customer getCustomerForHome(int custNo) {
        Customer customer = null;

        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "Select * from Customer where CustNo = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, custNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                int CustNo = rs.getInt("CustNo");
                String CustFname = rs.getString("CustFname");
                String CustLName = rs.getString("CustLName");
                int idNo = rs.getInt("IdNo");
                String Tel = rs.getString("Tel");
                String Address = rs.getString("Address");
                String Email = rs.getString("Email");
                byte[] photo = rs.getBytes("Photo");
                customer = new Customer(CustNo, CustFname, CustLName, idNo, Tel, Address, Email, photo);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            DBUtils.closePreparedStatement(ps);
            DBUtils.closeResultSet(rs);
            pool.freeConnection(connection);
        }
        return customer;
    }

    public static List<Customer> getAllCust() {
        List<Customer> custList = new ArrayList<>();
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        String sqlString = "Select * from Customer";
        PreparedStatement ps = null;
        ResultSet rs = null;
        Customer c;
        try {
            ps = connection.prepareStatement(sqlString);
            rs = ps.executeQuery();
            while (rs.next()) {
                int CustNo = rs.getInt("CustNo");
                String CustFname = rs.getString("custFname");
                String CustLname = rs.getString("custLname");

                int accNo = rs.getInt("IDNo");
                String tel = rs.getString("Tel");

                String address = rs.getString("Address");
                String email = rs.getString("Email");

                byte[] photo = rs.getBytes("Photo");
                c = new Customer(CustNo, CustFname, CustLname, accNo, tel, address, email, photo);
                custList.add(c);
            }

        } catch (SQLException e) {
            System.out.println(e);
        } finally {

            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }

        return custList;
    }

    public static boolean updateCustumerInfor(int custNo, String fname, String lname, String email, String tel, String address, byte[] photo) {
        String sqlString = "UPDATE Customer SET custFname = ?, custLname = ?, Email = ?, Tel = ?, Address = ?, Photo = ? WHERE CustNo = ?";
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        PreparedStatement ps = null;
        try {

            ps = connection.prepareStatement(sqlString);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, email);
            ps.setString(4, tel);
            ps.setString(5, address);
            ps.setBytes(6, photo);
            ps.setInt(7, custNo);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }

}
