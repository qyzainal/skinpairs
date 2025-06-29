package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

import utils.DBConnection;

@WebServlet("/DisplayImageServlet")
public class DisplayImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int postId;
        try {
            postId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image ID.");
            return;
        }

        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement stmt = conn.prepareStatement("SELECT image_blob FROM discussion_posts WHERE id = ?")) {

            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    byte[] imageData = rs.getBytes("image_blob");
                    if (imageData != null && imageData.length > 0) {
                        response.setContentType("image/jpeg");
                        response.getOutputStream().write(imageData);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "No image found for this post.");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        }
    }
}
