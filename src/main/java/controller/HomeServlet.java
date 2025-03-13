/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import bussiness.Customer;
import entity.CustomerDB;
import entity.TranslogDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        System.out.println("in home servlet doget");
        HttpSession session = request.getSession();
        Integer accNo = (session != null) ? (Integer) session.getAttribute("accNo") : null;
        Integer custNo = (session != null) ? (Integer) session.getAttribute("custNo") : null;
        if (accNo == null) {
            System.out.println("No accNo found in session!");
        } else {
            System.out.println("accNo in home: " + accNo);
        }

        if (custNo == null) {
            System.out.println("No custNo found in session!");
        } else {
            System.out.println("custNo in home: " + custNo);
        }

        if (session.getAttribute("Customer") == null) {
            Customer c = CustomerDB.getCustomerForHome(custNo);
            session.setAttribute("Customer", c);
        }

        request.setAttribute("accNo", accNo);

        Double balance = TranslogDB.getBalance(accNo);

        System.out.println("balance of account: " + balance);
        session.setAttribute("balance", balance);
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
