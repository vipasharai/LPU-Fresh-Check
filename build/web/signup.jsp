<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lpu.common.DBConnection, java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>Signup</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <%
        if(request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            String reg = request.getParameter("reg");
            String pass = request.getParameter("pass");
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement("INSERT INTO users(full_name, reg_id, password, role) VALUES(?,?,?,'CUSTOMER')");
                pst.setString(1, name); pst.setString(2, reg); pst.setString(3, pass);
                pst.executeUpdate();
                response.sendRedirect("login.jsp");
                con.close();
            } catch(Exception e) { out.println(e); }
        }
    %>
    <div class="card p-4 shadow" style="width:350px;">
        <h3 class="text-center mb-3">Student Signup</h3>
        <form method="post">
            <input type="text" name="name" class="form-control mb-2" placeholder="Full Name" required>
            <input type="text" name="reg" class="form-control mb-2" placeholder="Registration ID" required>
            <input type="password" name="pass" class="form-control mb-2" placeholder="Password" required>
            <button class="btn btn-success w-100">Register</button>
        </form>
        <a href="login.jsp" class="d-block text-center mt-2">Login</a>
    </div>
</body>
</html>