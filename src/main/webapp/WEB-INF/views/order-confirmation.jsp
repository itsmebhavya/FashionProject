<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - Fashion Project</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-confirmation.css">
</head>
<body class="order-confirmation-page">

    <main class="container">
        <section class="order-confirmation-section">
            <div class="confirmation-card" style="padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); background: #fff;">
                
                <h2 style="color: #28a745; margin-bottom: 10px;">Order Placed Successfully!</h2>
                <p style="color: #666; margin-bottom: 25px;">Thank you for shopping with us. Your order has been placed and is being processed.</p>

                <c:if test="${not empty order}">
                    <div class="order-meta" style="margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
                        <p><strong>Order ID:</strong> #${order.orderId}</p>
                        <p><strong>Order Date:</strong> ${order.orderDate}</p>
                        <p><strong>Payment Method:</strong> ${order.paymentMethod}</p>
                        <p><strong>Order Status:</strong> <span style="color: #ffc107; font-weight: bold;">${order.orderStatus}</span></p>
                        <p><strong>Total Amount:</strong> ₹${order.totalAmount}</p>
                    </div>

                    <div class="shipping-info" style="margin-bottom: 25px;">
                        <h4>Shipping Address</h4>
                        <p>${order.deliveryName}</p>
                        <p>${order.deliveryAddressLine1} ${order.deliveryAddressLine2}</p>
                        <p>${order.deliveryCity}, ${order.deliveryState} - ${order.deliveryPincode}</p>
                        <p>Country: ${order.deliveryCountry}</p>
                        <p>Phone: ${order.deliveryPhone}</p>
                    </div>

                    <h3>Ordered Items</h3>
                    <table style="width:100%; border-collapse: collapse; margin-top: 10px; margin-bottom: 25px; border: 1px solid #ddd;">
                        <tr style="background-color: #f8f9fa;">
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: center;">Product ID</th>
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: center;">Quantity</th>
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: center;">Price</th>
                        </tr>
                        <c:if test="${empty orderItems}">
                            <tr>
                                <td colspan="3" style="padding: 10px; border: 1px solid #ddd; text-align: center; color: #666;">No order items found.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="item" items="${orderItems}">
                            <tr>
                                <td style="padding: 10px; border: 1px solid #ddd; text-align: center;">${item.productId}</td>
                                <td style="padding: 10px; border: 1px solid #ddd; text-align: center;">${item.quantity}</td>
                                <td style="padding: 10px; border: 1px solid #ddd; text-align: center;">₹${item.price}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>

                <div class="confirmation-actions" style="display: flex; gap: 15px;">
                    <a href="<c:url value='/products' />" class="btn-primary" style="padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">Continue Shopping</a>
                    <a href="<c:url value='/home' />" class="btn-secondary" style="padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">Go to Home</a>
                </div>

            </div>
        </section>
    </main>

</body>
</html>