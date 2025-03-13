/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import bussiness.Account;
import bussiness.Customer;
import entity.AccountDB;
import entity.CustomerDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.time.LocalDateTime;


/**
 *
 * @author rio
 */
@WebServlet(name = "RegistrationServlet", urlPatterns = {"/RegistrationServlet"})
@MultipartConfig
public class RegistrationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/view/register.jsp";
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("idNo"));
        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String phoneNo = request.getParameter("phoneNo").trim();

        if (phoneNo.matches("^09\\d{8}$")) {
            phoneNo = phoneNo.substring(0, 4) + " " + phoneNo.substring(4);
        } else if (!phoneNo.matches("^[1-9]-\\d{6}$")) {
            throw new IllegalArgumentException("Invalid phone number format: " + phoneNo);
        }

        String email = request.getParameter("email");
        String address = request.getParameter("address");
        Double initialBalance = Double.valueOf(request.getParameter("initialBalance"));
        String password = request.getParameter("password");

        Part filePart = request.getPart("photo");
        byte[] photoData = null;

        if (filePart != null && filePart.getSize() > 0) {
            photoData = readFilePart(filePart);
        }
        

        Customer c = new Customer(fname, lname, id, phoneNo.trim(), address, email, photoData);
        CustomerDB.addCustomer(c);
        Customer cdb = CustomerDB.getCustomer(id);

        LocalDateTime currentTime = LocalDateTime.now();

        Account a = new Account(cdb.getCustNo(),initialBalance, password, currentTime);
        int accNo = AccountDB.createNewAccount(a);

        System.out.println("~~~~~REGISTER SUCCESS, Your Account No is: " + accNo);
        HttpSession session = request.getSession();
        session.setAttribute("registeredAccNo", accNo);
        session.setAttribute("registeredPassword", password);

        response.sendRedirect(request.getContextPath() + "/view/login.jsp");

    }

    private byte[] readFilePart(Part filePart) throws IOException {
        try (InputStream inputStream = filePart.getInputStream(); ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            return outputStream.toByteArray();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
