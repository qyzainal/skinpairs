<%-- 
    Document   : ManagePost
    Created on : Jun 7, 2025, 2:38:02 PM
    Author     : FAQIHAH
--%>

<!-- STEP 1: Use a servlet to serve uploaded images from safe disk location -->

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="utils.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Posts - Admin</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
            background-color: #fffaf6;
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
            max-width: 1000px;
            margin: 50px auto;
            padding: 10px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .post-card {
            background-color: #ffffff;
            border: 3px solid #e9d7c0;
            border-radius: 10px;
            padding: 15px;
            box-sizing: border-box;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .post-card img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .post-title {
            font-size: 16px;
            font-weight: bold;
            color: #2b1819;
        }

        .post-category {
            font-size: 13px;
            color: #7c5a47;
            margin: 5px 0 10px 0;
        }

        .post-content {
            font-size: 13px;
            color: #333333;
            margin-bottom: 10px;
            flex-grow: 1;
        }

        .post-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 6px 10px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-preview { background-color: #987d61; color: white; }
        .btn-edit { background-color: #5a7d7c; color: white; }
        .btn-delete { background-color: #a94442; color: white; }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
        }

        .modal-content {
            background: white;
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            position: relative;
        }

        .modal-close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 18px;
            cursor: pointer;
            color: #555;
        }

        footer {
            background-color: #ecc3a5;
            text-align: center;
            padding: 15px;
            color: #000;
            border-top: 5px solid #e9d7c0;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="CreatePost_Admin.jsp">Create Post</a>
    <a href="LogoutServlet">Logout</a>
</div>

<div class="container">
    <h2>All Discussion Posts</h2>
    <div class="grid">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.initializeDatabase();
                String sql = "SELECT * FROM discussion_posts ORDER BY created_at DESC";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int postId = rs.getInt("id");
                    String title = rs.getString("title");
                    String category = rs.getString("category");
                    String content = rs.getString("content");
                    String imagePath = rs.getString("image_path");
        %>
        <div class="post-card">
            <% if (imagePath != null && !imagePath.isEmpty()) { %>
                <img src="ImageServlet?path=<%= imagePath %>" alt="Post Image">
            <% } %>
            <div class="post-title"><%= title %></div>
            <div class="post-category">Category: <%= category %></div>
            <div class="post-content"><%= content.length() > 100 ? content.substring(0, 100) + "..." : content %></div>
            <div class="post-actions">
                <button class="btn btn-preview" onclick="showPreview('<%= title.replace("'", "\\'") %>', '<%= content.replace("'", "\\'").replaceAll("[\r\n]+", "\\\\n") %>')">Preview</button>
                <a class="btn btn-edit" href="EditPost.jsp?id=<%= postId %>">Edit</a>
                <button class="btn btn-delete" onclick="confirmDelete(<%= postId %>)">Delete</button>
            </div>
        </div>
        <% 
                } // end while
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        %>
    </div>
</div>

<!-- Preview Modal -->
<div class="modal" id="previewModal">
    <div class="modal-content">
        <span class="modal-close" onclick="closePreview()">×</span>
        <h3 id="modalTitle"></h3>
        <p id="modalContent"></p>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteModal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeDelete()">×</span>
        <h4>Are you sure you want to delete this post?</h4>
        <form id="deleteForm" method="post" action="DeletePostServlet">
            <input type="hidden" name="postId" id="deletePostId">
            <button class="btn btn-delete" type="submit">Yes, Delete</button>
            <button class="btn" type="button" onclick="closeDelete()">Cancel</button>
        </form>
    </div>
</div>

<footer>
    &copy; 2025 SKINPAIRS | Admin Panel
</footer>

<script>
    function showPreview(title, content) {
        document.getElementById("modalTitle").innerText = title;
        document.getElementById("modalContent").innerText = content.replace(/\\n/g, '\n');
        document.getElementById("previewModal").style.display = "block";
    }

    function closePreview() {
        document.getElementById("previewModal").style.display = "none";
    }

    function confirmDelete(postId) {
        document.getElementById("deletePostId").value = postId;
        document.getElementById("deleteModal").style.display = "block";
    }

    function closeDelete() {
        document.getElementById("deleteModal").style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target.classList.contains("modal")) {
            closePreview();
            closeDelete();
        }
    };
</script>

</body>
</html>
