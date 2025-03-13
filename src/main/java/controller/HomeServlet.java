/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import bussiness.Customer;
import bussiness.Translog;
import entity.CustomerDB;
import entity.TranslogDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.OutputStream;
import java.util.List;

/**
 *
 * @author rio
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/HomeServlet"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("in home servlet process req");
        request.getRequestDispatcher("/view/home.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer accNo = (session != null) ? (Integer) session.getAttribute("accNo") : null;
        Integer custNo = (session != null) ? (Integer) session.getAttribute("custNo") : null;
        if (accNo == null) {
            System.out.println("No accNo found in session!");
        }

        if (custNo == null) {
            System.out.println("No custNo found in session!");
        }
        Customer c = new Customer();
        if (session.getAttribute("Customer") == null) {
            c = CustomerDB.getCustomerForHome(custNo);
            session.setAttribute("Customer", c);

            if (c.getPhoto() != null) {
                session.setAttribute("CustomerPhoto", c.getPhoto());
            }

        }

        if (session.getAttribute("transactionList") == null) {
            List<Translog> translog = TranslogDB.getTranslogsByAccount(accNo);
            session.setAttribute("transactionList", translog);
        }

        request.setAttribute("accNo", accNo);

        byte[] photoData = c.getPhoto();
        if (photoData != null) {
            System.out.println("" + photoData.length);
        } else {
            System.out.println("No image found!");
        }

        Double balance = TranslogDB.getBalance(accNo);
        session.setAttribute("balance", balance);

        if ("true".equals(request.getParameter("image"))) {
            byte[] imageData = (byte[]) session.getAttribute("CustomerPhoto");

            if (imageData != null) {
                response.setContentType("image/jpeg"); 
                response.setContentLength(imageData.length);

                OutputStream out = response.getOutputStream();
                out.write(imageData);
                out.close();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
            return;
        }
        request.getRequestDispatcher("/view/home.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
