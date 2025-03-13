<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <script>
            function logout() {
                fetch('<%= request.getContextPath()%>/Logout', {method: 'POST'})
                        .then(() => {
                            window.location.href = '<%= request.getContextPath()%>/view/login.jsp';
                        })
                        .catch(error => console.error('Logout failed:', error));
            }

            function transferMoney() {
                const accNo = '${accNo}';
                window.location.href = '<%= request.getContextPath()%>/view/transfer.jsp?accNo=' + accNo;
            }
        </script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
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
                max-width: 800px;
                margin: auto;
                background: #fff;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            .header {
                background: #007bff;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                border-radius: 8px 8px 0 0;
            }

            .customer-info h2 {
                color: #007bff;
            }

            .profile-photo {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                display: block;
                margin: 10px auto;
                border: 3px solid #007bff;
            }

            .actionArea {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }

            button {
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #0056b3;
            }

            .transaction-list {
                max-height: 200px;
                overflow-y: auto;
                border: 1px solid #ddd;
                padding: 10px;
                border-radius: 5px;
                background: #fafafa;
                margin-top: 20px;
            }

            .footer {
                text-align: center;
                padding: 10px;
                background: #007bff;
                color: white;
                margin-top: 20px;
                border-radius: 0 0 8px 8px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="header">Welcome to Home Page</div>

            <div class="customer-info">
                <h2>Customer Information</h2>
                <p><strong>Account Number:</strong> ${accNo}</p>
                <p><strong>First Name:</strong> ${Customer.custFname}</p>
                <p><strong>Last Name:</strong> ${Customer.custLname}</p>
                <p><strong>Email:</strong> ${Customer.email}</p>
                <p><strong>Phone:</strong> ${Customer.tel}</p>
                <p><strong>Address:</strong> ${Customer.address}</p>

                <c:choose>
                    <c:when test="${not empty Customer.photo}">
                        <img class="profile-photo" src="data:image/jpeg;base64,${Customer.photo}" alt="Profile Photo">
                    </c:when>
                    <c:otherwise>
                        <img class="profile-photo" src="<%= request.getContextPath()%>/asset/defaultImg.png" alt="Default Profile Photo">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="yourBalance">Your balance: ${balance} $</div>
            <div class="transaction-list">
                <h3>Transaction History</h3>
                <c:choose>
                    <c:when test="${not empty translogs}">
                        <ul>
                            <c:forEach var="log" items="${translogs}">
                                <li><strong>${log.transDate}</strong> - ${log.transType} - ${log.amount}USD</li>
                                    </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p>No transaction history available.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="actionArea">
                <button onClick="logout()">Logout</button>
                <button onclick="transferMoney()">Transfer Money</button>
            </div>

            <div class="footer">&copy; 2025 Your Company</div>
        </div>

        <%-- Hiển thị alert nếu có thông báo --%>
        <%
            String message = request.getParameter("message");
            if (message != null) {
        %>
        <script>alert("<%= message%>");</script>
        <%
            }
        %>

    </body>
</html>
