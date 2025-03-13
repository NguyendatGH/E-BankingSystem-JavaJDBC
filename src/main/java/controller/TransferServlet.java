package controller;

import bussiness.Translog;
import entity.TranslogDB;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "TransferServlet", urlPatterns = {"/TransferServlet"})
public class TransferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accNoStr = request.getParameter("accNo");

        if (accNoStr != null && !accNoStr.isEmpty()) {
            try {
                int accNo = Integer.parseInt(accNoStr);
                request.setAttribute("accNo", accNo);

                Double balance = (Double) session.getAttribute("balance");

                System.out.println("balance at transfer servlet: " + balance);
                request.setAttribute("balance", balance);

                List<Translog> translogs = TranslogDB.getTranslogsByAccount(accNo);
                request.setAttribute("translogs", translogs);

                request.getRequestDispatcher("view/home.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("view/home.jsp?error=Invalid account number format");
            }
        } else {
            response.sendRedirect("view/home.jsp?error=Account number is required");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String accNoStr = request.getParameter("accNo");
            String task = request.getParameter("task");
            String amountStr = request.getParameter("amount");

            if (accNoStr == null || task == null || amountStr == null
                    || accNoStr.isEmpty() || task.isEmpty() || amountStr.isEmpty()) {
                response.sendRedirect("view/transaction.jsp?error=All fields are required");
                return;
            }

            int accNo = Integer.parseInt(accNoStr);
            double amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                response.sendRedirect("view/transaction.jsp?error=Amount must be greater than zero");
                return;
            }

            boolean success = false;

            if (task.equalsIgnoreCase("")) {
                return;
            } else {
                String receiverAccNoStr = request.getParameter("receiverAccNo");
                Integer receiverAccNo = (receiverAccNoStr != null && !receiverAccNoStr.isEmpty())
                        ? Integer.valueOf(receiverAccNoStr)
                        : null;

                if ("Transfer".equalsIgnoreCase(task) && receiverAccNo == null) {
                    response.sendRedirect("view/transaction.jsp?error=Receiver account number is required for transfers");
                    return;
                }
                success = TranslogDB.processTransaction(accNo, task, amount, receiverAccNo);
                if (success) {
                    Double newBalance = TranslogDB.getBalance(accNo);
                    HttpSession session = request.getSession();
                    session.setAttribute("balance", newBalance);
                }
            }

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>alert('" + (success ? "Transaction successful" : "Transaction failed")
                    + "'); window.location='view/home.jsp';</script>");

        } catch (NumberFormatException e) {
            response.getWriter().write("<script>alert('Invalid input format'); window.location='view/transaction.jsp';</script>");
        } catch (IOException e) {
            response.getWriter().write("<script>alert('An error occurred: " + e.getMessage() + "'); window.location='view/transaction.jsp';</script>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling transactions";
    }
}
