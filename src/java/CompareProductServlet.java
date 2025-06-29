/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CompareProductServlet")
public class CompareProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String product1 = request.getParameter("product1");
        String product2 = request.getParameter("product2");

        try {
            Connection connection = DBConnection.initializeDatabase();

            String query = "SELECT * FROM skinpairs WHERE Product_Name = ?";
            PreparedStatement statement1 = connection.prepareStatement(query);
            statement1.setString(1, product1);
            ResultSet resultSet1 = statement1.executeQuery();

            PreparedStatement statement2 = connection.prepareStatement(query);
            statement2.setString(1, product2);
            ResultSet resultSet2 = statement2.executeQuery();

            if (resultSet1.next() && resultSet2.next()) {
                request.setAttribute("product1_name", resultSet1.getString("Product_Name"));
                request.setAttribute("product1_ingredients", resultSet1.getString("Ingredients"));
                request.setAttribute("product1_benefits", resultSet1.getString("Good_for"));

                request.setAttribute("product2_name", resultSet2.getString("Product_Name"));
                request.setAttribute("product2_ingredients", resultSet2.getString("Ingredients"));
                request.setAttribute("product2_benefits", resultSet2.getString("Good_for"));
            } else {
                request.setAttribute("errorMessage", "One or both products could not be found.");
            }

            connection.close();
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("Compare_Result.jsp").forward(request, response);
    }
}