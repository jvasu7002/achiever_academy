package achiever_web;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbconnection {

    private static final String URL =
    "jdbc:mysql://root:QARknIFvzLRUMKLPMVykpOXdWfOvxTiu@switchyard.proxy.rlwy.net:44721/railway";

    private static final String USER = "root";
    private static final String PASSWORD = "QARknIFvzLRUMKLPMVykpOXdWfOvxTiu";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database connected successfully!");
            return conn;
        } catch (Exception e) {
            System.out.println("❌ DB Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}