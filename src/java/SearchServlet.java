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

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("q");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        
        System.out.println("Query received: " + query);

        // Return empty JSON if query is null or empty
        if (query == null || query.trim().isEmpty()) {
            out.print("[]");
            return;
        }

        try (Connection conn = DBConnection.initializeDatabase()) {
            
            String sql = "SELECT Product_Name FROM skinpairs WHERE LOWER(Product_Name) LIKE LOWER(?) ORDER BY Product_Name ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");

            ResultSet rs = stmt.executeQuery();

            
            boolean first = true;
            while (rs.next()) {
                System.out.println("Found product: " + rs.getString("Product_Name"));
                if (!first) out.print(",");
                out.print("\"" + rs.getString("Product_Name").replace("\"", "\\\"") + "\"");
                first = false;
            }

            // If no products were found, return an empty array
            if (first) {
                out.print("[]");
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
