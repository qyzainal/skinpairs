
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/SaveFavouriteIngredientsServlet")
public class SaveFavouriteIngredientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // IMPORTANT: get userID from session (set during login)
        Integer userId = (Integer) session.getAttribute("userID"); 

        if (userId == null) {
            // User not logged in, redirect or handle
            session.setAttribute("statusMsg", "Please login first.");
            response.sendRedirect("Login_page.jsp");
            return;
        }

        // Get selected ingredients (max 10 enforced by frontend)
        String[] ingredients = request.getParameterValues("ingredients");

        if (ingredients == null || ingredients.length == 0) {
            session.setAttribute("statusMsg", "Please select at least one ingredient.");
            response.sendRedirect("ChooseFavouriteIngredients.jsp");
            return;
        }

        // Combine into comma-separated string
        String ingredientsStr = String.join(",", ingredients);

        try (Connection conn = utils.DBConnection.initializeDatabase()) {
            String sql = "UPDATE skinpairs_user SET user_fave_ingredients = ? WHERE userID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, ingredientsStr);
            stmt.setInt(2, userId);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("statusMsg", "Favourite ingredients saved successfully!");
            } else {
                session.setAttribute("statusMsg", "Failed to save favourite ingredients. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("statusMsg", "Error occurred while saving: " + e.getMessage());
        }

        // Redirect to dashboard or any page you want
        response.sendRedirect("SkinTypeResult.jsp");
    }
}
