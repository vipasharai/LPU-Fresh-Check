package com.lpu.servlets;

import com.lpu.common.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "RateOrderServlet", urlPatterns = {"/RateOrderServlet"})
public class RateOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        int vendorId = Integer.parseInt(request.getParameter("vendorId"));

        try {
            Connection con = DBConnection.getConnection();
            
            // 1. Update Order with Rating
            PreparedStatement pst = con.prepareStatement("UPDATE orders SET rating = ? WHERE order_id = ?");
            pst.setInt(1, rating);
            pst.setInt(2, orderId);
            pst.executeUpdate();

            // 2. Calculate New Average for Vendor
            PreparedStatement avgPst = con.prepareStatement(
                "SELECT AVG(rating) FROM orders WHERE vendor_id = ? AND rating > 0"
            );
            avgPst.setInt(1, vendorId);
            ResultSet rs = avgPst.executeQuery();
            if(rs.next()) {
                double newAvg = rs.getDouble(1);
                // 3. Update Vendor Table
                PreparedStatement upVen = con.prepareStatement("UPDATE vendors SET avg_rating = ? WHERE vendor_id = ?");
                upVen.setDouble(1, newAvg);
                upVen.setInt(2, vendorId);
                upVen.executeUpdate();
            }
            
            response.sendRedirect("my_orders.jsp");
            con.close();
        } catch(Exception e) { e.printStackTrace(); }
    }
}