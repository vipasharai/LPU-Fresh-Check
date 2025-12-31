<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Cart</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="bg-light">
    <div class="container mt-5">
        <h3 class="text-center mb-4">🛒 Your Food Cart</h3>
        <div class="card p-3 shadow-sm">
            <table class="table">
                <thead><tr><th>Item</th><th>Price</th><th>Qty</th><th>Total</th></tr></thead>
                <tbody>
                    <%
                        List<Map<String,String>> cart = (List) session.getAttribute("cart");
                        double total = 0;
                        if(cart != null) {
                            for(Map m : cart) {
                                double p = Double.parseDouble((String)m.get("price"));
                                int q = Integer.parseInt((String)m.get("qty"));
                                total += p*q;
                    %>
                    <tr>
                        <td><%= m.get("name") %></td>
                        <td>₹ <%= p %></td>
                        <td><%= q %></td>
                        <td>₹ <%= p*q %></td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
            <h4 class="text-end text-danger">Total: ₹ <%= total %></h4>
            <div class="d-flex justify-content-between mt-3">
                <form action="CartServlet" method="post"><input type="hidden" name="action" value="clear"><button class="btn btn-outline-secondary">Clear Cart</button></form>
                <% if(total > 0) { %>
                    <a href="payment.jsp?amount=<%= total %>" class="btn btn-success btn-lg">Proceed to Pay</a>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>