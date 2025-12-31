<%@page import="java.sql.*, com.lpu.common.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - LPU Fresh Check</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .search-header {
            background-color: #e23744; /* Zomato Red */
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            border-radius: 0 0 20px 20px;
        }
        .v-img { 
            height: 220px; 
            object-fit: cover; 
            border-top-left-radius: 15px; 
            border-top-right-radius: 15px; 
        }
        .card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: white;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .rating-badge {
            background-color: #24963e; /* Zomato Green */
            color: white;
            padding: 2px 6px;
            border-radius: 6px;
            font-size: 0.9rem;
            font-weight: bold;
        }
        .vendor-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

    <%
        // Security Check: If user is not logged in, redirect to login page
        if(session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <nav class="navbar navbar-expand-lg navbar-light sticky-top px-4">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-danger fs-3 fst-italic" href="#">LPU Fresh Check</a>
            
            <div class="d-flex align-items-center">
                <span class="me-3 fw-semibold text-secondary">Hi, <%= session.getAttribute("name") %> 👋</span>
                <a href="my_orders.jsp" class="btn btn-outline-secondary btn-sm me-2">My Orders</a>
                <a href="login.jsp" class="btn btn-danger btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="search-header text-center">
        <div class="container">
            <h2 class="fw-bold">Craving something delicious?</h2>
            <p class="lead">Order from your favorite campus spots</p>
        </div>
    </div>

    <div class="container mb-5">
        <h3 class="mb-4 text-dark fw-bold">Best Food in LPU Campus</h3>
        
        <div class="row">
            <%
                Connection con = null;
                try {
                    con = DBConnection.getConnection();
                    // Fetch all vendors from database
                    String sql = "SELECT * FROM vendors";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery();

                    while(rs.next()) {
                        // Fetch details from DB
                        int vId = rs.getInt("vendor_id");
                        String vName = rs.getString("shop_name");
                        String vDesc = rs.getString("description");
                        String vImg = rs.getString("image_url");
                        double vRating = rs.getDouble("avg_rating");
            %>
            
            <div class="col-md-4 mb-4">
                <a href="restaurant.jsp?vid=<%= vId %>&vname=<%= vName %>" class="vendor-link">
                    <div class="card h-100">
                        <img src="<%= vImg %>" class="card-img-top v-img" alt="<%= vName %>">
                        
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <h4 class="card-title fw-bold m-0"><%= vName %></h4>
                                <span class="rating-badge">
                                    <%= vRating %> <span style="font-size:10px;">★</span>
                                </span>
                            </div>
                            <p class="text-muted mt-2 small"><%= vDesc %></p>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-primary small fw-bold">🔵 Open Now</span>
                                <button class="btn btn-sm btn-outline-danger">View Menu ➔</button>
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <% 
                    } // End While Loop
                } catch(Exception e) {
                    out.println("<div class='alert alert-danger'>Error loading vendors: " + e.getMessage() + "</div>");
                } finally {
                    if(con != null) con.close();
                }
            %>
        </div>
    </div>

</body>
</html>