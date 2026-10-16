<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-theme.css" />
    <style>
        .admin-orders-table { width: 100%; border-collapse: collapse; margin-top: 10px; background: #fff; border-radius: 8px; overflow: hidden; border: 1px solid var(--border-color); }
        .admin-orders-table th, .admin-orders-table td { padding: 12px 15px; text-align: left; border-bottom: 1px solid var(--border-color); font-size: 0.9rem; }
        .admin-orders-table th { background: #f7f4ed; color: #181c32; font-weight: 600; }
        .btn-status-update { background: #e05638; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-size: 0.85rem; font-weight: 600; }
        .status-select { padding: 6px; border-radius: 6px; border: 1px solid #ccc; font-size: 0.85rem; }
    </style>
</head>
<body>

    <!-- Eclipse Editor Fallbacks -->
    <c:if test="${empty prodSize}"><c:set var="prodSize" value="0" /></c:if>
    <c:if test="${empty extraProd}"><c:set var="extraProd" value="0" /></c:if>
    <c:if test="${empty extraProdDisplay}"><c:set var="extraProdDisplay" value="+0" /></c:if>
    <c:if test="${empty defaultPlusDisplay}"><c:set var="defaultPlusDisplay" value="+13" /></c:if>
    <c:if test="${empty totalOrders}"><c:set var="totalOrders" value="0" /></c:if>
    <c:if test="${empty totalRevenue}"><c:set var="totalRevenue" value="0.00" /></c:if>

    <!-- Left Sidebar -->
    <div class="admin-sidebar">
        <div>
            <!-- Brand Header -->
            <a href="${pageContext.request.contextPath}/home" class="sidebar-brand">
                <span style="color: var(--accent-orange);">&#10022;</span> Fashion Project
            </a>

            <!-- Navigation Menu -->
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Catalog / Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Customer Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Registered Users</a></li>
            </ul>
        </div>

        <!-- Logout Section Pinned at Bottom -->
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="admin-main">
        
        <!-- Top Bar -->
        <div class="admin-topbar">
            <div>
                <h2>Welcome, Seller!</h2>
                <p class="subtext">Here is your live boutique and business overview.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/home" class="btn-secondary">View Storefront</a>
            </div>
        </div>

        <!-- Metric Cards Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h4>TOTAL ORDERS</h4>
                <p class="value">${totalOrders}</p>
                <p class="subtext" style="color: #2e7d32; font-weight: 600;">Live count</p>
            </div>
            <div class="stat-card">
                <h4>TO BE PICKED</h4>
                <p class="value" style="color: #d97706;">0</p>
                <p class="subtext">Action required</p>
            </div>
            <div class="stat-card">
                <h4>PACKED TODAY</h4>
                <p class="value" style="color: #2e7d32;">${totalOrders}</p>
                <p class="subtext" style="color: #2e7d32; font-weight: 600;">Fulfilled</p>
            </div>
            <div class="stat-card">
                <h4>TOTAL REVENUE</h4>
                <p class="value">₹<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></p>
                <p class="subtext" style="color: #2e7d32; font-weight: 600;">Secure Gateway</p>
            </div>
            <div class="stat-card">
                <h4>ACTIVE LISTINGS</h4>
                <p class="value">${prodSize}</p>
                <p class="subtext">Featured Catalog</p>
            </div>
        </div>

        <!-- Customer Orders Management Section -->
        <div class="table-card" style="margin-bottom: 25px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                <div>
                    <h3 style="margin: 0; font-family: 'Playfair Display', serif; font-size: 1.3rem; color: #181c32;">Customer Orders &amp; Fulfillment</h3>
                    <p class="subtext" style="margin-top: 4px;">Update live order statuses and monitor buyer checkouts.</p>
                </div>
            </div>

            <c:if test="${empty allOrders}">
                <p style="color: #777; font-size: 0.95rem; padding: 15px 0;">No customer orders placed yet.</p>
            </c:if>

            <c:if test="${not empty allOrders}">
                <table class="admin-orders-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>User ID</th>
                            <th>Total Amount</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ord" items="${allOrders}">
                            <tr>
                                <td><strong>#${ord.orderId}</strong></td>
                                <td>${ord.userId}</td>
                                <td>₹<fmt:formatNumber value="${ord.totalAmount}" pattern="#,##0.00"/></td>
                                <td>${ord.createdAt}</td>
                                <td colspan="2">
                                    <form action="${pageContext.request.contextPath}/admin/dashboard" method="post" style="display:inline; margin:0;">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${ord.orderId}">
                                        <select name="status" class="status-select">
                                            <option value="Processing" ${ord.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                            <option value="Shipped" ${ord.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                            <option value="Delivered" ${ord.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                            <option value="Cancelled" ${ord.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn-status-update" style="margin-left: 8px;">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <!-- Product Catalog Quick Preview Section -->
        <div class="table-card" style="margin-bottom: 30px;">
            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px;">
                <div>
                    <h3 style="margin: 0; font-family: 'Playfair Display', serif; font-size: 1.3rem; color: #181c32;">Product Catalog</h3>
                    <p class="subtext" style="margin-top: 4px;">Add, edit, or check stock availability for all clothing lines.</p>
                </div>
            </div>

            <!-- Thumbnail Previews & Counter -->
            <div style="display: flex; align-items: center; gap: 12px; margin-top: 15px;">
                <c:choose>
                    <c:when test="${not empty productList}">
                        <c:forEach var="prod" items="${productList}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <a href="${pageContext.request.contextPath}/admin/edit-product?id=${prod.productId}" style="text-decoration: none; display: flex; width: 55px; height: 65px; background: #fff; border: 1px solid var(--border-color); border-radius: 8px; align-items: center; justify-content: center; overflow: hidden; padding: 4px;" title="<c:out value='${prod.productName}' />">
                                    <c:choose>
                                        <c:when test="${not empty prod.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/${prod.imageUrl}" alt="${prod.productName}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 4px;" />
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size: 0.75rem; font-weight: 600; color: #555; text-align: center;">Item</span>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${prodSize > 3}">
                            <a href="${pageContext.request.contextPath}/admin/products" style="text-decoration: none; display: flex; width: 55px; height: 65px; background: #fff5e6; border: 1px solid #fa7864; border-radius: 8px; align-items: center; justify-content: center; color: #fa7864; font-weight: 700; font-size: 0.95rem;" title="View all products">
                                <c:out value="${extraProdDisplay}" />
                            </a>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div style="width: 55px; height: 65px; background: #fff; border: 1px solid var(--border-color); border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; padding: 4px;">
                            <span style="font-size: 0.75rem; font-weight: 600; color: #555;">Prod 1</span>
                        </div>
                        <div style="width: 55px; height: 65px; background: #fff; border: 1px solid var(--border-color); border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; padding: 4px;">
                            <span style="font-size: 0.75rem; font-weight: 600; color: #555;">Prod 2</span>
                        </div>
                        <div style="width: 55px; height: 65px; background: #fff; border: 1px solid var(--border-color); border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; padding: 4px;">
                            <span style="font-size: 0.75rem; font-weight: 600; color: #555;">Prod 3</span>
                        </div>
                        <div style="width: 55px; height: 65px; background: #fff5e6; border: 1px solid #fa7864; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: #fa7864; font-weight: 700; font-size: 0.95rem;">
                            <c:out value="${defaultPlusDisplay}" />
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div style="margin-top: 20px; text-align: right;">
                <a href="${pageContext.request.contextPath}/admin/products" style="color: #6366f1; text-decoration: none; font-weight: 600; font-size: 0.9rem;">Open Catalog &rarr;</a>
            </div>
        </div>

    </div>

</body>
</html>