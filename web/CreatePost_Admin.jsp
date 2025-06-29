<%-- 
    Document   : CreatePost_Admin
    Created on : Jun 7, 2025, 2:21:42 PM
    Author     : FAQIHAH
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Create New Discussion</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            color: #000000;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #ecc3a5;
            display: flex;
            justify-content: space-between;
            padding: 10px 30px;
            font-family: Monaco;
        }

        .navbar a {
            color: #000;
            text-decoration: none;
            font-size: 18px;
            margin-left: 15px;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fefefe;
            border: 5px solid #e9d7c0;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: #000000;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 20px;
            margin-bottom: 5px;
            color: #987d61;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        textarea {
            resize: vertical;
            height: 150px;
        }

        button {
            margin-top: 20px;
            padding: 12px 20px;
            background-color: #987d61;
            color: white;
            border: none;
            font-weight: bold;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            position: center;
        }

        button:hover {
            background-color: #2b1819;
        }

        footer {
            background-color: #ecc3a5;
            text-align: center;
            padding: 15px;
            color: #000;
            border-top: 5px solid #e9d7c0;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <a href="AdminDashboard.jsp">Dashboard</a>
        <a href="ManagePost.jsp">Manage Posts</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="container">
        <h2>Create New Discussion Post</h2>
       <form action="CreatePostServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="brandID" value="0">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" placeholder="Enter discussion title..." required>

            <label for="category">Category</label>
            <select id="category" name="category">
                <option value="General">General</option>
                <option value="Oily Skin">Oily Skin</option>
                <option value="Dry Skin">Dry Skin</option>
                <option value="Product Recommendation">Product Recommendation</option>
                <option value="Ingredient Discussion">Ingredient Discussion</option>
            </select>

            <label for="content">Content</label>
            <textarea id="content" name="content" placeholder="Write your post here..." required></textarea>
            
            <label for="image">Upload Image</label>
            <input type="file" id="image" name="image" accept="image/*">

            <button type="submit">Publish</button>
            
            <% String msg = request.getParameter("msg"); %>
<% if (msg != null) { %>
    <p style="color: <%= msg.equals("success") ? "green" : "red" %>;">
        <%= msg.equals("success") ? "Post created successfully!" : "Error: " + msg %>
    </p>
<% } %>

        </form>
    </div>

    <footer>
        &copy; 2025 SKINPAIRS | Admin Panel
    </footer>

</body>
</html>

