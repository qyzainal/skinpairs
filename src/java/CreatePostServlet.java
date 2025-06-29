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

@WebServlet("/CreatePostServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String content = request.getParameter("content");

        Part imagePart = request.getPart("image");
        InputStream imageStream = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            imageStream = imagePart.getInputStream(); // ✅ image as stream
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.initializeDatabase();

            String sql = "INSERT INTO discussion_posts (title, category, content, image_blob) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, category);
            stmt.setString(3, content);

            if (imageStream != null) {
                stmt.setBlob(4, imageStream); // ✅ store as blob
            } else {
                stmt.setNull(4, java.sql.Types.BLOB);
            }

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        response.sendRedirect("ManagePost.jsp");
    }
}
