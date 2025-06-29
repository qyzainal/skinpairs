<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - SKINPAIRS</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Helvetica Neue', sans-serif;
            display: flex;
            height: 100vh;
            background-color: #fffaf6;
        }
        .sidebar {
            width: 240px;
            background-color: #ecc3a5;
            color: black;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .sidebar h2 {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }
        .sidebar ul a,
        .sidebar ul li {
            display: flex;
            align-items: center;
            padding: 10px 0;
            color: #000;
            text-decoration: none;
            transition: background 0.2s ease-in-out;
        }
        .sidebar ul a i,
        .sidebar ul li i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        .sidebar ul a:hover,
        .sidebar ul li:hover {
            background-color: #e4bfa3;
            border-radius: 5px;
        }
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .topbar {
            background-color: #fff;
            padding: 20px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .topbar input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .topbar .btn {
            background-color: #987d61;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            margin-left: 5px;
        }
        .container {
            padding: 20px;
            overflow-y: auto;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        form label {
            display: block;
            margin-bottom: 5px;
        }
        form input[type="text"],
        form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: vertical;
            margin-bottom: 15px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 10px;
            vertical-align: top;
            word-wrap: break-word;
        }
        .table th:nth-child(1), .table td:nth-child(1),
        .table th:nth-child(2), .table td:nth-child(2),
        .table th:nth-child(5), .table td:nth-child(5) {
            width: 10%;
            text-align: center;
        }
        .table th:nth-child(3), .table td:nth-child(3),
        .table th:nth-child(4), .table td:nth-child(4) {
            text-align: justify;
        }
        .actions button,
        .actions a {
            background: none;
            border: none;
            cursor: pointer;
            margin-right: 10px;
            font-size: 16px;
            color: #333;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        footer {
            text-align: center;
            padding: 15px;
            background-color: #ecc3a5;
            border-top: 2px solid #e9d7c0;
            font-size: 14px;
        }
            .sidebar ul a.active {
            background-color: #d8aa89;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h2>Admin Panel</h2>
        <ul>
            <a href="AdminDashboard.jsp"><i class="fas fa-home"></i>Dashboard</a>
            <a href="ManagePost.jsp" class="active"><i class="fas fa-clipboard"></i>Manage Posts</a>
            <li><i class="fas fa-bell"></i>Notifications</li>
            <li><i class="fas fa-cog"></i>Settings</li>
        </ul>
    </div>
    <div style="font-size: 12px; color: #5a3e2b;">
        &copy; 2025 SKINPAIRS<br>by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </div>
</div>
<div class="main-content">
    <div class="topbar">
        <input type="text" placeholder="Search products...">
        <div>
            
            <a href="LogoutServlet" class="btn">Logout</a>
        </div>
    </div>
    <div class="container">
        <div class="card" id="addForm">
            <h3>Add Product</h3>
            <form action="AdminProductServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <label>Product Brand:</label>
                <input type="text" name="productBrand" required>
                <label>Product Name:</label>
                <input type="text" name="productName" required>
                <label>Ingredients:</label>
                <textarea name="ingredients" rows="3" required></textarea>
                <label>Benefits:</label>
                <textarea name="benefits" rows="3" required></textarea>
                <button type="submit" class="btn">Add Product</button>
            </form>
        </div>

        <div class="card">
            <h3>Product List</h3>
            <table class="table">
                <thead>
                <tr>
                    <th>Brand</th>
                    <th>Name</th>
                    <th>Ingredients</th>
                    <th>Benefits</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% 
                    Connection connection = null;
                    int offset = request.getParameter("offset") != null ? Integer.parseInt(request.getParameter("offset")) : 0;
                    int limit = 10;
                    try {
                        connection = utils.DBConnection.initializeDatabase();
                        String query = "SELECT * FROM skinpairs ORDER BY created_at DESC LIMIT ? OFFSET ?";
                        PreparedStatement statement = connection.prepareStatement(query);
                        statement.setInt(1, limit);
                        statement.setInt(2, offset);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            String brand = resultSet.getString("Brand");
                            String name = resultSet.getString("Product_Name");
                            String ingredients = resultSet.getString("Ingredients");
                            String benefits = resultSet.getString("Good_for");
                %>
                <tr>
                    <td><%= brand %></td>
                    <td><%= name %></td>
                    <td><%= ingredients %></td>
                    <td><%= benefits %></td>
                    <td class="actions">
                        <form id="deleteForm_<%= brand %>_<%= name %>" action="AdminProductServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="productBrand" value="<%= brand %>">
                            <input type="hidden" name="productName" value="<%= name %>">
                            <button type="button" onclick="confirmDeletion('<%= brand %>', '<%= name %>', 'deleteForm_<%= brand %>_<%= name %>')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                        <a href="UpdateProduct.jsp?productBrand=<%= brand %>&productName=<%= name %>"><i class="fas fa-edit"></i></a>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (connection != null) connection.close();
                    }
                %>
                </tbody>
            </table>
            <div class="pagination">
                <a href="Admin.jsp?offset=<%= offset - limit >= 0 ? offset - limit : 0 %>" class="btn">Previous</a>
                <a href="Admin.jsp?offset=<%= offset + limit %>" class="btn">Next</a>
            </div>
        </div>
    </div>
    <footer>
        &copy; 2025 SKINPAIRS by Nurfaqihah Zahirah Bt Zainal Ariffin (S61005)
    </footer>
</div>
<script>
    function confirmDeletion(brand, name, formId) {
        if (confirm(`Are you sure you want to delete the product ${brand} - ${name}?`)) {
            document.getElementById(formId).submit();
        }
    }
</script>
</body>
</html>
