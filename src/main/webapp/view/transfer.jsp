<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #1a1a1a;
            color: #e0e0e0;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .yourBalance {
            position: absolute;
            top: 20px;
            left: 20px;
            background: #3a3a9f;
            padding: 10px 15px;
            border-radius: 20px;
            font-size: 16px;
            font-weight: 500;
        }

        .container {
            max-width: 450px;
            width: 100%;
            background: #2b2b2b;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
        }

        h2 {
            color: #6b6bff;
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 14px;
        }

        .alert-success {
            background: #2e4d3a;
            color: #a3e6b8;
            border: 1px solid #3a664d;
        }

        .alert-danger {
            background: #4d2e2e;
            color: #e6a3a3;
            border: 1px solid #663a3a;
        }

        label {
            font-weight: 500;
            display: block;
            margin: 10px 0 5px;
            color: #a0a0ff;
            text-align: left;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #444;
            border-radius: 5px;
            background: #333333;
            color: #e0e0e0;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #6b6bff;
            outline: none;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%236b6bff'><path d='M7 10l5 5 5-5H7z'/></svg>");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
        }

        select:hover {
            border-color: #3a3a9f;
        }

        button {
            background: linear-gradient(135deg, #6b6bff, #3a3a9f);
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        button:hover {
            background: linear-gradient(135deg, #3a3a9f, #6b6bff);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(107, 107, 255, 0.3);
        }

        .back-btn {
            background: #444;
            margin-top: 15px;
        }

        .back-btn:hover {
            background: #555;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(85, 85, 85, 0.3);
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: #888;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        Double balance = (Double) session.getAttribute("balance");
        Integer accNo = (Integer) session.getAttribute("accNo");
    %>
    <div class="yourBalance">Your account balance: <%= (balance != null) ? balance : "Not Available" %> USD</div>
    <div class="container">
        <h2>Transaction</h2>
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">${param.message}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/TransferServlet" method="post">
            <label for="accNo">Your Account Number:</label>
            <input type="text" id="accNo" name="accNo" value="<%= (accNo != null) ? accNo : "" %>" readonly>

            <label for="receiverAccNo">Receiver Account Number:</label>
            <input type="text" id="receiverAccNo" name="receiverAccNo">

            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" required min="1" step="0.01">

            <label for="task">Select Transaction Type:</label>
            <select id="task" name="task" required onchange="toggleReceiverField()">
                <option value="" disabled selected>-- Select Transaction Type --</option>
                <option value="Withdraw">Withdraw</option>
                <option value="Transfer">Transfer</option>
            </select>

            <button type="submit">Submit</button>
        </form>
        <button class="back-btn" onclick="window.location.href = '<%= request.getContextPath()%>/view/home.jsp'">Back to Home</button>

        <div class="footer">© 2025 Your Company</div>
    </div>

    <script>
        function toggleReceiverField() {
            var task = document.getElementById("task").value;
            var receiverInput = document.getElementById("receiverAccNo");
            if (task === "Transfer") {
                receiverInput.style.display = "block";
                receiverInput.setAttribute("required", "true");
            } else {
                receiverInput.style.display = "block";
                receiverInput.removeAttribute("required");
            }
        }
    </script>
</body>
</html>