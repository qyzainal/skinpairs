package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import utils.DBConnection;

@WebServlet("/ProductSuggestionServlet")
public class ProductSuggestionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        ArrayList<String> suggestions = new ArrayList<>();

        if (query == null || query.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().print("[]");
            return;
        }

        try (
            Connection conn = DBConnection.initializeDatabase();
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT Product_Name FROM skinpairs WHERE Product_Name LIKE ? LIMIT 10")
        ) {
            stmt.setString(1, "%" + query + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    suggestions.add(rs.getString("Product_Name"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            out.print("[\"" + String.join("\",\"", suggestions) + "\"]");
            out.flush();
        }
    }
}
