import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeletePostServlet")
public class DeletePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int postId = Integer.parseInt(request.getParameter("postId"));
        HttpSession session = request.getSession();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/skinpairs_db", "root", "your_password")) {
            String sql = "DELETE FROM discussion_posts WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                session.setAttribute("statusMsg", "Post deleted successfully.");
            } else {
                session.setAttribute("statusMsg", "Delete failed. Post not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("statusMsg", "An error occurred while deleting the post.");
        }

        response.sendRedirect("ManagePost.jsp");
    }
}
