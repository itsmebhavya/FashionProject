<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Orders &amp; Delivery - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        /* ==========================================
            Cream/Beige Sidebar & Clean Admin Styling
            ========================================== */
        :root {
            --bg-sidebar: #f5e6cc;       /* Requested cream/beige sidebar background */
            --text-sidebar: #3f4254;     /* Dark high-contrast text for light background */
            --text-sidebar-hover: #181c32; 
            --accent-active: #ffffff;    /* Clean white background for active link state */
            --bg-main: #f4f5f7;          
            --card-bg: #ffffff;
            --text-main: #3f4254;
            --border-color: #ebedf2;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            display: flex;
        }

        .admin-sidebar {
            width: 260px;
            height: 100vh;
            background-color: var(--bg-sidebar); /*[cite: 5] */
            border-right: 1px solid rgba(0, 0, 0, 0.08);
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 30px 20px;
            z-index: 100;
        }

        .sidebar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
            color: #181c32;
            text-decoration: none;
            margin-bottom: 35px;
            display: block;
            letter-spacing: 0.5px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .sidebar-menu li {
            margin-bottom: 8px;
        }

        .sidebar-menu a {
            color: var(--text-sidebar);
            text-decoration: none;
            display: block;
            padding: 12px 18px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.92rem;
            transition: all 0.2s ease;
        }

        .sidebar-menu a:hover {
            color: var(--text-sidebar-hover);
            background-color: rgba(255, 255, 255, 0.4);
        }

        .sidebar-menu a.active {
            background-color: var(--accent-active);
            color: #181c32;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .sidebar-footer {
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            padding-top: 20px;
        }

        .logout-link {
            color: var(--text-sidebar);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            transition: color 0.2s;
        }

        .logout-link:hover {
            color: #181c32;
        }

        .admin-main {
            margin-left: 260px;
            flex-grow: 1;
            padding: 40px;
            min-height: 100vh;
            width: calc(100% - 260px);
        }

        .admin-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--card-bg);
            padding: 24px 30px;
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--border-color);
        }

        .admin-topbar h2 {
            margin: 0 0 6px 0;
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            color: #181c32;
        }

        .subtext {
            color: #7e8299;
            font-size: 0.9rem;
            margin: 0;
        }

        .btn-secondary {
            background-color: #f3f6f9;
            color: #3f4254;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            border: 1px solid #d8d8d8;
            transition: background 0.2s;
        }

        .btn-secondary:hover {
            background-color: #e4e6ef;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 24px 28px;
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--border-color);
        }

        .stat-card h4 {
            margin: 0 0 12px 0;
            color: #7e8299;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .stat-card .value {
            font-size: 2rem;
            font-weight: 700;
            color: #181c32;
            margin: 0 0 8px 0;
        }

        .table-card {
            background: var(--card-bg);
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            padding: 30px;
            border: 1px solid var(--border-color);
        }

        .table-header h3 {
            font-family: 'Playfair Display', serif;
            margin: 0 0 22px 0;
            font-size: 1.3rem;
            color: #181c32;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.92rem;
        }

        .admin-table th {
            background-color: #f8f9fa;
            color: #5e6278;
            font-weight: 600;
            padding: 16px 18px;
            border-bottom: 2px solid var(--border-color);
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.8px;
        }

        .admin-table td {
            padding: 18px;
            border-bottom: 1px solid var(--border-color);
            color: #3f4254;
            vertical-align: middle;
        }

        .admin-table tr:hover {
            background-color: #f9f9fb;
        }

        .text-right {
            text-align: right;
        }

        .btn-action {
            background-color: #181c32;
            color: #fff;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.82rem;
            font-weight: 500;
            transition: background 0.2s;
        }

        .btn-action:hover {
            background-color: #2b304d;
        }

        .badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-processing {
            background-color: #fff8e1;
            color: #b78103;
        }

        .badge-packed {
            background-color: #e6f4ea;
            color: #137333;
        }

        .badge-shipped {
            background-color: #e8f0fe;
            color: #1a73e8;
        }
    </style>
</head>
<body>

    <!-- Cream/Beige Sidebar -->
    <div class="admin-sidebar">
        <div>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-brand">
                <span style="color: #ff6b35;">&#10022;</span> Fashion Project
            </a>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Catalog / Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders" class="active">Customer Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Registered Users</a></li>
            </ul>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="admin-main">
        <div class="admin-topbar">
            <div>
                <h2>Order &amp; Delivery Tracking</h2>
                <p class="subtext">Monitor customer checkout fulfillment, dispatch updates, and package tracking.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-secondary">&larr; Back to Dashboard</a>
            </div>
        </div>

        <c:if test="${not empty errorMessage}">
            <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                ${errorMessage}
            </div>
        </c:if>

        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Orders</h4>
                <p class="value">${not empty orderList ? orderList.size() : 0}</p>
                <span class="subtext" style="color: #137333; font-weight: 600;">Active Fulfillment</span>
            </div>
            <div class="stat-card">
                <h4>Packed Today</h4>
                <p class="value">1</p>
                <span class="subtext" style="color: #1a73e8; font-weight: 600;">Ready for Dispatch</span>
            </div>
            <div class="stat-card">
                <h4>Pending Dispatch</h4>
                <p class="value">0</p>
                <span class="subtext">All clear</span>
            </div>
        </div>

        <div class="table-card">
            <div class="table-header">
                <h3>Recent Customer Purchases</h3>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Total Amount</th>
                            <th>Payment Method</th>
                            <th>Status</th>
                            <th class="text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty orderList}">
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td><strong>#ORD-${order.orderId}</strong></td>
                                        <td>${order.deliveryName}</td>
                                        <td>&#8377;${order.totalAmount}</td>
                                        <td>${order.paymentMethod}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.orderStatus == 'Packed'}">
                                                    <span class="badge badge-packed">${order.orderStatus}</span>
                                                </c:when>
                                                <c:when test="${order.orderStatus == 'Shipped'}">
                                                    <span class="badge badge-shipped">${order.orderStatus}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-processing">${order.orderStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right">
                                            <a href="${pageContext.request.contextPath}/admin/order-details?id=${order.orderId}" class="btn-action">View Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" style="text-align: center; color: #7e8299; padding: 30px;">
                                        No customer orders found in the system.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>