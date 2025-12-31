<%-- File: Web Pages/order_success.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Placed</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0fdf4; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .otp-card { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); text-align: center; width: 400px; }
        .otp-display { font-size: 3.5rem; font-weight: 800; color: #198754; letter-spacing: 5px; margin: 20px 0; border: 3px dashed #198754; border-radius: 10px; padding: 10px; }
    </style>
</head>
<body>

    <div class="otp-card">
        <div style="font-size: 60px;">🎉</div>
        <h2 class="fw-bold text-success">Order Successful!</h2>
        <p class="text-muted">Your food is being prepared.</p>
        
        <hr>
        <p class="mb-0 fw-bold">Show this OTP to Vendor:</p>
        <div class="otp-display">
            <%= session.getAttribute("lastOtp") %>
        </div>
        
        <div class="d-grid gap-2">
            <a href="my_orders.jsp" class="btn btn-primary">Track Order / My Orders</a>
            <a href="home.jsp" class="btn btn-outline-secondary">Go to Home</a>
        </div>
    </div>

</body>
</html>
