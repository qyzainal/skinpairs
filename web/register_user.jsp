<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Account</title>
    <style>
      
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            color: #000000;
            display: flex;
            flex-direction: column;
        }

        .header-image {
            width: 100%;
            height: 15%;
            object-fit: cover;
            border-bottom: 5px solid #e9d7c0;
        }

        .container {
            width: 500px;
            margin: 20px auto; 
            background-color: #ecc3a5;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: 5px solid #e9d7c0;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        h2 {
            text-align: center;
            color: #987d61;
            margin-bottom: 20px;
            font-size: 24px;
        }

        label {
            display: block;
            font-size: 16px;
            color: #987d61;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            font-size: 14px;
            margin-bottom: 15px;
            border: 1px solid #987d61;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-primary {
            width: 100%;
            padding: 10px 15px;
            font-size: 16px;
            color: #ffffff;
            background-color: #987d61;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #2b1819;
        }

        .alert {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 14px;
            text-align: center;
        }

        .alert-danger {
            background-color: #e6f0f2;
            color: #987d61;
            border: 1px solid #987d61;
        }

        footer {
            background-color: #ecc3a5;
            color: #000000;
            text-align: center;
            padding: 10px 0;
            border-top: 3px solid #e9d7c0;
            margin-top: 20px;
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
  
    <img src="image/skincare13.png" alt="Header Image" class="header-image">

    
    <div class="container">
        <h2>Create New Account</h2>

        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="Register_User_Servlet" method="post" onsubmit="return validateForm();">
           
            <div>
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>
           
            <div>
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            
            <div>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            
            <div>
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" placeholder="Re-enter your password" required>
            </div>
            
            <div>
                <button type="submit" class="btn-primary">Register</button>
            </div>
        </form>
    </div>

    
    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</body>
</html>
