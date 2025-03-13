<%-- 
    Document   : login
    Created on : Mar 2, 2025, 5:06:21 PM
    Author     : rio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script>
        window.onload = function () {
            const accNo = "<%= session.getAttribute("registeredAccNo") != null ? session.getAttribute("registeredAccNo") : ""%>";
            const password = "<%= session.getAttribute("registeredPassword") != null ? session.getAttribute("registeredPassword") : ""%>";

            if (accNo && password) {
                alert("Registration Successful!\nYour Account Number: " + accNo + "\nYour Password: " + password);
                document.getElementById("accNo").value = accNo;
                document.getElementById("password").value = password;
            }
        };
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
            max-width: 400px;
            width: 100%;
            background: #2b2b2b;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        h3 {
            color: #6b6bff;
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 500;
            margin: 10px 0 5px;
            color: #a0a0ff;
            text-align: left;
        }

        input[type="text"],
        input[type="password"] {
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

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #6b6bff;
            outline: none;
        }

        input[type="checkbox"] {
            margin-right: 5px;
            vertical-align: middle;
        }

        .checkbox-label {
            font-size: 14px;
            color: #e0e0e0;
            display: inline-block;
            margin-bottom: 15px;
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

        a {
            display: block;
            color: #6b6bff;
            text-decoration: none;
            margin-top: 15px;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #a0a0ff;
        }

        p.error {
            color: #e6a3a3;
            font-weight: 500;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="${pageContext.request.contextPath}/Login" method="post">
            <h3>Login</h3>
            <label>Username:</label>
            <input type="text" name="accNo" id="accNo" required>
            <label>Password:</label>
            <input type="password" name="password" id="password" required>
            <div>
                <input type="checkbox" name="rememberMe" id="rememberMe">
                <label for="rememberMe" class="checkbox-label">Remember me</label>
            </div>
            <button type="submit">Login</button>
        </form>
        <a href="<%= request.getContextPath()%>/view/register.jsp">Don't have an account?</a>
        <%
            String errMessage = (String) request.getAttribute("errorMessage");
            if (errMessage != null) {
        %>
        <p class="error"><%= errMessage%></p>
        <%
            }
        %>
    </div>
<% 
    session.removeAttribute("registeredAccNo");
    session.removeAttribute("registeredPassword");
%>
</body>
</html>