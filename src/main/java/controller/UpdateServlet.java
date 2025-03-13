/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import bussiness.Customer;
import entity.CustomerDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;

/**
 *
 * @author rio
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int custNo = Integer.parseInt(request.getParameter("custNo"));
        String fname = request.getParameter("fname").trim();
        String lname = request.getParameter("lname").trim();
        String email = request.getParameter("email").trim();
        String tel = request.getParameter("tel");
        String address = request.getParameter("address").trim();
        System.out.println("custno want to update: " + custNo);
        
        
         if (tel.matches("^09\\d{8}$")) {
            tel = tel.substring(0, 4) + " " + tel.substring(4);
        } else if (!tel.matches("^[1-9]-\\d{6}$")) {
            throw new IllegalArgumentException("Invalid phone number format: " + tel);
        }

         
        Part filePart = request.getPart("photo");
        byte[] photo = null;

        if (filePart != null && filePart.getSize() > 0) {
            InputStream inputStream = filePart.getInputStream();
            photo = inputStream.readAllBytes();
        }
        boolean success = CustomerDB.updateCustumerInfor(custNo, fname, lname, email, tel.trim(), address, photo);
        System.out.println("update: " + success);
        if (success) {
            HttpSession session = request.getSession();
            session.setAttribute("custFname", fname);
            session.setAttribute("custLname", lname);
            session.setAttribute("email", email);
            session.setAttribute("tel", tel);
            session.setAttribute("address", address);
            System.out.println("Profile updated successfully!");

                Customer updatedCustomer = CustomerDB.getCustomerForHome(custNo); 
            session.setAttribute("Customer", updatedCustomer);
            request.setAttribute("message", "Profile updated successfully!");
            response.sendRedirect(request.getContextPath() + "/view/home.jsp");
        } else {
            request.setAttribute("errStr", "Error updating profile. Please try again.");
            request.getRequestDispatcher("/view/updateProfile.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
