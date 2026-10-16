<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Add Product - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-theme.css" />
</head>
<body>

    <!-- Left Sidebar -->
    <div class="admin-sidebar">
        <div>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-brand">
                <span style="color: var(--accent-orange);">&#10022;</span> Fashion Project
            </a>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products" class="active">Catalog / Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Customer Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Registered Users</a></li>
            </ul>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="admin-main">
        
        <!-- Top Bar -->
        <div class="admin-topbar">
            <div>
                <h2>Add New Product</h2>
                <p class="subtext" style="margin: 0;">Fill in the details below to list a new clothing item or accessory.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-secondary">&larr; Back to Catalog</a>
            </div>
        </div>

        <!-- Form Card Container -->
        <div style="padding: 32px; max-width: 800px; margin: 0 auto; background: #fff; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); border: 1px solid var(--border-color);">
            
            <form action="${pageContext.request.contextPath}/admin/add-product" method="post">
                
                <!-- Category Selection -->
                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Category</label>
                    <select name="categoryId" required style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;">
                        <option value="">Select a Category</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Product Name -->
                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Product Name</label>
                    <input type="text" name="productName" required placeholder="e.g., Floral Summer Dress" style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;" />
                </div>

                <!-- Brand & Color Row -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Brand</label>
                        <input type="text" name="brand" placeholder="e.g., Urban Chic" style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;" />
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Color</label>
                        <input type="text" name="color" placeholder="e.g., Coral / Blue" style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;" />
                    </div>
                </div>

                <!-- Price -->
                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Price (&#8377;)</label>
                    <input type="number" step="0.01" name="price" required placeholder="2499.00" style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;" />
                </div>

                <!-- Image URL -->
                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Image Path / URL</label>
                    <input type="text" name="imageUrl" placeholder="/assets/images/products/item.jpg" style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit;" />
                </div>

                <!-- Description -->
                <div style="margin-bottom: 30px;">
                    <label style="display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; color: #3f4254;">Description</label>
                    <textarea name="description" rows="4" placeholder="Enter product fabric, care instructions, and fit details..." style="width: 100%; padding: 12px; border: 1px solid #e4e6ef; border-radius: 8px; background: #fff; font-family: inherit; resize: vertical;"></textarea>
                </div>

                <!-- Submit Button -->
                <div style="display: flex; justify-content: flex-end; gap: 12px;">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn-secondary">Cancel</a>
                    <button type="submit" style="padding: 12px 30px; border: none; border-radius: 8px; background: #181c32; color: white; font-weight: 600; cursor: pointer; transition: background 0.2s;">Save Product</button>
                </div>

            </form>

        </div>

    </div>

</body>
</html>