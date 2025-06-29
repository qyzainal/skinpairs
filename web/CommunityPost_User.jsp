<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Community Discussions</title>
    <style>
        body { font-family: Helvetica, Arial, sans-serif; background-color: #fffaf6; margin: 0; padding: 0; }
        .container { max-width: 1000px; margin: 50px auto; padding: 10px; }
        .post-card { background-color: #ffffff; border: 2px solid #e9d7c0; border-radius: 10px; padding: 20px; margin-bottom: 30px; }
        .post-card img { width: 100%; max-height: 300px; object-fit: cover; border-radius: 10px; }
        .post-title { font-size: 20px; font-weight: bold; margin: 15px 0 5px 0; }
        .post-category { color: #7c5a47; margin-bottom: 10px; }
        .post-content { margin-bottom: 20px; }
        .comments { margin-top: 15px; background-color: #f4ede4; padding: 15px; border-radius: 10px; }
        .comment { border-bottom: 1px solid #d4bfa9; padding: 8px 0; }
        .comment:last-child { border-bottom: none; }
        .comment-form textarea {
            width: 100%; height: 60px; resize: vertical; padding: 8px;
            border-radius: 5px; border: 1px solid #c2a78e;
        }
        .comment-form button {
            background-color: #987d61; color: white; border: none;
            padding: 8px 15px; border-radius: 5px; margin-top: 10px; cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Community Discussions</h2>

<%
    Connection conn = null;
    PreparedStatement postStmt = null;
    ResultSet postRs = null;

    try {
        conn = utils.DBConnection.initializeDatabase(); // Reuse your utility

        String postSql = "SELECT * FROM discussion_posts ORDER BY created_at DESC";
        postStmt = conn.prepareStatement(postSql);
        postRs = postStmt.executeQuery();

        while (postRs.next()) {
            int postId = postRs.getInt("id");
            String title = postRs.getString("title");
            String category = postRs.getString("category");
            String content = postRs.getString("content");
            String imagePath = postRs.getString("image_path");
%>

    <div class="post-card">
        <% if (imagePath != null && !imagePath.isEmpty()) { %>
            <img src="<%= request.getContextPath() %>/uploaded_images/<%= new java.io.File(imagePath).getName() %>" alt="Post Image">
        <% } %>
        <div class="post-title"><%= title %></div>
        <div class="post-category">Category: <%= category %></div>
        <div class="post-content"><%= content %></div>

        <div class="comments">
            <h4>Discussion</h4>
            <%
                PreparedStatement commentStmt = conn.prepareStatement("SELECT * FROM post_comments WHERE post_id = ? ORDER BY commented_at ASC");
                commentStmt.setInt(1, postId);
                ResultSet commentRs = commentStmt.executeQuery();
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm a");

                while (commentRs.next()) {
                    String commenter = commentRs.getString("username");
                    String commentText = commentRs.getString("comment_text");
                    Timestamp commentTime = commentRs.getTimestamp("commented_at");
                    String formattedTime = (commentTime != null) ? sdf.format(commentTime) : "Unknown time";
            %>
            <div class="comment">
                <strong><%= commenter %>:</strong>
                <span style="color:gray; font-size:12px;">• <%= formattedTime %></span><br>
                <%= commentText %>
            </div>
            <%
                }
                commentRs.close();
                commentStmt.close();
            %>

            <form class="comment-form" method="post" action="AddCommentServlet">
                <input type="hidden" name="postId" value="<%= postId %>">
                <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
                <textarea name="comment_text" placeholder="Write your comment here..." required></textarea>
                <button type="submit">Post Comment</button>
            </form>
        </div>
    </div>

<%
        } // end while
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (postRs != null) postRs.close();
        if (postStmt != null) postStmt.close();
        if (conn != null) conn.close();
    }
%>
</div>
</body>
</html>
