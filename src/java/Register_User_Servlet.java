import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBConnection;

@WebServlet("/Register_User_Servlet")
public class Register_User_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection connection = DBConnection.initializeDatabase()) {
            // Check if the username or email already exists
            String checkQuery = "SELECT * FROM skinpairs_user WHERE username = ? OR email = ?";
            PreparedStatement checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // If a record exists, show an error message
                request.setAttribute("errorMessage", "Username or Email already exists. Please choose a different one.");
                request.getRequestDispatcher("register_user.jsp").forward(request, response);
            } else {
                // If no record exists, insert the new user
                String insertQuery = "INSERT INTO skinpairs_user (username, email, password) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
                insertStmt.setString(1, username);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password); // Ensure password is hashed if hashing is implemented

                int rowsInserted = insertStmt.executeUpdate();

                if (rowsInserted > 0) {
                    response.sendRedirect("Login_page.jsp?message=Registration successful. Please log in.");
                } else {
                    request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    request.getRequestDispatcher("register_user.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("register_user.jsp").forward(request, response);
        }
    }
}
