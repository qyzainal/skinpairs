

/**
 *
 * @author FAQIHAH
 */

package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection initializeDatabase() throws Exception {
        // Read from environment variables (Render → Environment tab)
        String dbURL = System.getenv("DB_URL");
        String username = System.getenv("DB_USER");
        String password = System.getenv("DB_PASS");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbURL, username, password);

        connection.setAutoCommit(true);

        System.out.println("Database connected successfully to: " + dbURL);
        return connection;
    }
}

