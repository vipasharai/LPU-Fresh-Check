<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Add Menu</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="bg-light d-flex justify-content-center align-items-center" style="height:100vh;">
    <div class="card p-4 shadow" style="width:400px;">
        <h3>Add New Item</h3>
        <form action="VendorActionServlet" method="post">
            <input type="hidden" name="action" value="addMenu">
            <div class="mb-2"><label>Item Name</label><input type="text" name="name" class="form-control" required></div>
            <div class="mb-2"><label>Price</label><input type="number" name="price" class="form-control" required></div>
            <div class="mb-2"><label>Image URL</label><input type="text" name="image" class="form-control" placeholder="https://..." required></div>
            <button class="btn btn-primary w-100">Add Item</button>
        </form>
        <a href="vendor_dashboard.jsp" class="btn btn-link mt-2 text-center d-block">Back</a>
    </div>
</body>
</html>