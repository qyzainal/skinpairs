import java.io.*;
import java.nio.file.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/EditPostServlet")
@MultipartConfig
public class EditPostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String content = request.getParameter("content");

        Part imagePart = request.getPart("image");
        String imagePath = "";

        String dbURL = "jdbc:mysql://localhost:3306/skinpairs_db";
        String dbUser = "qyy";
        String dbPass = "";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            String sql;
            PreparedStatement stmt;

            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String filePath = uploadPath + File.separator + fileName;
                imagePart.write(filePath);

                imagePath = "uploads/" + fileName;

                sql = "UPDATE discussion_posts SET title = ?, category = ?, content = ?, image_path = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, category);
                stmt.setString(3, content);
                stmt.setString(4, imagePath);
                stmt.setInt(5, id);
            } else {
                sql = "UPDATE discussion_posts SET title = ?, category = ?, content = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, category);
                stmt.setString(3, content);
                stmt.setInt(4, id);
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                session.setAttribute("statusMsg", "Post updated successfully.");
            } else {
                session.setAttribute("statusMsg", "Post update failed. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("statusMsg", "Error occurred during update.");
        }

        response.sendRedirect("EditPost.jsp?id=" + id);
    }
}

