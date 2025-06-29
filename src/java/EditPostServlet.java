package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import utils.DBConnection;

@WebServlet("/EditPostServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class EditPostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        int postId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String content = request.getParameter("content");

        Part imagePart = request.getPart("image");
        InputStream imageStream = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            imageStream = imagePart.getInputStream(); // New image uploaded
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.initializeDatabase();

            String sql;
            if (imageStream != null) {
                // ✅ Update title, category, content, and image_blob
                sql = "UPDATE discussion_posts SET title = ?, category = ?, content = ?, image_blob = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, category);
                stmt.setString(3, content);
                stmt.setBlob(4, imageStream);
                stmt.setInt(5, postId);
            } else {
                // ✅ Update only text data
                sql = "UPDATE discussion_posts SET title = ?, category = ?, content = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, category);
                stmt.setString(3, content);
                stmt.setInt(4, postId);
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                session.setAttribute("statusMsg", "Post updated successfully.");
            } else {
                session.setAttribute("statusMsg", "Update failed. Post not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("statusMsg", "An error occurred during update.");
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        response.sendRedirect("EditPost.jsp?id=" + postId);
    }
}
