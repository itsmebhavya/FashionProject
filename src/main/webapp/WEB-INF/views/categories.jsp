<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories - Fashion Project</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f4ee;
            color: #1a1a1a;
        }

        .page-header {
            text-align: center;
            padding: 80px 20px 50px;
        }

        .page-header span {
            color: #e05638;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .page-header h1 {
            font-family: Georgia, serif;
            font-size: 48px;
            margin: 15px 0;
        }

        .page-header p {
            color: #777;
            max-width: 600px;
            margin: auto;
            line-height: 1.7;
        }

        .category-container {
            width: 86%;
            max-width: 1200px;
            margin: 0 auto 80px;
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .card {
            position: relative;
            height: 360px;
            border-radius: 18px;
            overflow: hidden;
            background: #ddd;
            text-decoration: none;
            color: white;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-7px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.14);
        }

        .card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .card:hover img {
            transform: scale(1.06);
        }

        .overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(
                to top,
                rgba(0,0,0,0.78),
                rgba(0,0,0,0.08)
            );
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 30px;
        }

        .overlay h2 {
            font-family: Georgia, serif;
            font-size: 34px;
            margin-bottom: 8px;
        }

        .overlay p {
            font-size: 14px;
            color: #eee;
            margin-bottom: 15px;
        }

        .explore {
            font-size: 14px;
            font-weight: bold;
        }

        .all-products {
            margin-top: 30px;
            text-align: center;
        }

        .all-products a {
            display: inline-block;
            background: #e05638;
            color: white;
            padding: 14px 28px;
            border-radius: 7px;
            font-weight: bold;
            transition: 0.3s;
        }

        .all-products a:hover {
            background: #c9452c;
        }

        @media (max-width: 700px) {
            .category-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 38px;
            }

            .card {
                height: 300px;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <!-- Header -->
    <section class="page-header">
        <span>Explore</span>
        <h1>Shop by Category</h1>
        <p>Discover fashion collections designed for every style, age and occasion.</p>
    </section>

    <!-- Categories -->
    <div class="category-container">
        <div class="category-grid">

            <!-- MEN -->
            <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/products?category=Men'">
                <img src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=600&auto=format&fit=crop&q=80" alt="Men Fashion">
                <div class="overlay">
                    <h2>Men</h2>
                    <p>Explore shirts, jeans, t-shirts and more.</p>
                    <span class="explore">Explore Collection →</span>
                </div>
            </div>

            <!-- WOMEN -->
            <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/products?category=Women'">
                <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?w=600&auto=format&fit=crop&q=80" alt="Women Fashion">
                <div class="overlay">
                    <h2>Women</h2>
                    <p>Discover dresses, kurtis, tops and jeans.</p>
                    <span class="explore">Explore Collection →</span>
                </div>
            </div>

            <!-- KIDS -->
            <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/products?category=Kids'">
                <img src="https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=600&auto=format&fit=crop&q=80" alt="Kids Fashion">
                <div class="overlay">
                    <h2>Kids</h2>
                    <p>Fun and stylish outfits for kids.</p>
                    <span class="explore">Explore Collection →</span>
                </div>
            </div>

            <!-- ACCESSORIES -->
            <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/products?category=Accessories'">
                <img src="https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=600&auto=format&fit=crop&q=80" alt="Accessories">
                <div class="overlay">
                    <h2>Accessories</h2>
                    <p>Complete your look with stylish accessories.</p>
                    <span class="explore">Explore Collection →</span>
                </div>
            </div>

        </div>

        <!-- ALL PRODUCTS -->
        <div class="all-products">
            <a href="${pageContext.request.contextPath}/products">View All Products →</a>
        </div>
    </div>

</body>
</html>