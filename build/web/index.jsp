<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>LPU Fresh Check</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://b.zmtcdn.com/web_assets/81f3ff974d82520780078ba1cfbd453a1583259680.png');
            height: 75vh;
            background-size: cover;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark position-absolute w-100 p-3">
        <div class="container d-flex justify-content-end">
            <a href="login.jsp" class="btn btn-outline-light">Login / Sign Up</a>
        </div>
    </nav>

    <div class="hero">
        <h1 class="display-1 fw-bold fst-italic">LPU Fresh Check</h1>
        <p class="fs-2">Discover the best food on campus</p>
        <div class="mt-4">
            <a href="login.jsp" class="btn btn-danger btn-lg px-5">Order Now</a>
        </div>
    </div>
</body>
</html>