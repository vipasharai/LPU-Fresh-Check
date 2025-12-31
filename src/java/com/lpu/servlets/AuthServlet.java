package com.lpu.servlets;

import com.lpu.common.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("loginType"); // 'user' or 'vendor'
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        HttpSession session = request.getSession();

        try {
            Connection con = DBConnection.getConnection();
            
            if(type.equals("vendor")) {
                // Vendor Login Logic
                PreparedStatement pst = con.prepareStatement("SELECT * FROM vendors WHERE username=? AND password=?");
                pst.setString(1, u);
                pst.setString(2, p);
                ResultSet rs = pst.executeQuery();
                
                if(rs.next()) {
                    session.setAttribute("userType", "VENDOR");
                    session.setAttribute("id", rs.getInt("vendor_id"));
                    session.setAttribute("name", rs.getString("shop_name"));
                    response.sendRedirect("vendor_dashboard.jsp");
                    return;
                }
            } else {
                // Customer or Admin Login Logic
                PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE reg_id=? AND password=?");
                pst.setString(1, u);
                pst.setString(2, p);
                ResultSet rs = pst.executeQuery();
                
                if(rs.next()) {
                    String role = rs.getString("role");
                    session.setAttribute("userType", role);
                    session.setAttribute("id", rs.getInt("user_id"));
                    session.setAttribute("name", rs.getString("full_name"));
                    
                    if(role.equals("ADMIN")) {
                        response.sendRedirect("admin_dashboard.jsp");
                    } else {
                        response.sendRedirect("home.jsp");
                    }
                    return;
                }
            }
            // If login fails
            response.sendRedirect("login.jsp?error=invalid");
            con.close();
        } catch(IOException | SQLException e) {
        }
    }
}