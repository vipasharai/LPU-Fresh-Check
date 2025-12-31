package com.lpu.servlets;

import com.lpu.common.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get user ID (if null, redirect to login)
        if(session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("id");
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
        String paymentMethod = request.getParameter("paymentMethod");

        if(cart == null || cart.isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }

        // Generate Random OTP
        int otp = 1000 + new Random().nextInt(9000);
        
        try {
            Connection con = DBConnection.getConnection();
            
            // Assume single vendor order for simplicity (taking vendor ID from first item)
            int vendorId = Integer.parseInt(cart.get(0).get("vendorId"));
            double totalAmount = 0;
            
            // Calculate Total
            for(Map<String, String> m : cart) {
                totalAmount += Double.parseDouble(m.get("price")) * Integer.parseInt(m.get("qty"));
            }

            // 1. Insert into Orders Table
            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO orders(user_id, vendor_id, total_amount, payment_method, otp, order_status) VALUES(?,?,?,?,?, 'Pending')", 
                Statement.RETURN_GENERATED_KEYS
            );
            pst.setInt(1, userId);
            pst.setInt(2, vendorId);
            pst.setDouble(3, totalAmount);
            pst.setString(4, paymentMethod);
            pst.setString(5, String.valueOf(otp));
            pst.executeUpdate();
            
            // Get the generated Order ID
            ResultSet rs = pst.getGeneratedKeys();
            int orderId = 0;
            if(rs.next()) orderId = rs.getInt(1);

            // 2. Insert into Order Items Table
            PreparedStatement pstItem = con.prepareStatement("INSERT INTO order_items(order_id, item_name, quantity, price) VALUES(?,?,?,?)");
            for(Map<String, String> item : cart) {
                pstItem.setInt(1, orderId);
                pstItem.setString(2, item.get("name"));
                pstItem.setInt(3, Integer.parseInt(item.get("qty")));
                pstItem.setDouble(4, Double.parseDouble(item.get("price")));
                pstItem.addBatch();
            }
            pstItem.executeBatch();
            
            // Success: Clear cart and save OTP in session
            session.removeAttribute("cart");
            session.setAttribute("lastOtp", otp);
            response.sendRedirect("order_success.jsp");
            
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}