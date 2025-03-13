/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.AccountDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "/view/login.jsp";
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String accNo = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("accNo".equals(cookie.getName())) {
                    accNo = cookie.getValue();
                   
                    break;
                }
            }
        }
        
        
        if (accNo != null) {
            request.setAttribute("accNo", accNo);
            HttpSession session = request.getSession();
            session.setAttribute("accNo", accNo);
            request.getRequestDispatcher("/view/home.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accNoStr = request.getParameter("accNo");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        boolean isChecked = "on".equals(rememberMe);

        System.out.println("~~~~~~~~~~~~~~");

        try {
            int accNo = Integer.parseInt(accNoStr);
            int custNo = AccountDB.getCustNoFromAccount(accNoStr);
            double balance = AccountDB.login(accNo, password);
            if (balance >= 0) {
                HttpSession session = request.getSession();
                session.setAttribute("accNo", accNo);
                session.setAttribute("custNo", custNo);
                if (isChecked) {
                    Cookie cookie = new Cookie("accNo", String.valueOf(accNo));
                    cookie.setMaxAge(60 * 60 * 24);
                    response.addCookie(cookie);
                }
                response.sendRedirect(request.getContextPath() + "/HomeServlet");
            } else {
                request.setAttribute("errorMessage", "invalid accNo or password");
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, "Login error", e);
            request.setAttribute("errorMessage", "Login error, please try again.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
