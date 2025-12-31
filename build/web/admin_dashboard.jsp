<%@page import="java.sql.*, com.lpu.common.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .stat-card { color: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .bg-1 { background: linear-gradient(45deg, #ff9a9e, #fad0c4); }
        .bg-2 { background: linear-gradient(45deg, #a18cd1, #fbc2eb); }
        .bg-3 { background: linear-gradient(45deg, #84fab0, #8fd3f4); }
    </style>
</head>
<body class="bg-light">
    
    <% 
        if(session.getAttribute("userType") == null || !session.getAttribute("userType").equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <nav class="navbar navbar-dark bg-dark p-3">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold">🛡️ Admin Panel</span>
            <a href="login.jsp" class="btn btn-danger btn-sm">Logout</a>
        </div>
    </nav>

    <div class="container mt-4">
        
        <%
            Connection con = null;
            int totalUsers=0, totalVendors=0, totalOrders=0;
            try {
                con = DBConnection.getConnection();
                ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM users WHERE role='CUSTOMER'");
                if(rs1.next()) totalUsers = rs1.getInt(1);

                ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM vendors");
                if(rs2.next()) totalVendors = rs2.getInt(1);

                ResultSet rs3 = con.createStatement().executeQuery("SELECT COUNT(*) FROM orders");
                if(rs3.next()) totalOrders = rs3.getInt(1);
        %>
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stat-card bg-1">
                    <h3><%= totalUsers %></h3>
                    <p class="m-0">Total Students</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card bg-2">
                    <h3><%= totalVendors %></h3>
                    <p class="m-0">Total Vendors</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card bg-3">
                    <h3><%= totalOrders %></h3>
                    <p class="m-0">Total Orders Delivered</p>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white fw-bold">Manage Vendors</div>
            <div class="card-body">
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Shop Name</th>
                            <th>Username</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM vendors");
                            while(rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("vendor_id") %></td>
                            <td><%= rs.getString("shop_name") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td>⭐ <%= rs.getDouble("avg_rating") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="vendor_register.jsp" class="btn btn-primary">Add New Vendor</a>
        </div>

        <% 
            } catch(Exception e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                if(con != null) con.close();
            }
        %>
    </div>
</body>
</html>