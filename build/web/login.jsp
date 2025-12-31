<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - LPU Fresh Check</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="card shadow p-4" style="width: 400px;">
        <h3 class="text-center text-danger fw-bold mb-4">LPU Fresh Check</h3>
        
        <ul class="nav nav-pills mb-3 justify-content-center nav-fill" id="pills-tab" role="tablist">
            <li class="nav-item"><a class="nav-link active" data-bs-toggle="pill" href="#userLogin">Student</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#vendorLogin">Vendor</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#adminLogin">Admin</a></li>
        </ul>

        <div class="tab-content">
            
            <div class="tab-pane fade show active" id="userLogin">
                <form action="AuthServlet" method="post">
                    <input type="hidden" name="loginType" value="user">
                    <div class="mb-3">
                        <input type="text" name="username" class="form-control" placeholder="Reg ID (e.g. 112233)" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <button class="btn btn-danger w-100">Student Login</button>
                </form>
            </div>

            <div class="tab-pane fade" id="vendorLogin">
                <form action="AuthServlet" method="post">
                    <input type="hidden" name="loginType" value="vendor">
                    <div class="mb-3">
                        <input type="text" name="username" class="form-control" placeholder="Shop Username (e.g. kitchen)" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <button class="btn btn-primary w-100">Vendor Login</button>
                </form>
            </div>

            <div class="tab-pane fade" id="adminLogin">
                <form action="AuthServlet" method="post">
                    <input type="hidden" name="loginType" value="user"> 
                    <div class="mb-3">
                        <input type="text" name="username" class="form-control" placeholder="Admin Username" value="admin" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Admin Password" required>
                    </div>
                    <button class="btn btn-dark w-100">Admin Login 🛡️</button>
                </form>
            </div>

        </div>
        
        <div class="text-center mt-3">
            <a href="signup.jsp" class="text-decoration-none">New Student? Create Account</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>