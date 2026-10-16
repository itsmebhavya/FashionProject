<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        /* Light Fashion Boutique Rack Background */
        body {
            background: linear-gradient(rgba(255, 255, 255, 0.88), rgba(255, 255, 255, 0.92)), 
                        url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1920&auto=format&fit=crop') center/cover no-repeat fixed !important;
            color: #2c3e50 !important;
            margin: 0;
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
        }

        .orders-container { 
            max-width: 1000px; 
            margin: 40px auto; 
            padding: 0 20px; 
        }

        /* Glassmorphism Light Card */
        .order-card { 
            background: rgba(255, 255, 255, 0.85) !important; 
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(220, 225, 230, 0.8) !important; 
            border-radius: 14px; 
            padding: 24px; 
            margin-bottom: 25px; 
            color: #2c3e50; 
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }

        .order-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            border-bottom: 1px solid #eef2f5; 
            padding-bottom: 14px; 
            margin-bottom: 18px; 
        }

        .status-badge { 
            padding: 6px 14px; 
            border-radius: 20px; 
            font-size: 11px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.5px;
        }
        .status-processing { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .status-shipped { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .status-delivered { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .status-cancelled { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        
        /* Order Items Styling */
        .order-item-row { 
            display: flex; 
            align-items: center; 
            gap: 16px; 
            background: #ffffff !important; 
            padding: 14px; 
            border-radius: 10px; 
            margin-bottom: 12px; 
            border: 1px solid #eef2f5;
            box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        }
        .order-item-row img { 
            width: 65px; 
            height: 65px; 
            object-fit: cover; 
            border-radius: 8px; 
            border: 1px solid #e2e8f0; 
            transition: transform 0.2s ease; 
        }
        .order-item-row img:hover { transform: scale(1.06); }
        .order-item-info { flex: 1; }
        .order-item-info h4 { margin: 0 0 6px 0; font-size: 15px; }
        .order-item-info h4 a { color: #2c3e50; text-decoration: none; font-weight: 600; transition: color 0.2s; }
        .order-item-info h4 a:hover { color: #3498db; text-decoration: underline; }
        .order-item-info p { margin: 0; font-size: 13px; color: #7f8c8d; }

        .order-details-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); 
            gap: 15px; 
            font-size: 13px; 
            color: #7f8c8d; 
            margin-top: 18px; 
            border-top: 1px solid #eef2f5; 
            padding-top: 16px; 
        }
        .order-details-grid strong { color: #2c3e50; }
        
        .no-orders { text-align: center; padding: 50px; background: rgba(255,255,255,0.9); border-radius: 12px; border: 1px solid #eef2f5; color: #7f8c8d; }
        .btn-shop { display: inline-block; margin-top: 15px; background: #3498db; color: white; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: bold; }
        .btn-shop:hover { background: #2980b9; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <main class="orders-container">
        <h2 style="margin-bottom: 25px; border-left: 4px solid #3498db; padding-left: 12px; font-weight: 700; color: #2c3e50;">My Order History</h2>

        <c:choose>
            <c:when test="${not empty userOrders}">
                <c:forEach var="order" items="${userOrders}">
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <span style="font-size: 16px; font-weight: bold; color: #2980b9;">Order #${order.orderId}</span>
                                <span style="margin-left: 15px; color: #7f8c8d; font-size: 13px;">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                </span>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${order.orderStatus == 'Processing'}">
                                        <span class="status-badge status-processing">${order.orderStatus}</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 'Shipped'}">
                                        <span class="status-badge status-shipped">${order.orderStatus}</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 'Delivered'}">
                                        <span class="status-badge status-delivered">${order.orderStatus}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-cancelled">${order.orderStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Product Items List with Smart Dynamic Product Links -->
                        <div class="order-items-list">
                            <c:forEach var="item" items="${order.orderItems}">
                                <c:set var="productUrl" value="${item.productId > 0 ? pageContext.request.contextPath.concat('/product?id=').concat(item.productId) : pageContext.request.contextPath.concat('/products')}" />
                                
                                <div class="order-item-row">
                                    <a href="${productUrl}">
                                        <img src="${not empty item.imageUrl ? item.imageUrl : pageContext.request.contextPath.concat('/assets/images/placeholder.jpg')}" alt="${item.productName}">
                                    </a>
                                    <div class="order-item-info">
                                        <h4>
                                            <a href="${productUrl}">
                                                ${not empty item.productName ? item.productName : 'Fashion Item'}
                                            </a>
                                        </h4>
                                        <p>Qty: ${item.quantity} &nbsp;|&nbsp; Price: ₹<fmt:formatNumber value="${item.price}" minFractionDigits="2"/></p>
                                    </div>
                                    <div style="font-weight: bold; color: #27ae60; font-size: 15px;">
                                        ₹<fmt:formatNumber value="${item.price * item.quantity}" minFractionDigits="2"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="order-details-grid">
                            <div>
                                <p style="margin: 0 0 4px 0;">Total Amount</p>
                                <strong style="font-size: 15px;">₹<fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2"/></strong>
                            </div>
                            <div>
                                <p style="margin: 0 0 4px 0;">Payment Method</p>
                                <strong>${order.paymentMethod}</strong>
                            </div>
                            <div>
                                <p style="margin: 0 0 4px 0;">Shipping Address</p>
                                <strong>${order.deliveryAddressLine1}, ${order.deliveryCity}, ${order.deliveryState} - ${order.deliveryPincode}</strong>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-orders">
                    <h3>You haven't placed any orders yet!</h3>
                    <p>Explore our latest catalog and treat yourself to something stylish.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn-shop">Start Shopping</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>