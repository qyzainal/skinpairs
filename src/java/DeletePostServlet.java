package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import utils.DBConnection; // ✅ Import your DB connection class

@WebServlet("/DeletePostServlet")
public class DeletePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int postId = Integer.parseInt(request.getParameter("postId"));
        HttpSession session = request.getSession();

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // ✅ Use centralized DB connection method
            conn = DBConnection.initializeDatabase();

            String sql = "DELETE FROM discussion_posts WHERE id = ?";
            stmt = conn.prepareStatement(sql);
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
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        response.sendRedirect("ManagePost.jsp");
    }
}
