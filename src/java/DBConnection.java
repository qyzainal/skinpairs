/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author FAQIHAH
 */

package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection initializeDatabase() throws Exception {
        
        String dbURL = "jdbc:mysql://localhost:3306/skinpairs_db";
        String username = "qyy";
        String password = "";

        
        Class.forName("com.mysql.cj.jdbc.Driver");

        
        Connection connection = DriverManager.getConnection(dbURL, username, password);

       
        connection.setAutoCommit(true);

     
        System.out.println("Database connected successfully to: " + dbURL);

        return connection;
    }
}
