package servlets;

import utils.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/HomepageServlet")
public class HomepageServlet extends HttpServlet {

    // You can make this dynamic later per user!
    private static final Set<String> PREFERRED_INGREDIENTS = new HashSet<>(Arrays.asList(
        "niacinamide", "hyaluronic acid", "ceramide", "zinc", "aloe vera"
    ));

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String skinType = (String) session.getAttribute("skinType");

        System.out.println("DEBUG: Skin Type from session = " + skinType);

        List<Map<String, Object>> recommendedProducts = new ArrayList<>();

        if (skinType != null && !skinType.isEmpty()) {
            try (Connection conn = DBConnection.initializeDatabase()) {
                String sql = "SELECT Brand, Product_Name, Product_Type, Ingredients FROM skinpairs WHERE LOWER(skin_type) = LOWER(?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, skinType);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("brand", rs.getString("Brand"));
                    product.put("name", rs.getString("Product_Name"));
                    product.put("type", rs.getString("Product_Type"));

                    // Ingredient parsing + match calculation
                    String ingredientStr = rs.getString("Ingredients");
                    double match = calculateMatchPercentage(ingredientStr);
                    product.put("matchPercentage", String.format("%.0f", match)); // Round to int for display

                    recommendedProducts.add(product);
                }

                
                Collections.shuffle(recommendedProducts);
                if (recommendedProducts.size() > 7) {
                    recommendedProducts = recommendedProducts.subList(0, 7);
                }

                System.out.println("DEBUG: Number of recommended products = " + recommendedProducts.size());

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("DEBUG: No skin type found in session.");
        }

        request.setAttribute("recommendedProducts", recommendedProducts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Homepage.jsp");
        dispatcher.forward(request, response);
    }

    private double calculateMatchPercentage(String ingredientString) {
        if (ingredientString == null || ingredientString.isEmpty()) return 0.0;

        String[] ingredients = ingredientString.split(",");
        int matchCount = 0;

        for (String ing : ingredients) {
            String cleaned = ing.trim().toLowerCase();
            if (PREFERRED_INGREDIENTS.contains(cleaned)) {
                matchCount++;
            }
        }

        return (matchCount * 100.0) / PREFERRED_INGREDIENTS.size(); // e.g. 3/5 = 60%
    }
}
