<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

            function updateProfile() {
                const custNo = '${custNo}';
                window.location.href = '<%= request.getContextPath()%>/view/updateProfile.jsp?custNo=' + custNo;
            }
        </script>
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

            .container {
                max-width: 900px;
                width: 100%;
                background: #2b2b2b;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
                overflow: hidden;
            }

            .header {
                background: linear-gradient(135deg, #3a3a9f, #6b6bff);
                color: #fff;
                padding: 20px;
                text-align: center;
                font-size: 28px;
                font-weight: 600;
                border-radius: 12px 12px 0 0;
                margin: -25px -25px 20px -25px;
            }

            .customer-info {
                width: 100%;
                text-align: left;
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: space-evenly;
            }

            .customer-info h2 {
                color: #6b6bff;
                font-size: 22px;
                margin-bottom: 15px;
            }

            .customer-info p {
                margin: 8px 0;
                font-size: 16px;
            }

            .customer-info p strong {
                color: #a0a0ff;
            }
            .user-wrapper{
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .profile-photo {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                margin: 15px auto;
                border: 4px solid #6b6bff;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .profile-photo:hover {
                transform: scale(1.05);
            }

            .yourBalance {
                background: #3a3a9f;
                padding: 10px 15px;
                border-radius: 20px;
                font-size: 16px;
                font-weight: 500;
                display: inline-block;
                margin: 10px auto;
            }

            .userAction {
                display: flex;
                flex-direction: column;
                align-items: right;
                gap: 20px;
            }
            .transaction-list {
                background: #333333;
                padding: 15px;
                border-radius: 8px;
                max-height: 250px;
                overflow-y: auto;
                margin-top: 20px;
                border: 1px solid #444;
            }

            .transaction-list h3 {
                color: #6b6bff;
                font-size: 18px;
                margin-bottom: 10px;
            }

            .transaction-list ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .transaction-list li {
                padding: 10px;
                border-bottom: 1px solid #444;
                font-size: 14px;
                transition: background 0.2s ease;
            }

            .transaction-list li:hover {
                background: #3a3a3a;
            }

            .transaction-list li strong {
                color: #fff;
            }



            button {
                background: linear-gradient(135deg, #6b6bff, #3a3a9f);
                color: #fff;
                padding: 12px 20px;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            button:hover {
                background: linear-gradient(135deg, #3a3a9f, #6b6bff);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(107, 107, 255, 0.3);
            }

            .footer {
                text-align: center;
                padding: 15px;
                background: #222;
                color: #888;
                font-size: 14px;
                margin: 20px -25px -25px -25px;
                border-radius: 0 0 12px 12px;
            }

            .transaction-list::-webkit-scrollbar {
                width: 8px;
            }

            .transaction-list::-webkit-scrollbar-track {
                background: #2b2b2b;
                border-radius: 4px;
            }

            .transaction-list::-webkit-scrollbar-thumb {
                background: #6b6bff;
                border-radius: 4px;
            }

            .transaction-list::-webkit-scrollbar-thumb:hover {
                background: #3a3a9f;
            }

            @media (max-width: 600px) {
                .actionArea {

                    gap: 10px;
                }
                .container {
                    padding: 15px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">Welcome to Home Page</div>
            <h2>Customer Information</h2>
            <div class="customer-info">
                <div class="user-wrapper">
                    <c:choose>
                        <c:when test="${not empty Customer.photo}">
                            <img class="profile-photo" src="HomeServlet?image=true" alt="Profile Photo">
                        </c:when>
                        <c:otherwise>
                            <img class="profile-photo" src="<%= request.getContextPath()%>/asset/defaultImg.png" alt="Default Profile Photo">
                        </c:otherwise>
                    </c:choose>   
                    <div class="yourBalance">Your Balance: ${balance} $</div>    
                </div>

                <div class="information"> 
                    <p><strong>Account Number:</strong> ${accNo}</p>
                    <p><strong>First Name:</strong> ${Customer.custFname}</p>
                    <p><strong>Last Name:</strong> ${Customer.custLname}</p>
                    <p><strong>Email:</strong> ${Customer.email}</p>
                    <p><strong>Phone:</strong> ${Customer.tel}</p>
                    <p><strong>Address:</strong> ${Customer.address}</p>
                </div>

                <div class="userAction">
                    <button onclick="updateProfile()">Update Profile</button>
                    <button onclick="transferMoney()">Transfer Money</button>
                    <button onclick="logout()">Logout</button>
                </div>
            </div>

            <div class="transaction-list">
                <h3>Transaction History</h3>
                <c:choose>
                    <c:when test="${not empty sessionScope.transactionList}">
                        <ul>
                            <c:forEach var="log" items="${sessionScope.transactionList}">
                                <li>
                                    <strong>${log.time}</strong> - ${log.task} - 
                                    <c:choose>
                                        <c:when test="${fn:toLowerCase(log.task) == 'deposit'}">+${log.amount}</c:when>
                                        <c:when test="${fn:toLowerCase(log.task) == 'withdraw'}">-${log.amount}</c:when>
                                        <c:otherwise>${log.amount}</c:otherwise>
                                    </c:choose> USD 
                                    (Balance: ${log.posBalance} USD)
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p>No transaction history available.</p>
                    </c:otherwise>
                </c:choose>
            </div>



            <div class="footer">© 2025 Your Company</div>
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