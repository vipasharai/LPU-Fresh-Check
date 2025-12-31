<%@page import="java.sql.*, com.lpu.common.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .otp-box { font-size: 1.5rem; font-weight: bold; letter-spacing: 2px; color: #d9534f; border: 2px dashed #d9534f; padding: 5px 15px; display: inline-block; border-radius: 5px; }
        .star-rating input { display: none; }
        .star-rating label { font-size: 20px; color: #ddd; cursor: pointer; }
        .star-rating input:checked ~ label, .star-rating label:hover, .star-rating label:hover ~ label { color: #f0ad4e; }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-light bg-white shadow-sm p-3 mb-4">
        <div class="container">
            <a class="navbar-brand text-danger fw-bold" href="home.jsp">⬅ Back to Home</a>
            <span class="fw-bold">My Order History</span>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <%
                if(session.getAttribute("id") == null) { response.sendRedirect("login.jsp"); return; }
                int userId = (int) session.getAttribute("id");
                
                Connection con = DBConnection.getConnection();
                // Fetch orders with Vendor Name
                String sql = "SELECT o.*, v.shop_name, v.image_url FROM orders o JOIN vendors v ON o.vendor_id = v.vendor_id WHERE o.user_id = ? ORDER BY o.order_id DESC";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                
                while(rs.next()) {
                    String status = rs.getString("order_status");
                    boolean isDelivered = status.equals("Delivered");
                    int rating = rs.getInt("rating");
            %>
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title fw-bold text-dark"><%= rs.getString("shop_name") %></h5>
                            <span class="badge <%= isDelivered ? "bg-success" : "bg-warning text-dark" %>"><%= status %></span>
                        </div>
                        <p class="text-muted small mb-1">Order #<%= rs.getInt("order_id") %> | <%= rs.getString("order_date") %></p>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="text-dark">₹ <%= rs.getDouble("total_amount") %></h4>
                            
                            <% if(!isDelivered) { %>
                                <div class="text-center">
                                    <small class="text-muted">Show OTP to Vendor</small><br>
                                    <span class="otp-box"><%= rs.getString("otp") %></span>
                                </div>
                            <% } else { %>
                                <% if(rating == 0) { %>
                                    <form action="RateOrderServlet" method="post" class="d-flex align-items-center">
                                        <input type="hidden" name="orderId" value="<%= rs.getInt("order_id") %>">
                                        <input type="hidden" name="vendorId" value="<%= rs.getInt("vendor_id") %>">
                                        <select name="rating" class="form-select form-select-sm me-2" style="width: 80px;">
                                            <option value="5">⭐ 5</option>
                                            <option value="4">⭐ 4</option>
                                            <option value="3">⭐ 3</option>
                                            <option value="2">⭐ 2</option>
                                            <option value="1">⭐ 1</option>
                                        </select>
                                        <button class="btn btn-sm btn-outline-primary">Rate</button>
                                    </form>
                                <% } else { %>
                                    <span class="text-warning">You rated: <%= rating %> ⭐</span>
                                <% } %>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <% } con.close(); %>
        </div>
    </div>
</body>
</html>