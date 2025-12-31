package com.lpu.servlets;

import com.lpu.common.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AdminActionServlet", urlPatterns = {"/AdminActionServlet"})
public class AdminActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Admin creating new vendor
        String name = request.getParameter("shopName");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String img = request.getParameter("image");
        String desc = request.getParameter("desc");

        try {
            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement pst = con.prepareStatement("INSERT INTO vendors(shop_name, username, password, image_url, description) VALUES(?,?,?,?,?)");
                pst.setString(1, name);
                pst.setString(2, user);
                pst.setString(3, pass);
                pst.setString(4, img);
                pst.setString(5, desc);
                pst.executeUpdate();
                response.sendRedirect("admin_dashboard.jsp?msg=added");
            }
        } catch(IOException | SQLException e) {
        }
    }
}