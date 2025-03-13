<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <script src="scripts.js"></script>
    <script>
        function validateForm() {
            var form = document.forms["registrationForm"];
            var balance = form["initialBalance"].value;
            var email = form["email"].value;
            var phoneNo = form["phoneNo"].value;

            // Validate Initial Balance
            if (balance < 0) {
                alert("Initial balance cannot be negative.");
                return false;
            }

            // Validate Email
            if (!email.endsWith("@gmail.com")) {
                alert("Email must end with @gmail.com.");
                return false;
            }

            // Validate Phone Number (numeric only)
            if (!/^\d+$/.test(phoneNo)) {
                alert("Phone number must contain only digits.");
                return false;
            }

            return true;
        }
        
        function removePhoto(){
            document.getElementById("photo").value = "";
        }
    </script>
</head>
<body>
    <h1>Register New Account</h1>
    <form name="registrationForm" action="${pageContext.request.contextPath}/RegistrationServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
        ID No: <input type="number" name="idNo" required><br>
        First Name: <input type="text" name="firstName" required><br>
        Last Name: <input type="text" name="lastName" required><br>
        Phone No: <input type="text" name="phoneNo" required><br>
        Email: <input type="email" name="email" required><br>
        Address: <textarea name="address" required></textarea><br>
        Initial Balance: <input type="number" name="initialBalance" step="0.01" min="0" required><br>
        Password: <input type="password" name="password" required><br>
        Photo (optional): <input type="file" name="photo" id="photo"><br>
        <button type="button" onclick="removePhoto()">Remove Photo</button><br>
        
        <button type="submit">Register</button>
    </form>
</body>
</html>
