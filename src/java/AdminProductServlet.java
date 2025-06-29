package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import utils.DBConnection; // ✅ Ensures the DBConnection is imported

@WebServlet("/AdminProductServlet")
public class AdminProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        Connection connection = null;

        try {
            // ✅ Uses shared connection method
            connection = DBConnection.initializeDatabase();

            switch (action) {
                case "add":
                    handleAdd(request, response, connection);
                    break;

                case "update":
                    handleUpdate(request, response, connection);
                    break;

                case "delete":
                    handleDelete(request, response, connection);
                    break;

                default:
                    response.sendRedirect("Admin.jsp?message=" +
                        java.net.URLEncoder.encode("Invalid action specified", "UTF-8"));
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin.jsp?message=" +
                java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, Connection connection)
            throws Exception {

        String productBrand = request.getParameter("productBrand");
        String productName = request.getParameter("productName");
        String ingredients = request.getParameter("ingredients");
        String benefits = request.getParameter("benefits");

        String query = "INSERT INTO skinpairs (Brand, Product_Name, Ingredients, Good_for) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, productBrand);
            stmt.setString(2, productName);
            stmt.setString(3, ingredients);
            stmt.setString(4, benefits);
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                logActivity(connection, "product", "Added product: " + productBrand + " - " + productName);
                response.getWriter().write("Product added successfully. Rows Inserted: " + rowsInserted);
            } else {
                response.getWriter().write("Failed to add product.");
            }
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, Connection connection)
            throws Exception {

        String originalBrand = request.getParameter("originalBrand");
        String originalName = request.getParameter("originalName");
        String productBrand = request.getParameter("productBrand");
        String productName = request.getParameter("productName");
        String ingredients = request.getParameter("ingredients");
        String benefits = request.getParameter("benefits");

        String query = "UPDATE skinpairs SET Brand = ?, Product_Name = ?, Ingredients = ?, Good_for = ? " +
                       "WHERE Brand = ? AND Product_Name = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, productBrand);
            stmt.setString(2, productName);
            stmt.setString(3, ingredients);
            stmt.setString(4, benefits);
            stmt.setString(5, originalBrand);
            stmt.setString(6, originalName);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                logActivity(connection, "product", "Updated product: " +
                    originalBrand + " - " + originalName + " → " +
                    productBrand + " - " + productName);
                response.sendRedirect("Admin.jsp?message=" +
                    java.net.URLEncoder.encode("Product updated successfully", "UTF-8"));
            } else {
                response.sendRedirect("Admin.jsp?message=" +
                    java.net.URLEncoder.encode("Failed to update product", "UTF-8"));
            }
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, Connection connection)
            throws Exception {

        String productBrand = request.getParameter("productBrand");
        String productName = request.getParameter("productName");

        String query = "DELETE FROM skinpairs WHERE Brand = ? AND Product_Name = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, productBrand);
            stmt.setString(2, productName);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                logActivity(connection, "product", "Deleted product: " + productBrand + " - " + productName);
                response.sendRedirect("Admin.jsp?message=" +
                    java.net.URLEncoder.encode("Product deleted successfully", "UTF-8"));
            } else {
                response.sendRedirect("Admin.jsp?message=" +
                    java.net.URLEncoder.encode("Failed to delete product", "UTF-8"));
            }
        }
    }

    private void logActivity(Connection conn, String type, String description) throws Exception {
        String logSql = "INSERT INTO activity_log (activity_type, description) VALUES (?, ?)";
        try (PreparedStatement logStmt = conn.prepareStatement(logSql)) {
            logStmt.setString(1, type);
            logStmt.setString(2, description);
            logStmt.executeUpdate();
        }
    }
}
