<%-- 
    Document   : EditPost
    Created on : Jun 10, 2025, 4:47:25 PM
    Author     : FAQIHAH
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    int postId = Integer.parseInt(request.getParameter("id"));
    String title = "", category = "", content = "", imagePath = "";
    boolean postFound = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/skinpairs_db", "qyy", "");

        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM discussion_posts WHERE id = ?");
        stmt.setInt(1, postId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            category = rs.getString("category");
            content = rs.getString("content");
            imagePath = rs.getString("image_path");
            postFound = true;
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String statusMsg = (String) session.getAttribute("statusMsg");
    session.removeAttribute("statusMsg");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Post</title>
    <style>
        body { font-family: Helvetica; background: #fff; padding: 30px; }
        .form-container { max-width: 600px; margin: auto; background: #fefefe; padding: 20px; border-radius: 10px; border: 2px solid #e9d7c0; }
        input, textarea, select { width: 100%; padding: 10px; margin-top: 10px; font-size: 16px; }
        button { background: #987d61; color: white; padding: 10px 20px; margin-top: 20px; border: none; border-radius: 5px; }
        .status-msg { background-color: #dff0d8; padding: 10px; border-radius: 5px; margin-bottom: 10px; color: #3c763d; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit Discussion Post</h2>

    <% if (statusMsg != null) { %>
        <div class="status-msg"><%= statusMsg %></div>
    <% } %>

    <% if (postFound) { %>
    <form action="EditPostServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= postId %>">

        <label>Title</label>
        <input type="text" name="title" value="<%= title %>" required>

        <label>Category</label>
        <select name="category" required>
            <option value="General" <%= category.equals("General") ? "selected" : "" %>>General</option>
            <option value="Oily Skin" <%= category.equals("Oily Skin") ? "selected" : "" %>>Oily Skin</option>
            <option value="Dry Skin" <%= category.equals("Dry Skin") ? "selected" : "" %>>Dry Skin</option>
            <option value="Product Recommendation" <%= category.equals("Product Recommendation") ? "selected" : "" %>>Product Recommendation</option>
            <option value="Ingredient Discussion" <%= category.equals("Ingredient Discussion") ? "selected" : "" %>>Ingredient Discussion</option>
        </select>

        <label>Content</label>
        <textarea name="content" required><%= content %></textarea>

        <label>Change Image (optional)</label>
        <input type="file" name="image">

        <% if (imagePath != null && !imagePath.isEmpty()) { %>
            <p>Current Image:</p>
            <img src="<%= imagePath %>" style="max-width: 100%; height: auto;">
        <% } %>

        <button type="submit">Update Post</button>
    </form>
    <% } else { %>
        <p style="color: red;">Post not found.</p>
    <% } %>
</div>

</body>
</html>

