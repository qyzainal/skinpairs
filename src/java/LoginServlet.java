package servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            String hashedPassword = hashPassword(password);

            // Use alias "id" for both adminID and userID
            String query;
            if ("admin".equals(role)) {
                query = "SELECT adminID AS id FROM skinpairs_admin WHERE username = ? AND password = ?";
            } else if ("user".equals(role)) {
                query = "SELECT userID AS id, skin_type FROM skinpairs_user WHERE username = ? AND password = ?";
            } else {
                response.sendRedirect("Login_page.jsp?error=Invalid role");
                return;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/skinpairs_db", "qyy", "");
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setString(1, username);
                stmt.setString(2, hashedPassword);

                try (ResultSet rs = stmt.executeQuery()) {
                    HttpSession session = request.getSession();

                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        session.setAttribute("user_id", userId);
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        if ("admin".equals(role)) {
                            session.setAttribute("adminAccess", true);
                            response.sendRedirect("AdminDashboard.jsp");
                        } else {
                            session.setAttribute("adminAccess", false);

                            String skinType = rs.getString("skin_type");
                            if (skinType == null || skinType.isEmpty()) {
                                response.sendRedirect("skin_quiz.jsp"); // First-time user
                            } else {
                                session.setAttribute("skinType", skinType);
                                response.sendRedirect("HomepageServlet");
                            }
                        }

                    } else {
                        session.setAttribute("error", "Invalid username or password.");
                        response.sendRedirect("Login_page.jsp");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Login failed due to an internal error.", e);
        }
    }

    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes());

        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
