<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Registration</title>
        <script>
            function validateForm() {
                var form = document.forms["registrationForm"];
                var balance = form["initialBalance"].value;
                var email = form["email"].value;
                var phoneNo = form["phoneNo"].value;

                if (balance < 0) {
                    alert("Initial balance cannot be negative.");
                    return false;
                }

                if (!email.endsWith("@gmail.com")) {
                    alert("Email must end with @gmail.com.");
                    return false;
                }

                if (!/^\d+$/.test(phoneNo)) {
                    alert("Phone number must contain only digits.");
                    return false;
                }

                return true;
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
                max-width: 500px;
                width: 100%;
                background: #2b2b2b;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            }

            h1 {
                color: #6b6bff;
                text-align: center;
                font-size: 24px;
                margin-bottom: 20px;
            }

            form {
                background: #2b2b2b;
                padding: 0;
            }

            label {
                display: block;
                font-weight: 500;
                margin: 10px 0 5px;
                color: #a0a0ff;
            }

            input[type="number"],
            input[type="text"],
            input[type="email"],
            input[type="password"],
            textarea {
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

            input[type="number"]:focus,
            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="password"]:focus,
            textarea:focus {
                border-color: #6b6bff;
                outline: none;
            }

            textarea {
                height: 80px;
                resize: vertical;
            }

            .file-input-wrapper {
                position: relative;
                margin-bottom: 15px;
            }

            input[type="file"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #444;
                border-radius: 5px;
                background: #333333;
                color: #e0e0e0;
                font-size: 16px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }

            input[type="file"]:focus {
                border-color: #6b6bff;
                outline: none;
            }

            button[type="submit"] {
                background: linear-gradient(135deg, #6b6bff, #3a3a9f);
                color: #fff;
                padding: 12px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 500;
                margin-top: 10px;
                transition: all 0.3s ease;
            }

            button[type="submit"]:hover {
                background: linear-gradient(135deg, #3a3a9f, #6b6bff);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(107, 107, 255, 0.3);
            }


        </style>
    </head>
    <body>
        <div class="container">
            <h1>Register New Account</h1>
            <form name="registrationForm" action="${pageContext.request.contextPath}/RegistrationServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <label>ID No:</label>
                <input type="number" name="idNo" required>
                <label>First Name:</label>
                <input type="text" name="firstName" required>
                <label>Last Name:</label>
                <input type="text" name="lastName" required>
                <label>Phone No:</label>
                <input type="text" name="phoneNo" required>
                <label>Email:</label>
                <input type="email" name="email" required>
                <label>Address:</label>
                <textarea name="address" required></textarea>
                <label>Initial Balance:</label>
                <input type="number" name="initialBalance" step="0.01" min="0" required>
                <label>Password:</label>
                <input type="password" name="password" required>
                <label>Photo (optional):</label>
                <div class="file-input-wrapper">
                    <input type="file" name="photo" id="photo">
                </div>  

                <button type="submit">
                    <span>Register</span>
                </button>
            </form>
        </div>
    </body>
</html>