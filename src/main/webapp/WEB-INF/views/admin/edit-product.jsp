<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    com.fashionproject.model.User user = (com.fashionproject.model.User) session.getAttribute("loggedInUser");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login"); // Fixed from /login.jsp to /login
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-submit { background-color: #2c5e3b; color: white; padding: 10px 15px; border: none; cursor: pointer; }
        .btn-submit:hover { background-color: #1e3f26; }
    </style>
</head>
<body>
    <div class="container" style="max-width: 600px; margin-top: 30px;">
        <h2>Edit Product</h2>
        <a href="${pageContext.request.contextPath}/admin/products">&larr; Back to Products</a>
        <hr style="margin: 20px 0;">

        <form action="${pageContext.request.contextPath}/admin/edit-product" method="post">
            <input type="hidden" name="productId" value="${product.productId}">

            <div class="form-group">
                <label>Category:</label>
                <select name="categoryId" required>
                    <option value="">-- Select Category --</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.categoryId}" ${cat.categoryId == product.categoryId ? 'selected' : ''}>
                            ${cat.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>Product Name:</label>
                <input type="text" name="productName" value="${product.productName}" required>
            </div>

            <div class="form-group">
                <label>Brand:</label>
                <input type="text" name="brand" value="${product.brand}">
            </div>

            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" rows="4" required>${product.description}</textarea>
            </div>

            <div class="form-group">
                <label>Price (₹):</label>
                <input type="number" step="0.01" name="price" value="${product.price}" required>
            </div>

            <div class="form-group">
                <label>Color:</label>
                <input type="text" name="color" value="${product.color}" required>
            </div>

            <div class="form-group">
                <label>Image URL:</label>
                <input type="text" name="imageUrl" value="${product.imageUrl}" required>
            </div>

            <div class="form-group">
                <label>
                    <input type="checkbox" name="isActive" value="true" ${product.active ? 'checked' : ''}> Active Status
                </label>
            </div>

            <button type="submit" class="btn-submit">Update Product</button>
        </form>
    </div>
</body>
</html>