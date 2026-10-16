<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-theme.css" />
</head>
<body>

    <!-- Left Sidebar -->
    <div class="admin-sidebar">
        <!-- Brand Header -->
        <a href="${pageContext.request.contextPath}/home" class="sidebar-brand">
            <span style="color: var(--accent-orange);">✦</span> Fashion Project
        </a>

        <!-- Navigation Menu -->
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products">Catalog / Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders">Customer Orders</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Registered Users</a></li>
        </ul>

        <!-- Logout Section Pinned at Bottom -->
        <div class="sidebar-logout-container">
            <a href="${pageContext.request.contextPath}/logout" class="sidebar-logout-link">Logout</a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="admin-main">
        
        <!-- Top Bar -->
        <div class="admin-topbar">
            <div>
                <h2>Welcome back, Admin!</h2>
                <p class="subtext">Here is your live boutique and order delivery overview.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/home" class="btn-primary">View Storefront</a>
            </div>
        </div>

        <!-- Delivery Banner Card -->
        <div class="delivery-banner">
            <div>
                <h3>Fast Shipping &amp; Secure Deliveries</h3>
                <p class="subtext">Monitor all active customer packaging, dispatch updates, and seamless inventory management right from your partner portal.</p>
            </div>
            <div>
                <a href="#" class="btn-primary">Manage Deliveries</a>
            </div>
        </div>

        <!-- Metric Cards Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h4>TOTAL ORDERS</h4>
                <p class="value">1</p>
                <p class="card-note" style="color: #2e7d32;">Live &amp; Processing</p>
            </div>
            <div class="stat-card">
                <h4>TOTAL REVENUE</h4>
                <p class="value">₹2,898</p>
                <p class="card-note" style="color: #666666;">Secure UPI &amp; Card Payments</p>
            </div>
            <div class="stat-card">
                <h4>ACTIVE CATALOG</h4>
                <p class="value">16</p>
                <p class="card-note" style="color: #666666;">Featured Fashion Items</p>
            </div>
            <div class="stat-card">
                <h4>REGISTERED USERS</h4>
                <p class="value">5</p>
                <p class="card-note" style="color: #666666;">Active Shoppers</p>
            </div>
        </div>

        <!-- Action Cards Grid -->
        <div class="action-cards-grid">
            <div class="stat-card">
                <h3 class="card-title-heading">Product Catalog</h3>
                <p class="subtext card-desc">Add, edit, or check stock availability for all clothing lines and accessories.</p>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-primary">Open Catalog</a>
            </div>
            <div class="stat-card">
                <h3 class="card-title-heading">Order &amp; Delivery Tracking</h3>
                <p class="subtext card-desc">Review customer purchases, payment methods, and update shipment statuses.</p>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn-primary">View Orders</a>
            </div>
            <div class="stat-card">
                <h3 class="card-title-heading">User Accounts</h3>
                <p class="subtext card-desc">Manage registered customer accounts, roles, and authorization profiles.</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn-primary">Manage Users</a>
            </div>
        </div>

    </div>

</body>
</html>