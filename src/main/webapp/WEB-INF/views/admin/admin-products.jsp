<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Products - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-theme.css">
    <style>
        /* Additional structure and spacing fixes for the catalog table */
        .admin-main {
            padding: 30px;
            background-color: #fcf9f5;
            min-height: 100vh;
            box-sizing: border-box;
        }
        .admin-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
            padding: 20px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 25px;
        }
        .table-container {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
            border: 1px solid #eee;
        }
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.95rem;
            color: #333;
        }
        .admin-table th {
            background-color: #f7f2eb;
            color: #444;
            font-weight: 600;
            padding: 15px 20px;
            border-bottom: 2px solid #eae3d9;
        }
        .admin-table td {
            padding: 15px 20px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }
        .admin-table tr:hover {
            background-color: #faf7f2;
        }
        .product-thumb {
            width: 45px;
            height: 45px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #ddd;
        }
        .btn-primary {
            background-color: #ff6b35;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            transition: background 0.2s;
        }
        .btn-primary:hover {
            background-color: #e55a2b;
        }
        .badge-active {
            background-color: #e6f4ea;
            color: #137333;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <!-- Left Sidebar -->
    <div class="admin-sidebar">
        <a href="${pageContext.request.contextPath}/home" class="sidebar-brand">
            <span style="color: var(--accent-orange);">&#10022;</span> Fashion Project
        </a>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products" class="active">Catalog / Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders">Customer Orders</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Registered Users</a></li>
        </ul>
        <div>
            <a href="${pageContext.request.contextPath}/logout" style="color: #ff8b73; text-decoration: none; font-size: 0.9rem;">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="admin-main">
        <div class="admin-topbar">
            <div>
                <h2>Manage Product Catalog</h2>
                <p class="subtext" style="margin: 0; color: #666;">Browse and maintain your boutique inventory and stock items.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/add-product" class="btn-primary">+ Add New Product</a>
            </div>
        </div>

        <div class="table-container">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Product Name</th>
                        <th>Brand</th>
                        <th>Price</th>
                        <th>Color</th>
                        <th>Status</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${productList}">
                        <tr>
                            <td>${p.productId}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/${p.imageUrl}" alt="${p.productName}" class="product-thumb" />
                            </td>
                            <td><strong>${p.productName}</strong></td>
                            <td>${p.brand}</td>
                            <td>&#8377;${p.price}</td>
                            <td>${p.color}</td>
                            <td><span class="badge-active">Active</span></td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/edit-product?id=${p.productId}" class="btn-primary" style="padding: 6px 14px; font-size: 0.8rem;">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>