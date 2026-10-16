<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%
    String currentURI = request.getRequestURI();
    String contextPath = request.getContextPath();

    boolean isHome = currentURI.equals(contextPath + "/home")
                  || currentURI.equals(contextPath + "/");

    boolean isProducts = currentURI.equals(contextPath + "/products")
                      || currentURI.contains("/product-detail");

    boolean isCart = currentURI.equals(contextPath + "/cart");

    boolean isWishlist = currentURI.equals(contextPath + "/wishlist");

    boolean isOrders = currentURI.equals(contextPath + "/orders");

    boolean isProfile = currentURI.equals(contextPath + "/profile");

    boolean isAdmin = currentURI.contains("/admin");

    boolean isFeatures = currentURI.equals(contextPath + "/features");

    boolean isCategories = currentURI.equals(contextPath + "/categories");

    boolean isAbout = currentURI.equals(contextPath + "/about");

    boolean isContact = currentURI.equals(contextPath + "/contact");
%>

<style>
    /* ================= NAVBAR ================= */
    .main-navbar {
        width: 100%;
        background: rgba(255, 255, 255, 0.96);
        border-bottom: 1px solid #ebe7df;
        position: sticky;
        top: 0;
        z-index: 9999;
        backdrop-filter: blur(12px);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
    }

    .navbar-container {
        width: 86%;
        max-width: 1400px;
        min-height: 78px;
        margin: auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 25px;
    }

    /* ================= LOGO ================= */
    .navbar-logo {
        flex-shrink: 0;
    }

    .navbar-logo a {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #111111;
        text-decoration: none;
        transition: opacity 0.2s ease;
    }

    .navbar-logo a:hover {
        opacity: 0.9;
    }

    .logo-mark {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 42px;
        height: 42px;
        border-radius: 12px;
        background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
        color: #ffffff;
        font-family: Georgia, serif;
        font-size: 20px;
        font-weight: 700;
        position: relative;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .logo-mark::after {
        content: "";
        position: absolute;
        bottom: 6px;
        right: 6px;
        width: 6px;
        height: 6px;
        background: #e05638;
        border-radius: 50%;
    }

    .logo-text-wrapper {
        display: inline-flex;
        flex-direction: column;
        line-height: 1.15;
    }

    .logo-title {
        font-family: Georgia, serif;
        font-size: 19px;
        font-weight: 700;
        letter-spacing: 0.5px;
        color: #171717;
    }

    .logo-subtitle {
        font-size: 10px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: #e05638;
        margin-top: 2px;
    }

    /* ================= NAV LINKS ================= */
    .navbar-links {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
    }

    .navbar-links a {
        position: relative;
        padding: 9px 12px;
        color: #666;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        border-radius: 8px;
        transition: all 0.25s ease;
    }

    .navbar-links a:hover {
        color: #e05638;
        background: #fff5f1;
    }

    .navbar-links a.active {
        color: #e05638;
        font-weight: 700;
    }

    .navbar-links a.active::after {
        content: "";
        position: absolute;
        left: 12px;
        right: 12px;
        bottom: 2px;
        height: 2px;
        border-radius: 10px;
        background: #e05638;
    }

    /* ================= RIGHT SIDE ================= */
    .navbar-right {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-shrink: 0;
    }

    .user-greeting {
        color: #333;
        font-size: 13px;
        font-weight: 600;
        background: #f7f4ee;
        padding: 9px 12px;
        border-radius: 8px;
    }

    .nav-orders, .nav-profile, .nav-wishlist, .nav-admin {
        padding: 9px 12px;
        border: 1px solid #dedad2;
        border-radius: 8px;
        color: #333;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.25s ease;
    }

    .nav-orders:hover, .nav-profile:hover, .nav-wishlist:hover, .nav-admin:hover {
        border-color: #e05638;
        color: #e05638;
        background: #fff8f5;
    }

    .nav-admin {
        border-color: #e05638;
        color: #e05638;
        background: #fff5f1;
    }

    .nav-login {
        padding: 9px 15px;
        border: 1px solid #dedad2;
        border-radius: 8px;
        color: #333;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.25s ease;
    }

    .nav-login:hover {
        border-color: #e05638;
        color: #e05638;
        background: #fff8f5;
    }

    .nav-register {
        padding: 10px 16px;
        background: #e05638;
        border: 1px solid #e05638;
        border-radius: 8px;
        color: white;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        box-shadow: 0 5px 14px rgba(224, 86, 56, 0.18);
        transition: all 0.25s ease;
    }

    .nav-register:hover {
        background: #c9452c;
        border-color: #c9452c;
        transform: translateY(-1px);
    }

    .nav-logout {
        padding: 9px 14px;
        border: 1px solid #f0c9c3;
        border-radius: 8px;
        color: #d94c3a;
        background: #fff8f6;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.25s ease;
    }

    .nav-logout:hover {
        background: #fff0ed;
        border-color: #e05638;
    }

    /* ================= MOBILE ================= */
    @media (max-width: 1150px) {
        .navbar-container {
            width: 92%;
        }
        .navbar-links {
            gap: 0;
        }
        .navbar-links a {
            padding: 8px 7px;
            font-size: 13px;
        }
        .user-greeting {
            display: none;
        }
    }

    @media (max-width: 850px) {
        .navbar-container {
            min-height: auto;
            padding: 15px 0;
            flex-wrap: wrap;
        }
        .navbar-links {
            order: 3;
            width: 100%;
            overflow-x: auto;
            justify-content: flex-start;
            padding-top: 8px;
            border-top: 1px solid #f0ede7;
        }
        .navbar-links a {
            white-space: nowrap;
        }
    }

    @media (max-width: 500px) {
        .logo-title {
            font-size: 16px;
        }
        .logo-mark {
            width: 36px;
            height: 36px;
        }
        .navbar-right {
            gap: 5px;
        }
        .nav-login,
        .nav-register,
        .nav-logout,
        .nav-orders,
        .nav-profile,
        .nav-wishlist,
        .nav-admin {
            padding: 8px 10px;
            font-size: 12px;
        }
    }
</style>

<nav class="main-navbar">
    <div class="navbar-container">

        <!-- ================= LOGO ================= -->
        <div class="navbar-logo">
            <a href="${pageContext.request.contextPath}/home">
                <span class="logo-mark">F</span>
                <span class="logo-text-wrapper">
                    <span class="logo-title">Fashion</span>
                    <span class="logo-subtitle">Project</span>
                </span>
            </a>
        </div>

        <!-- ================= NAVIGATION ================= -->
        <div class="navbar-links">
            <a href="${pageContext.request.contextPath}/home" class="<%= isHome ? "active" : "" %>">Home</a>
            <a href="${pageContext.request.contextPath}/products" class="<%= isProducts ? "active" : "" %>">Products</a>
            <a href="${pageContext.request.contextPath}/cart" class="<%= isCart ? "active" : "" %>">Cart</a>

            <c:if test="${not empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/wishlist" class="<%= isWishlist ? "active" : "" %>">Wishlist</a>
                <a href="${pageContext.request.contextPath}/orders" class="<%= isOrders ? "active" : "" %>">My Orders</a>
                <a href="${pageContext.request.contextPath}/profile" class="<%= isProfile ? "active" : "" %>">Profile</a>
                
                <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="<%= isAdmin ? "active" : "" %>">Admin Dashboard</a>
                </c:if>
            </c:if>

            <a href="${pageContext.request.contextPath}/features" class="<%= isFeatures ? "active" : "" %>">Features</a>
            <a href="${pageContext.request.contextPath}/categories" class="<%= isCategories ? "active" : "" %>">Categories</a>
            <a href="${pageContext.request.contextPath}/about" class="<%= isAbout ? "active" : "" %>">About</a>
            <a href="${pageContext.request.contextPath}/contact" class="<%= isContact ? "active" : "" %>">Contact</a>
        </div>

        <!-- ================= AUTHENTICATION ================= -->
        <div class="navbar-right">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <span class="user-greeting">Hello, ${sessionScope.loggedInUser.name}</span>

                    <a class="nav-wishlist" href="${pageContext.request.contextPath}/wishlist">Wishlist</a>
                    <a class="nav-profile" href="${pageContext.request.contextPath}/profile">Profile</a>
                    <a class="nav-orders" href="${pageContext.request.contextPath}/orders">Orders</a>

                    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <a class="nav-admin" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
                    </c:if>

                    <a class="nav-logout" href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>

                <c:otherwise>
                    <a class="nav-login" href="${pageContext.request.contextPath}/login">Login</a>
                    <a class="nav-register" href="${pageContext.request.contextPath}/register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</nav>