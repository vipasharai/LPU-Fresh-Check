<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Payment</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="d-flex align-items-center justify-content-center" style="height:100vh;">
    <div class="card shadow p-4 text-center" style="width:350px;">
        <h3>Select Payment</h3>
        <h2 class="text-primary my-3">₹ <%= request.getParameter("amount") %></h2>
        
        <form action="OrderServlet" method="post">
            <div class="form-check text-start mb-3 border p-2 rounded">
                <input class="form-check-input" type="radio" name="paymentMethod" value="UPI" id="upi" checked onclick="showQr(true)">
                <label class="form-check-label" for="upi">UPI (GPay/PhonePe)</label>
                <div id="qrCode" class="mt-2 text-center">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=lpu@okaxis&am=<%= request.getParameter("amount") %>" class="img-thumbnail">
                    <p class="small text-muted">Scan to Pay</p>
                </div>
            </div>
            <div class="form-check text-start mb-3 border p-2 rounded">
                <input class="form-check-input" type="radio" name="paymentMethod" value="CASH" id="cash" onclick="showQr(false)">
                <label class="form-check-label" for="cash">Cash on Delivery</label>
            </div>
            <button class="btn btn-success w-100 py-2">Confirm Payment & Order</button>
        </form>
    </div>
    <script>
        function showQr(show) { document.getElementById("qrCode").style.display = show ? "block" : "none"; }
    </script>
</body>
</html>