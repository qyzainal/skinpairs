/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/skinpairs_db";
    private static final String DB_USER = "qyy";
    private static final String DB_PASSWORD = "";

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT Product_Name, Brand FROM skinpairs";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("Product_Name");
                String brand = rs.getString("Brand");

                // Fake match logic (for demo purposes, e.g. random % between 80–100)
                double matchPercentage = 80 + Math.random() * 20;

                Product product = new Product(name, brand, matchPercentage);
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}
