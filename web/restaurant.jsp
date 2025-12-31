<%@page import="java.sql.*, com.lpu.common.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function updateQty(id, change) {
            let el = document.getElementById("q_"+id);
            let val = parseInt(el.value) + change;
            if(val >= 1) el.value = val;
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-dark bg-danger p-3 sticky-top">
        <div class="container">
            <a href="home.jsp" class="text-white text-decoration-none">⬅ Back</a>
            <span class="navbar-text text-white fw-bold fs-4"><%= request.getParameter("vname") %> Menu</span>
            <a href="cart.jsp" class="btn btn-warning">View Cart 🛒</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <%
                String vid = request.getParameter("vid");
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement("SELECT * FROM menu_items WHERE vendor_id=?");
                pst.setString(1, vid);
                ResultSet rs = pst.executeQuery();
                while(rs.next()) {
            %>
            <div class="col-md-6 mb-3">
                <div class="card p-3 d-flex flex-row align-items-center">
                    <img src="<%= rs.getString("image_url") %>" style="width:100px; height:100px; border-radius:10px; object-fit:cover;">
                    <div class="ms-3 flex-grow-1">
                        <h5><%= rs.getString("item_name") %></h5>
                        <p class="text-muted fw-bold">₹ <%= rs.getDouble("price") %></p>
                        
                        <form action="CartServlet" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="<%= rs.getInt("item_id") %>">
                            <input type="hidden" name="name" value="<%= rs.getString("item_name") %>">
                            <input type="hidden" name="price" value="<%= rs.getDouble("price") %>">
                            <input type="hidden" name="vendorId" value="<%= vid %>">
                            <input type="hidden" name="redirect" value="restaurant.jsp?vid=<%=vid%>&vname=<%=request.getParameter("vname")%>">
                            
                            <div class="btn-group me-2">
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateQty(<%=rs.getInt("item_id")%>, -1)">-</button>
                                <input type="text" id="q_<%=rs.getInt("item_id")%>" name="qty" value="1" style="width:40px; text-align:center;" readonly>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateQty(<%=rs.getInt("item_id")%>, 1)">+</button>
                            </div>
                            <button class="btn btn-sm btn-danger">Add +</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } con.close(); %>
        </div>
    </div>
</body>
</html>