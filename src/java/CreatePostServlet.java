package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/CreatePostServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class CreatePostServlet extends HttpServlet {

    // Consistent save directory outside webapp
    private static final String SAVE_DIR = "C:/skinpairs_uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String content = request.getParameter("content");

        Part imagePart = request.getPart("image");
        String imagePath = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = new File(imagePart.getSubmittedFileName()).getName();

            // Ensure save directory exists
            File saveDir = new File(SAVE_DIR);
            if (!saveDir.exists()) {
                saveDir.mkdirs();
            }

            File savedFile = new File(SAVE_DIR, fileName);
            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, savedFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }

            imagePath = fileName; // Only store the file name in the DB
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/skinpairs_db", "qyy", "");

            String sql = "INSERT INTO discussion_posts (title, category, content, image_path) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, category);
            stmt.setString(3, content);
            stmt.setString(4, imagePath); // just the file name, e.g. "image1.jpg"

            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ManagePost.jsp");
    }
}
