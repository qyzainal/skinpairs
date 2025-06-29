/*
 * Document   : AdminProductServlet.java
    Created on : Jan 3, 2025, 9:33:09 PM
    Author     : FAQIHAH
 * 
 */

package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            connection = utils.DBConnection.initializeDatabase();

            if ("add".equals(action)) {
                String productBrand = request.getParameter("productBrand");
                String productName = request.getParameter("productName");
                String ingredients = request.getParameter("ingredients");
                String benefits = request.getParameter("benefits");

                String query = "INSERT INTO skinpairs (Brand, Product_Name, Ingredients, Good_for) VALUES (?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, productBrand);
                statement.setString(2, productName);
                statement.setString(3, ingredients);
                statement.setString(4, benefits);

                int rowsInserted = statement.executeUpdate();
                statement.close();

                if (rowsInserted > 0) {
                    // Log activity
                    PreparedStatement logStmt = connection.prepareStatement(
                        "INSERT INTO activity_log (activity_type, description) VALUES (?, ?)"
                    );
                    logStmt.setString(1, "product");
                    logStmt.setString(2, "Added product: " + productBrand + " - " + productName);
                    logStmt.executeUpdate();
                    logStmt.close();

                    response.getWriter().write("Product added successfully. Rows Inserted: " + rowsInserted);
                } else {
                    response.getWriter().write("Failed to add product.");
                }

            } else if ("update".equals(action)) {
                String originalBrand = request.getParameter("originalBrand");
                String originalName = request.getParameter("originalName");
                String productBrand = request.getParameter("productBrand");
                String productName = request.getParameter("productName");
                String ingredients = request.getParameter("ingredients");
                String benefits = request.getParameter("benefits");

                String query = "UPDATE skinpairs SET Brand = ?, Product_Name = ?, Ingredients = ?, Good_for = ? WHERE Brand = ? AND Product_Name = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, productBrand);
                statement.setString(2, productName);
                statement.setString(3, ingredients);
                statement.setString(4, benefits);
                statement.setString(5, originalBrand);
                statement.setString(6, originalName);

                int rowsUpdated = statement.executeUpdate();
                statement.close();

                if (rowsUpdated > 0) {
                    // Log activity
                    PreparedStatement logStmt = connection.prepareStatement(
                        "INSERT INTO activity_log (activity_type, description) VALUES (?, ?)"
                    );
                    logStmt.setString(1, "product");
                    logStmt.setString(2, "Updated product: " + originalBrand + " - " + originalName + " → " + productBrand + " - " + productName);
                    logStmt.executeUpdate();
                    logStmt.close();

                    response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Product updated successfully", "UTF-8"));
                } else {
                    response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Failed to update product", "UTF-8"));
                }

            } else if ("delete".equals(action)) {
                String productBrand = request.getParameter("productBrand");
                String productName = request.getParameter("productName");

                String query = "DELETE FROM skinpairs WHERE Brand = ? AND Product_Name = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, productBrand);
                statement.setString(2, productName);

                int rowsDeleted = statement.executeUpdate();
                statement.close();

                if (rowsDeleted > 0) {
                    // Log activity
                    PreparedStatement logStmt = connection.prepareStatement(
                        "INSERT INTO activity_log (activity_type, description) VALUES (?, ?)"
                    );
                    logStmt.setString(1, "product");
                    logStmt.setString(2, "Deleted product: " + productBrand + " - " + productName);
                    logStmt.executeUpdate();
                    logStmt.close();

                    response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Product deleted successfully", "UTF-8"));
                } else {
                    response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Failed to delete product", "UTF-8"));
                }

            } else {
                response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Invalid action specified", "UTF-8"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin.jsp?message=" + java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}

