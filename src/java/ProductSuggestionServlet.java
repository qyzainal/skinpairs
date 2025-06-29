package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/ProductSuggestionServlet")
public class ProductSuggestionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        ArrayList<String> suggestions = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/skinpairs_db", "qyy", "");

            String sql = "SELECT Product_Name FROM skinpairs WHERE Product_Name LIKE ? LIMIT 10";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                suggestions.add(rs.getString("Product_Name"));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("[\"" + String.join("\",\"", suggestions) + "\"]");
        out.flush();
    }
}
