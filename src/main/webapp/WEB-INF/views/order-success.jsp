<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fcf8f5;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }
        .success-container {
            background: #ffffff;
            width: 100%;
            max-width: 750px;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
            box-sizing: border-box;
        }
        .success-title {
            color: #2c5e3b;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .order-meta {
            font-size: 14px;
            color: #666;
            margin-bottom: 25px;
        }
        .tracker {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 30px 0;
            position: relative;
        }
        .step {
            text-align: center;
            position: relative;
            z-index: 1;
            flex: 1;
        }
        .step-circle {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #2c5e3b;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            margin: 0 auto 8px;
        }
        .step.pending .step-circle {
            background: #e0e0e0;
            color: #888;
        }
        .step-text {
            font-size: 12px;
            color: #444;
            font-weight: 500;
        }
        .success-message {
            color: #555;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        /* Product Summary Box */
        .order-summary-box {
            text-align: left;
            background: #faf7f2;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        .order-summary-title {
            font-size: 15px;
            font-weight: 600;
            color: #333;
            margin-bottom: 12px;
        }
        .purchased-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #ffffff;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 8px;
            border: 1px solid #eee;
        }
        .item-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .item-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
            background: #f0f0f0;
            transition: transform 0.2s;
        }
        .item-img:hover {
            transform: scale(1.05);
        }
        .item-name-link {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }
        .item-name-link:hover {
            color: #0066ff;
            text-decoration: underline;
        }
        .item-price {
            font-weight: 600;
            color: #2c5e3b;
            font-size: 14px;
        }

        .buttons-row {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s, transform 0.1s;
        }
        .btn:active {
            transform: scale(0.98);
        }
        .btn-primary {
            background-color: #0066ff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0052cc;
        }
        .btn-secondary {
            background-color: transparent;
            color: #0066ff;
            border: 1px solid #0066ff;
        }
        .btn-secondary:hover {
            background-color: #f0f6ff;
        }
    </style>
</head>
<body>

    <!-- Include Navigation Bar -->
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <div class="main-content">
        <div class="success-container">
            <h1 class="success-title">Order Placed Successfully! 🎉</h1>
            <div class="order-meta">Fashion Project &bull; Secure Checkout</div>

            <!-- Progress Tracker -->
            <div class="tracker">
                <div class="step">
                    <div class="step-circle">✓</div>
                    <div class="step-text">Placed</div>
                </div>
                <div class="step">
                    <div class="step-circle">✓</div>
                    <div class="step-text">Processing</div>
                </div>
                <div class="step">
                    <div class="step-circle">🚚</div>
                    <div class="step-text"><b>Shipped</b></div>
                </div>
                <div class="step pending">
                    <div class="step-circle">4</div>
                    <div class="step-text">Delivered</div>
                </div>
            </div>

            <p class="success-message">
                Thank you for shopping with <strong>Fashion Project</strong>. Your order has been placed successfully and is currently being processed by our team.
            </p>

            <!-- Dynamically Display Ordered Products -->
            <div class="order-summary-box">
                <div class="order-summary-title">Items in this Order</div>
                
                <c:choose>
                    <c:when test="${not empty orderItems}">
                        <c:forEach var="item" items="${orderItems}">
                            <div class="purchased-item">
                                <div class="item-info">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}">
                                        <c:choose>
                                            <c:when test="${not empty item.imageUrl}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(item.imageUrl, 'assets/images/products/')}">
                                                        <c:set var="orderImgPath" value="${pageContext.request.contextPath}/${item.imageUrl}" />
                                                    </c:when>
                                                    <c:when test="${fn:startsWith(item.imageUrl, 'assets/')}">
                                                        <c:set var="orderImgPath" value="${pageContext.request.contextPath}/${item.imageUrl}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="cleanOrderImg" value="${fn:startsWith(item.imageUrl, '/') ? fn:substring(item.imageUrl, 1, fn:length(item.imageUrl)) : item.imageUrl}" />
                                                        <c:set var="orderImgPath" value="${pageContext.request.contextPath}/assets/images/products/${cleanOrderImg}" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="orderImgPath" value="${pageContext.request.contextPath}/assets/images/placeholder.jpg" />
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <img src="${orderImgPath}" alt="${item.productName}" class="item-img" onerror="this.style.display='none';">
                                    </a>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}" class="item-name-link">${item.productName}</a>
                                        <div style="font-size: 12px; color: #777;">Qty: ${item.quantity} | Size: ${item.size}</div>
                                    </div>
                                </div>
                                <div class="item-price">₹<fmt:formatNumber value="${item.price * item.quantity}" minFractionDigits="2"/></div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="padding: 10px; font-size: 13px; color: #666; text-align: center;">
                            Your order was placed successfully!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Navigation Buttons -->
            <div class="buttons-row">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Continue Shopping</a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Go to Home</a>
            </div>
        </div>
    </div>

</body>
</html>