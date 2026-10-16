<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fffcf9; color: #3f4254; margin: 40px; }
        .container { max-width: 800px; margin: auto; background: #fff; padding: 30px; border-radius: 12px; border: 1px solid #f0e6d6; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        h2 { margin-top: 0; color: #181c32; }
        .back-btn { display: inline-block; margin-bottom: 20px; text-decoration: none; color: #ff6b35; font-weight: 600; }
        .detail-row { margin-bottom: 15px; font-size: 0.95rem; }
        .detail-row strong { width: 160px; display: inline-block; color: #5e6278; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/orders" class="back-btn">&larr; Back to Orders</a>
        <h2>Order Details: #ORD-${order.orderId}</h2>
        
        <div class="detail-row"><strong>Customer Name:</strong> ${order.deliveryName}</div>
        <div class="detail-row"><strong>Total Amount:</strong> &#8377;${order.totalAmount}</div>
        <div class="detail-row"><strong>Payment Method:</strong> ${order.paymentMethod}</div>
        <div class="detail-row"><strong>Status:</strong> ${order.orderStatus}</div>
        <div class="detail-row"><strong>Shipping Address:</strong> ${order.deliveryAddressLine1}, ${order.deliveryCity}, ${order.deliveryState} - ${order.deliveryPincode}</div>
    </div>
</body>
</html>