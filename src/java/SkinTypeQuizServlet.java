package servlets;

import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/SkinTypeQuizServlet")
public class SkinTypeQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("Login_page.jsp");
            return;
        }

        // ✅ Prevent re-submission if skin type is already saved
        try (Connection conn = DBConnection.initializeDatabase()) {
            String checkSql = "SELECT skin_type FROM skinpairs_user WHERE userID = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getString("skin_type") != null) {
                response.sendRedirect("Homepage.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Get quiz answers
        String q1 = request.getParameter("q1");
        String q2 = request.getParameter("q2");
        String q3 = request.getParameter("q3");
        String q4 = request.getParameter("q4");
        String q5 = request.getParameter("q5");
        String q6 = request.getParameter("q6");
        String q7 = request.getParameter("q7");

        String skinType = determineSkinType(q1, q2, q3, q4, q5, q6, q7);
        session.setAttribute("skinType", skinType);
        request.setAttribute("skinType", skinType);

     
        try (Connection conn = DBConnection.initializeDatabase()) {
            String updateSql = "UPDATE skinpairs_user SET skin_type = ? WHERE userID = ?";
            PreparedStatement stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, skinType);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();
            System.out.println("Updated skin_type for userID " + userId + ": " + rows + " row(s).");
        } catch (Exception e) {
            e.printStackTrace();
        }

       
        List<Map<String, String>> products = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT Brand, Product_Name, Ingredients, Good_for FROM skinpairs WHERE skin_type = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, skinType);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> product = new HashMap<>();
                product.put("brand", rs.getString("Brand"));
                product.put("name", rs.getString("Product_Name"));
                product.put("ingredients", rs.getString("Ingredients"));
                product.put("benefits", rs.getString("Good_for"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("recommendedProducts", products);
        request.getRequestDispatcher("SkinTypeResult.jsp").forward(request, response);
    }

    private String determineSkinType(String q1, String q2, String q3, String q4, String q5, String q6, String q7) {
        int oily = 0, dry = 0, normal = 0, combo = 0, acne = 0;

        String[] answers = {q1, q2, q3, q4, q5, q6, q7};
        for (String ans : answers) {
            if (ans == null) continue;
            switch (ans.toLowerCase()) {
                case "oily": oily++; break;
                case "dry": dry++; break;
                case "normal": normal++; break;
                case "combination": combo++; break;
                case "acne-prone": acne++; break;
            }
        }

        Map<String, Integer> counter = new HashMap<>();
        counter.put("Oily", oily);
        counter.put("Dry", dry);
        counter.put("Normal", normal);
        counter.put("Combination", combo);
        counter.put("Acne-prone", acne);

        return counter.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .get()
                .getKey();
    }
}
