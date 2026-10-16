<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fashion Project - Home</title>
    <!-- Explicit asset references -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css">
    <style>
        /* Enable Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Full-Page Fixed Sliding Background Container */
        .page-bg-slider {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: -999;
            pointer-events: none;
            overflow: hidden;
        }

        .bg-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            opacity: 0;
            transition: opacity 1.8s ease-in-out, transform 6s ease-out;
            transform: scale(1);
        }

        .bg-slide.active {
            opacity: 0.28; /* Soft visibility so it acts as an elegant background throughout the page */
            transform: scale(1.05); /* Gentle zoom effect */
        }

        /* Clean Body Background */
        body {
            background-color: #faf9f6;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #282c3f;
        }

        /* Professional Header & Search Bar Layout */
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
        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .search-form {
            display: flex;
            align-items: center;
            background: #f1f3f6;
            border-radius: 8px;
            padding: 4px 4px 4px 12px;
            width: 320px;
            transition: all 0.3s ease;
        }
        .search-form:hover, .search-form:focus-within {
            background: #eaeaec;
            box-shadow: 0 0 0 1px #d4d5df;
        }
        .search-icon {
            font-size: 14px;
            color: #696e79;
            margin-right: 8px;
            background: none;
            border: none;
            padding: 0;
            cursor: default;
        }
        .search-input {
            border: none;
            outline: none;
            background: transparent;
            font-size: 14px;
            color: #282c3f;
            width: 100%;
        }
        .search-input::placeholder {
            color: #94969f;
        }
        .search-btn {
            background: #e05638;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 13px;
            transition: background 0.3s ease;
        }
        .search-btn:hover {
            background: #c9452c;
        }

        /* Hero Section Styling */
        .hero-section {
            position: relative;
            text-align: center;
            padding: 60px 20px 40px 20px;
        }

        .hero-content, .hero-images {
            position: relative;
            z-index: 3;
        }

        /* Creative About Us Split Section */
        .about-creative-section {
            width: 86%;
            max-width: 1000px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            padding: 50px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.04);
            display: flex;
            align-items: center;
            gap: 40px;
        }
        .about-images-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            flex: 1;
        }
        .about-images-grid img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .about-images-grid img:hover {
            transform: scale(1.03);
        }
        .about-text-content {
            flex: 1;
        }
        .about-text-content h2 {
            font-family: Georgia, serif;
            font-size: 30px;
            color: #1a1a1a;
            margin-bottom: 15px;
        }
        .about-text-content p {
            color: #555;
            line-height: 1.7;
            font-size: 14px;
            margin-bottom: 15px;
        }

        /* Get In Touch Section */
        .info-section {
            width: 86%;
            max-width: 800px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            padding: 45px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.04);
            text-align: center;
        }
        .info-section h2 {
            font-family: Georgia, serif;
            font-size: 32px;
            color: #1a1a1a;
            margin-bottom: 15px;
        }
        .info-section p {
            color: #555;
            line-height: 1.7;
            margin-bottom: 20px;
            font-size: 15px;
        }
        .contact-links {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
        }
        .contact-links a {
            color: #e05638;
            font-weight: 500;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.2s ease;
        }
        .contact-links a:hover {
            text-decoration: underline;
            color: #c9452c;
        }

        @media (max-width: 768px) {
            .about-creative-section {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Full-Page Background Sliding Container with Creative Fashion Images -->
    <div class="page-bg-slider">
        <div class="bg-slide active" style="background-image: url('https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1600&auto=format&fit=crop&q=80');"></div>
        <div class="bg-slide" style="background-image: url('https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=1600&auto=format&fit=crop&q=80');"></div>
        <div class="bg-slide" style="background-image: url('https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=1600&auto=format&fit=crop&q=80');"></div>
        <div class="bg-slide" style="background-image: url('https://images.unsplash.com/photo-1445205170230-053b83016050?w=1600&auto=format&fit=crop&q=80');"></div>
    </div>

    <!-- Header / Navbar -->
    <header class="header">
        <div class="logo">
            <span class="logo-box">F</span> Fashion Project
        </div>
        
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/features">Features</a>
            <a href="${pageContext.request.contextPath}/categories">Categories</a>
            <a href="#about">About</a>
            <a href="#contact">Contact</a>
        </nav>

        <!-- Right Side Group: Search Bar with Dedicated Button & Auth Buttons -->
        <div class="header-right">
            <form action="${pageContext.request.contextPath}/products" method="GET" class="search-form">
                <span class="search-icon">🔍</span>
                <input type="text" name="search" placeholder="Search for products, brands and more" class="search-input" required>
                <button type="submit" class="search-btn">Search</button>
            </form>

            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1>Style Makes You Look Good</h1>
            <p>Our collection will help you look better and we will provide the best product for you.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn-explore">Explore All</a>
        </div>

        <!-- Tilted Images Showcase using Online Placeholders -->
        <div class="hero-images">
            <div class="image-card left-card">
                <img src="https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400&auto=format&fit=crop&q=80" alt="Model 1">
            </div>
            <div class="image-card right-card">
                <img src="https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=400&auto=format&fit=crop&q=80" alt="Model 2">
            </div>
        </div>
    </section>

    <!-- Stats Bar -->
    <section class="stats-section">
        <div class="stat-item">
            <h2>10+</h2>
            <p>YEAR EXPERIENCE</p>
        </div>
        <div class="stat-item">
            <h2>25M+</h2>
            <p>HAPPY CUSTOMER</p>
        </div>
        <div class="stat-item">
            <h2>9.8</h2>
            <p>PRODUCTS RATING</p>
        </div>
    </section>

    <!-- Shop by Category Section -->
    <section class="category-section">
        <h2>Shop by Category</h2>
        <div class="category-grid">
            <div class="category-card">
                <h3>Men</h3>
                <a href="${pageContext.request.contextPath}/products?category=1">Explore &rarr;</a>
            </div>
            <div class="category-card">
                <h3>Women</h3>
                <a href="${pageContext.request.contextPath}/products?category=2">Explore &rarr;</a>
            </div>
            <div class="category-card">
                <h3>Kids</h3>
                <a href="${pageContext.request.contextPath}/products?category=3">Explore &rarr;</a>
            </div>
            <div class="category-card">
                <h3>Accessories</h3>
                <a href="${pageContext.request.contextPath}/products?category=4">Explore &rarr;</a>
            </div>
        </div>
    </section>

    <!-- Latest Products Section -->
    <section class="products-section">
        <h2>Latest Collection</h2>
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty latestProducts}">
                    <c:forEach var="product" items="${latestProducts}">
                        <div class="product-card">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}">
                            </a>
                            <h3>${product.productName}</h3>
                            <p class="brand">${product.brand}</p>
                            <p class="price">$${product.price}</p>
                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}" class="btn-buy">View Details</a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-products">No products available at the moment.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Creative About Us Section with Image Collage & ID -->
    <section id="about" class="about-creative-section">
        <div class="about-images-grid">
            <img src="https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400&auto=format&fit=crop&q=80" alt="Fashion Style 1">
            <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400&auto=format&fit=crop&q=80" alt="Fashion Style 2">
        </div>
        <div class="about-text-content">
            <h2>About Fashion Project</h2>
            <p>Fashion Project is your ultimate destination for trendy, high-quality clothing. Founded with a passion for style and comfort, we bring carefully curated collections straight to your wardrobe.</p>
            <p>Our mission is to empower individuals to express their unique personality through fashion with confidence and ease.</p>
        </div>
    </section>

    <!-- Get In Touch Section with ID & Workable Links -->
    <section id="contact" class="info-section">
        <h2>Get In Touch</h2>
        <p>Have questions, feedback, or need style assistance? Reach out to our team anytime!</p>
        <div class="contact-links">
            <a href="mailto:support@fashionproject.com">✉ support@fashionproject.com</a>
            <a href="tel:+919876543210">📞 +91 98765 43210</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Fashion Project. All rights reserved.</p>
    </footer>

    <!-- Background Slider Script -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const slides = document.querySelectorAll(".bg-slide");
            let currentSlide = 0;

            function nextSlide() {
                slides[currentSlide].classList.remove("active");
                currentSlide = (currentSlide + 1) % slides.length;
                slides[currentSlide].classList.add("active");
            }

            // Rotates background slide every 4.5 seconds
            setInterval(nextSlide, 4500);
        });
    </script>
</body>
</html>