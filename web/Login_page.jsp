<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        /* General Styling */
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
        }

        .header-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        /* Header/Navbar Styling */
        .navbar {
            background-color: #ecc3a5;
            display: flex;
            justify-content: space-around;
            padding: 10px 0;
        }

        .navbar a {
            color: #000;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 20px;
            text-align: center;
        }

        .navbar a:hover {
            background-color: #e6f0f2;
        }

        /* Content Styling */
        .content-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .content-wrapper {
            display: flex;
            align-items: center;
            gap: 50px;
        }

        .logo-wrapper {
            text-align: center;
        }

        h1 {
            margin: 0;
            font-size: 40px;
            font-weight: bold;
        }

        img.logo {
            width: 190px;
            height: auto;
            margin-top: 20px;
            border: 5px solid #000000;
            border-radius: 8px;
        }

        .login-box {
            width: 400px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px 30px;
            text-align: center;
        }

        .tabs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .tab {
            flex: 1;
            padding: 10px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            border: none;
            background-color: #e6f0f2;
            color: #333;
            transition: background-color 0.3s;
        }

        .tab:hover {
            background-color: #ddd;
        }

        .tab.active {
            background-color: #ecc3a5;
            color: #000000;
            border-radius: 5px;
        }

        .form-section {
            display: none;
        }

        .form-section.active {
            display: block;
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 14px;
            font-weight: bold;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .forgot-password {
            text-align: right;
            margin-top: -10px;
            margin-bottom: 15px;
        }

        .forgot-password a {
            color: #0073e6;
            font-size: 12px;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #987d61;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #e6f0f2;
            color: #000000;
        }

        .register-button {
            margin-top: 10px; 
            background-color: #ecc3a5;
            color: #000000;
        }

        .register-button:hover {
            background-color: #987d61;
            color: #ffffff;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }

        footer {
            background-color: #ecc3a5;
            color: #000000;
            text-align: center;
            padding: 15px 0;
            border-top: 3px solid #e9d7c0;
        }
    </style>
</head>
<body>
    <img src="image/skincare13.png" alt="Header Image" class="header-image">

    
    <div class="content-container">
        <div class="content-wrapper">
            <!-- Logo and Title -->
            <div class="logo-wrapper">
                <h1>SKINPAIRS</h1>
                <img src="image/SKIN.png" alt="Product Analyzer Logo" class="logo">
            </div>

            
            <div class="login-box">
                <!-- Tabs -->
                <div class="tabs">
                    <div class="tab active" onclick="showTab('user')">User</div>
                    <div class="tab" onclick="showTab('admin')">Admin</div>
                </div>

                <!-- User Form -->
                <div class="form-section user-form active">
                    <form action="LoginServlet" method="POST">
                        <div class="form-group">
                            <label for="user-username">Username:</label>
                            <input type="text" name="username" id="user-username" placeholder="Enter username" required>
                        </div>
                        <div class="form-group">
                            <label for="user-password">Password:</label>
                            <input type="password" name="password" id="user-password" placeholder="Enter password" required>
                        </div>
                        <input type="hidden" name="role" value="user">

                        
                        <div class="error-message">
                            <% if (session.getAttribute("error") != null) { %>
                                <%= session.getAttribute("error") %>
                                <% session.removeAttribute("error"); %>
                            <% } %>
                        </div>

                        <div class="forgot-password">
                            <a href="#">Forgot password?</a>
                        </div>

                        <button type="submit">LOG IN</button>
                        <a href="register_user.jsp">
                            <button type="button" class="register-button">REGISTER</button>
                        </a>
                    </form>
                </div>

                
                <div class="form-section admin-form">
                    <form action="LoginServlet" method="POST">
                        <div class="form-group">
                            <label for="admin-username">Username:</label>
                            <input type="text" name="username" id="admin-username" placeholder="Enter admin username" required>
                        </div>
                        <div class="form-group">
                            <label for="admin-password">Password:</label>
                            <input type="password" name="password" id="admin-password" placeholder="Enter admin password" required>
                        </div>
                        <input type="hidden" name="role" value="admin">

                        <!-- Display error messages -->
                        <div class="error-message">
                            <% if (session.getAttribute("error") != null) { %>
                                <%= session.getAttribute("error") %>
                                <% session.removeAttribute("error"); %>
                            <% } %>
                        </div>

                        <div class="forgot-password">
                            <a href="#">Forgot password?</a>
                        </div>

                        <button type="submit">LOG IN</button>
                        <a href="register_user.jsp">
                            <button type="button" class="register-button">REGISTER</button>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    
    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>

    <script>
        function showTab(tab) {
           
            document.querySelectorAll('.tab').forEach(function(tabElement) {
                tabElement.classList.remove('active');
            });
           
            event.target.classList.add('active');

            
            document.querySelectorAll('.form-section').forEach(function(section) {
                section.classList.remove('active');
            });

            
            document.querySelector('.' + tab + '-form').classList.add('active');
        }
    </script>
</body>
</html>
