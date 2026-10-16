<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Fashion Project</title>
    <!-- Explicit asset references -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/about.css">
    <style>
        /* Sticky Footer Layout Fix */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #faf9f6;
            background-image: linear-gradient(rgba(255, 255, 255, 0.90), rgba(255, 255, 255, 0.90)), 
                              url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1600&auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
            color: #282c3f;
        }

        /* Professional Header & Navigation Spacing */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        /* Logo Styling Fix */
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 18px;
            color: #1a1a1a;
            text-decoration: none;
        }
        .logo-box {
            background-color: #e05638;
            color: white;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            font-weight: bold;
            font-size: 16px;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }
        .nav-links a {
            text-decoration: none;
            color: #383838;
            font-weight: 500;
            font-size: 15px;
            transition: color 0.2s ease;
        }
        .nav-links a:hover, .nav-links a.active {
            color: #e05638;
        }
        .auth-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .btn-login, .btn-register, .btn-logout {
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
        }
        .btn-login {
            color: #e05638;
            border: 1px solid #e05638;
        }
        .btn-register, .btn-logout {
            background: #e05638;
            color: white;
        }

        /* Main Content Wrapper */
        .main-content {
            flex: 1;
        }

        /* About Container Styling */
        .about-container {
            width: 86%;
            max-width: 900px;
            margin: 60px auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
            border-radius: 12px;
            padding: 50px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .about-container h2 {
            font-family: Georgia, serif;
            font-size: 32px;
            color: #1a1a1a;
            margin-bottom: 20px;
        }
        .about-container p {
            color: #555;
            line-height: 1.8;
            font-size: 15px;
            margin-bottom: 20px;
        }

        /* Footer Style */
        .footer {
            text-align: center;
            padding: 25px;
            color: #666;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9);
            border-top: 1px solid rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>
    <!-- Header / Navbar -->
    <header class="header">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <span class="logo-box">F</span> Fashion Project
        </a>
        
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/features">Features</a>
            <a href="${pageContext.request.contextPath}/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/about" class="active">About</a>
            <a href="${pageContext.request.contextPath}/home#contact">Contact</a>
        </nav>

        <div class="auth-section">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span>Hello, ${sessionScope.user.name}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <!-- Main Content Wrapper -->
    <div class="main-content">
        <main class="about-container">
            <h2>About Fashion Project</h2>
            <p>Welcome to <strong>Fashion Project</strong>, your premier destination for modern, trendy, and high-quality apparel. We believe fashion should be accessible, comfortable, and an expression of your unique personality.</p>
            <p>Founded with a passion for excellence, we curate the finest styles for men and women, ensuring seamless online shopping experiences from browse to doorstep delivery.</p>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Fashion Project. All rights reserved.</p>
    </footer>
</body>
</html>