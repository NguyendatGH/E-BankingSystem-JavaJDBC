<%-- 
    Document   : updateProfile.jsp
    Created on : Mar 13, 2025, 7:37:43 PM
    Author     : rio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Profile</title>
    <script>
        function validateForm() {
            var form = document.forms["updateInforForm"];
            var email = form["email"].value;
            var phoneNo = form["tel"].value; // Sửa phoneNo thành tel để khớp với name trong form

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

        function removePhoto() {
            document.getElementById("photo").value = "";
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
            padding: 0; /* Đã có padding từ container */
            border-radius: 5px;
        }

        label {
            display: block;
            font-weight: 500;
            margin: 10px 0 5px;
            color: #a0a0ff;
        }

        input[type="text"],
        input[type="file"] {
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
        input[type="file"]:focus {
            border-color: #6b6bff;
            outline: none;
        }

        input[type="file"] {
            padding: 8px; /* Điều chỉnh padding cho file input */
        }

        button,
        #submit {
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

        button:hover,
        #submit:hover {
            background: linear-gradient(135deg, #3a3a9f, #6b6bff);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(107, 107, 255, 0.3);
        }

        button {
            background: #444; /* Nút Remove Photo dùng màu khác */
        }

        button:hover {
            background: #555;
            box-shadow: 0 4px 10px rgba(85, 85, 85, 0.3);
        }

        p.error {
            color: #e6a3a3;
            font-weight: 500;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Profile</h1>

        <form name="updateInforForm" action="${pageContext.request.contextPath}/UpdateServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="custNo" value="${Customer.custNo}">
            <label>First Name:</label>
            <input type="text" name="fname" value="${Customer.custFname}">
            <label>Last Name:</label>
            <input type="text" name="lname" value="${Customer.custLname}">
            <label>Email:</label>
            <input type="text" name="email" value="${Customer.email}" required>
            <label>Phone:</label>
            <input type="text" name="tel" value="${Customer.tel}" required>
            <label>Address:</label>
            <input type="text" name="address" value="${Customer.address}" required>
            <label>Photo (optional):</label>
            <input type="file" name="photo" id="photo">
            <button type="button" onclick="removePhoto()">Remove Photo</button>
            <input type="submit" value="Update" id="submit">
        </form>
        <p class="error">${errStr}</p>
    </div>
</body>
</html>