package com.lpu.servlets;

import com.lpu.common.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "VendorActionServlet", urlPatterns = {"/VendorActionServlet"})
public class VendorActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if(session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int vendorId = (int) session.getAttribute("id");

        try {
            try (Connection con = DBConnection.getConnection()) {
                if(action.equals("addMenu")) {
                    // Add new food item
                    String name = request.getParameter("name");
                    String price = request.getParameter("price");
                    String img = request.getParameter("image");
                    
                    PreparedStatement pst = con.prepareStatement("INSERT INTO menu_items(item_name, price, image_url, vendor_id) VALUES(?,?,?,?)");
                    pst.setString(1, name);
                    pst.setString(2, price);
                    pst.setString(3, img);
                    pst.setInt(4, vendorId);
                    pst.executeUpdate();
                    response.sendRedirect("vendor_dashboard.jsp");
                }
                else if(action.equals("verifyOtp")) {
                    // Verify OTP for delivery
                    String oid = request.getParameter("orderId");
                    String otp = request.getParameter("otp");
                    
                    PreparedStatement pst = con.prepareStatement("UPDATE orders SET order_status='Delivered' WHERE order_id=? AND otp=? AND vendor_id=?");
                    pst.setString(1, oid);
                    pst.setString(2, otp);
                    pst.setInt(3, vendorId);
                    
                    int row = pst.executeUpdate();
                    if(row > 0) {
                        response.sendRedirect("vendor_dashboard.jsp?msg=success");
                    } else {
                        response.sendRedirect("vendor_dashboard.jsp?msg=invalid_otp");
                    }
                }
            }
        } catch(IOException | SQLException e) {
        }
    }
}