<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Transfer Money</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                text-align: center;
            }
            .yourBalance{
                position: absolute;
                top: 30px;
                left: 24px;
                background-color: #454adc;
                padding: 8px 10px;
                border-radius: 8px;
                color: white;
            }
            .container {
                max-width: 400px;
                margin: 50px auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                color: #007bff;
            }
            .alert {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 5px;
            }
            .alert-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            label {
                font-weight: bold;
                display: block;
                margin: 10px 0 5px;
                text-align: left;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            select {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: 2px solid #007bff;
                border-radius: 5px;
                background-color: #fff;
                color: #333;
                appearance: none;
                cursor: pointer;

                margin-bottom: 20px;
            }


            select:hover {
                border-color: #0056b3;
            }

            select option {
                padding: 10px;
                font-size: 16px;
            }

            select option:disabled {
                color: #aaa;
            }

            select {
                background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23007bff'><path d='M7 10l5 5 5-5H7z'/></svg>");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px;
            }

            button {
                background-color: #007bff;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }
            button:hover {
                background-color: #0056b3;
            }
            .back-btn {
                margin-top: 10px;
                background: #6c757d;
            }
            .back-btn:hover {
                background: #5a6268;
            }
            .footer {
                margin-top: 15px;
                font-size: 14px;
                color: #666;
            }
        </style>
    </head>
    <body>
        <%
           
            Double balance = (Double) session.getAttribute("balance");
        %>
        <div class="yourBalance">Your account balance: <%= (balance != null) ? balance : "Not Available" %> USD</div>
        <div class="container">
            <h2>Transfer Money</h2>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${param.message}</div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">${param.error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/TransferServlet" method="post">
                <label for="accNo">Your Account Number:</label>
                <input type="text" id="accNo" name="accNo" required>

                <label for="receiverAccNo">Receiver Account Number:</label>
                <input type="text" id="receiverAccNo" name="receiverAccNo" required>

                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" required min="1">

                <label for="task">Select Transaction Type:</label>
                <select id="task" name="task" required>
                    <option value="" disabled selected>-- Select Transaction Type --</option>
                    <option value="Withdraw">Withdraw</option>
                    <option value="Deposit">Deposit</option>
                </select>

                <button type="submit">Transfer</button>
            </form>
            <button class="back-btn" onclick="window.location.href = '<%= request.getContextPath()%>/view/home.jsp'">Back to Home</button>

            <div class="footer">&copy; 2025 Your Company</div>
        </div>

    </body>
</html>
