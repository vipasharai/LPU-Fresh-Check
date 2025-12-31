package com.lpu.common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            // 1. Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Create Connection
            // NOTE: Database name is 'lpu_food_db'
            // 'root' is username, '123' is password (Change '123' to YOUR Workbench Password)
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lpu_food_db", "root", "Sahu@12345");
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Connection Failed! Check Console for errors.");
        }
        return con;
    }

    // ✅ Main method to TEST connection immediately (Right click file -> Run File)
    public static void main(String[] args) {
        Connection c = getConnection();
        if (c != null) {
            System.out.println("✅ SUCCESS: Database Connected Successfully!");
        } else {
            System.out.println("❌ FAILURE: Could not connect.");
        }
    }
}