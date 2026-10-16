<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fashion Project - Products</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/products.css">
    <style>
        body {
            background-color: #faf9f6;
            background-image: linear-gradient(rgba(255, 255, 255, 0.90), rgba(255, 255, 255, 0.90)), 
                        url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1600&auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #282c3f;
        }
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
            width: 280px;
        }
        .search-input {
            border: none;
            outline: none;
            background: transparent;
            font-size: 13px;
            width: 100%;
        }
        .search-btn {
            background: #e05638;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 12px;
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
        .products-page-container {
            width: 90%;
            max-width: 1350px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            gap: 30px;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .product-card {
            background: #fff;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
        }
        .product-card img {
            width: 100%;
            height: 190px;
            object-fit: cover;
            border-radius: 6px;
            margin-bottom: 12px;
        }
        .product-card h3 {
            font-size: 15px;
            color: #1a1a1a;
            margin: 8px 0 4px 0;
        }
        .product-card .brand {
            font-size: 13px;
            color: #777;
            margin-bottom: 8px;
        }
        .product-card .price {
            font-size: 14px;
            font-weight: bold;
            color: #e05638;
            margin-bottom: 12px;
        }
        .btn-buy {
            display: inline-block;
            background: #1a1a1a;
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            transition: background 0.2s ease;
        }
        .btn-buy:hover {
            background: #e05638;
        }
        .footer {
            text-align: center;
            padding: 25px;
            color: #666;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9);
            border-top: 1px solid rgba(0,0,0,0.05);
            margin-top: 60px;
        }
    </style>
</head>
<body>
    <header class="header">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <span class="logo-box">F</span> Fashion Project
        </a>
        
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/products" class="active">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/features">Features</a>
            <a href="${pageContext.request.contextPath}/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
        </nav>

        <div class="header-right">
            <form action="${pageContext.request.contextPath}/products" method="GET" class="search-form">
                <input type="text" name="search" placeholder="Search products..." class="search-input">
                <button type="submit" class="search-btn">Search</button>
            </form>

            <div class="auth-section">
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <span>Hello, ${sessionScope.loggedInUser.name}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <main class="products-page-container">
        <!-- Filter Sidebar -->
        <aside style="width: 260px; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #eaeaea; height: fit-content;">
            <h3 style="font-size: 18px; margin-bottom: 20px; color: #1a1a1a; border-bottom: 2px solid #e05638; padding-bottom: 8px;">Filters</h3>
            
            <form action="${pageContext.request.contextPath}/products" method="GET">
                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: bold; font-size: 13px; margin-bottom: 6px; color: #555;">Search Keyword</label>
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="Keyword..." style="width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 13px;">
                </div>

                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: bold; font-size: 13px; margin-bottom: 6px; color: #555;">Category</label>
                    <select name="categoryId" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 13px; background: #fff;">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}" ${param.categoryId == cat.categoryId ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: bold; font-size: 13px; margin-bottom: 6px; color: #555;">Price Range (Rs.)</label>
                    <div style="display: flex; gap: 8px;">
                        <input type="number" name="minPrice" value="${param.minPrice}" placeholder="Min" style="width: 50%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 13px;">
                        <input type="number" name="maxPrice" value="${param.maxPrice}" placeholder="Max" style="width: 50%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 13px;">
                    </div>
                </div>

                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: bold; font-size: 13px; margin-bottom: 6px; color: #555;">Sort By</label>
                    <select name="sortBy" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 13px; background: #fff;">
                        <option value="">Default</option>
                        <option value="price_asc" ${param.sortBy == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="price_desc" ${param.sortBy == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                        <option value="newest" ${param.sortBy == 'newest' ? 'selected' : ''}>Newest Arrivals</option>
                    </select>
                </div>

                <button type="submit" style="width: 100%; padding: 10px; background: #e05638; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; font-size: 14px;">Apply Filters</button>
            </form>
        </aside>

        <!-- Product Grid Area -->
        <div style="flex: 1;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2 style="font-family: Georgia, serif; font-size: 28px; color: #1a1a1a; margin: 0;">Explore Collections</h2>
            </div>

            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}">
                                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}">
                                </a>
                                <h3>${product.productName}</h3>
                                <p class="brand">${product.brand}</p>
                                <p class="price">Rs. ${product.price}</p>
                                <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}" class="btn-buy">View Details</a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-products" style="text-align: center; color: #666; grid-column: 1 / -1; padding: 40px;">No products match your filter criteria.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 Fashion Project. All rights reserved.</p>
    </footer>
</body>
</html>