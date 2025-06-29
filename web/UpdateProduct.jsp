<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
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

        /* Header Styling */
        .header-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

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
        .container {
            flex: 1;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #ecc3a5;
            border-radius: 8px 8px 0 0;
            padding: 15px;
            color: #000;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }

        .card-body {
            padding: 20px;
        }

        .form-label {
            font-size: 16px;
            font-weight: bold;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            font-family: Arial, sans-serif;
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

        footer {
            background-color: #ecc3a5;
            color: #000000;
            text-align: center;
            padding: 15px 0;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <img src="image/skincare13.png" alt="Header Image" class="header-image">

    <div class="container">
        <h1 class="text-center">Update Product</h1>

        <%
            String productBrand = request.getParameter("productBrand");
            String productName = request.getParameter("productName");

            Connection connection = null;
            String ingredients = "";
            String benefits = "";

            try {
                connection = utils.DBConnection.initializeDatabase();
                String query = "SELECT * FROM skinpairs WHERE Brand = ? AND Product_Name = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, productBrand);
                statement.setString(2, productName);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    ingredients = resultSet.getString("Ingredients");
                    benefits = resultSet.getString("Good_for");
                } else {
                    out.println("<div class='alert alert-danger text-center'>Product not found!</div>");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (connection != null) {
                    connection.close();
                }
            }
        %>

        <div class="card mt-4">
            <div class="card-header">
                Update Product Details
            </div>
            <div class="card-body">
                <form action="AdminProductServlet" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="originalBrand" value="<%= productBrand %>">
                    <input type="hidden" name="originalName" value="<%= productName %>">

                    <div class="mb-3">
                        <label for="productBrand" class="form-label">Product Brand</label>
                        <input type="text" class="form-control" id="productBrand" name="productBrand" value="<%= productBrand %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="productName" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="productName" value="<%= productName %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="ingredients" class="form-label">Ingredients</label>
                        <textarea class="form-control" id="ingredients" name="ingredients" rows="3" required><%= ingredients %></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="benefits" class="form-label">Benefits</label>
                        <textarea class="form-control" id="benefits" name="benefits" rows="3" required><%= benefits %></textarea>
                    </div>
                    <button type="submit">Update Product</button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</body>
</html>
