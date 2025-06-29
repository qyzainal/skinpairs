package servlets;

import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ProductAnalyzerServlet")
public class ProductAnalyzerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productName = request.getParameter("productName");

        try {
            Connection connection = DBConnection.initializeDatabase();
            String query = "SELECT * FROM skinpairs WHERE Product_Name = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, productName);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                request.setAttribute("productName", resultSet.getString("Product_Name"));
                request.setAttribute("ingredients", resultSet.getString("Ingredients"));
                request.setAttribute("benefits", resultSet.getString("Good_for"));
            } else {
                request.setAttribute("errorMessage", "The product you entered is not in our database.");
            }

            connection.close();
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("Product_Analysis.jsp").forward(request, response);
    }
}