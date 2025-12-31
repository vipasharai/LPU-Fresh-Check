<%@page import="java.sql.*, com.lpu.common.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Vendor Dashboard</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="bg-light">
    <% if(session.getAttribute("userType") == null || !session.getAttribute("userType").equals("VENDOR")) response.sendRedirect("login.jsp"); %>
    
    <nav class="navbar navbar-dark bg-dark p-3">
        <div class="container-fluid">
            <span class="navbar-brand">👨‍🍳 <%= session.getAttribute("name") %> Dashboard</span>
            <div><a href="vendor_menu.jsp" class="btn btn-outline-light me-2">Manage Menu</a> <a href="login.jsp" class="btn btn-danger">Logout</a></div>
        </div>
    </nav>

    <div class="container mt-4">
        <% if("invalid_otp".equals(request.getParameter("msg"))) { %><div class="alert alert-danger">❌ Invalid OTP!</div><% } %>
        <% if("success".equals(request.getParameter("msg"))) { %><div class="alert alert-success">✅ Order Delivered!</div><% } %>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">Pending Orders</div>
            <div class="card-body">
                <table class="table table-bordered text-center align-middle">
                    <thead><tr><th>Order ID</th><th>Items</th><th>Total</th><th>Status</th><th>Verify OTP</th></tr></thead>
                    <tbody>
                        <%
                            Connection con = DBConnection.getConnection();
                            String vid = session.getAttribute("id").toString();
                            PreparedStatement pst = con.prepareStatement(
                                "SELECT o.order_id, o.total_amount, o.order_status, GROUP_CONCAT(oi.item_name, ' x', oi.quantity) as items " +
                                "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                                "WHERE o.vendor_id=? AND o.order_status='Pending' GROUP BY o.order_id");
                            pst.setString(1, vid);
                            ResultSet rs = pst.executeQuery();
                            while(rs.next()) {
                        %>
                        <tr>
                            <td>#<%= rs.getInt("order_id") %></td>
                            <td><%= rs.getString("items") %></td>
                            <td>₹ <%= rs.getDouble("total_amount") %></td>
                            <td><span class="badge bg-warning text-dark"><%= rs.getString("order_status") %></span></td>
                            <td>
                                <form action="VendorActionServlet" method="post" class="d-flex justify-content-center gap-2">
                                    <input type="hidden" name="action" value="verifyOtp">
                                    <input type="hidden" name="orderId" value="<%= rs.getInt("order_id") %>">
                                    <input type="text" name="otp" class="form-control form-control-sm" placeholder="OTP" style="width:80px;" required>
                                    <button class="btn btn-success btn-sm">Verify</button>
                                </form>
                            </td>
                        </tr>
                        <% } con.close(); %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>