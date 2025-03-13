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
        <title>JSP Page</title>
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
    </head>
    <body>
        <div style="display: flex; flex-direction: column">

            <form action="${pageContext.request.contextPath}/Login" method="post">
                <h3>login page</h3>
                <label> username: </label>
                <input type="text" name="accNo" id="accNo" required/>
                <br/>
                <label> password: </label>
                <input type="password" name="password" id="password" required/>
                <br/>
                <input type="checkbox" name="rememberMe"/>
                <label> remember me</label>
                <br/>

                <button type="submit">Login</button>
            </form>

            <a href="<%= request.getContextPath()%>/view/register.jsp">Don't have an account?</a>

            <%
                String errMessage = (String) request.getAttribute("errorMessage");
                if (errMessage != null) {
            %>
            <p style="color: red;"><%= errMessage%></p>
            <%
                }
            %>
        </div>
    </body>
</html>
<% 
session.removeAttribute("registeredAccNo");
session.removeAttribute("registeredPassword");
%>