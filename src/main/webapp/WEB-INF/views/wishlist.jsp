<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Wishlist - Fashion Project</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #fcfbfa; font-family: 'Segoe UI', sans-serif; color: #2c2c2c; margin: 0; }
        .container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        h2 { font-family: Georgia, serif; font-size: 2.2rem; margin-bottom: 25px; border-bottom: 2px solid #ede8df; padding-bottom: 15px; }
        .wishlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 20px; }
        .wishlist-card { background: #fff; border: 1px solid #e8e2d5; border-radius: 10px; padding: 15px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.02); }
        .wishlist-card img { width: 100%; height: 260px; object-fit: cover; border-radius: 6px; border: 1px solid #e8e2d5; margin-bottom: 12px; }
        .btn-action { display: block; width: 100%; padding: 10px; border-radius: 6px; text-decoration: none; font-weight: 600; margin-top: 8px; cursor: pointer; }
        .btn-cart { background: #e05638; color: #fff; border: none; }
        .btn-remove { background: transparent; color: #dc2626; border: 1px solid #fca5a5; }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <div class="container">
        <h2>My Wishlist</h2>
        <c:if test="${empty wishlistItems}">
            <p style="color: #777; text-align: center; padding: 40px;">Your wishlist is empty. Save items while browsing!</p>
        </c:if>
        <div class="wishlist-grid">
            <c:forEach var="item" items="${wishlistItems}">
                <div class="wishlist-card">
                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.productName}">
                    <h4 style="margin: 5px 0; font-size: 1.05rem;">${item.productName}</h4>
                    <p style="color: #777; font-size: 0.9rem; margin: 5px 0;">Size: ${item.size} | ₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></p>
                    
                    <!-- Move to Cart Form -->
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="variantId" value="${item.variantId}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-action btn-cart"><i class="fa-solid fa-cart-shopping"></i> Move to Cart</button>
                    </form>

                    <!-- Remove Form -->
                    <form action="${pageContext.request.contextPath}/wishlist" method="get" style="margin-top: 5px;">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="wishlistId" value="${item.wishlistId}">
                        <button type="submit" class="btn-action btn-remove"><i class="fa-solid fa-trash"></i> Remove</button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>