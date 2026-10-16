<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <main class="container" style="max-width: 1200px; margin: 30px auto; padding: 0 20px;">
        <section class="checkout-section">
            <div class="checkout-header-card" style="background: #1e1e1e; padding: 25px; border-radius: 12px; margin-bottom: 20px; border: 1px solid #333;">
                <h2 style="color: #fff; margin: 0 0 5px 0;">Checkout</h2>
                <p style="color: #888; margin: 0;">Review your order and confirm your delivery details</p>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" style="background: #e74c3c; color: white; padding: 12px; border-radius: 6px; margin-bottom: 20px;">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: flex; gap: 30px; align-items: flex-start;">
                
                <!-- Left Column: Delivery Details Form Fields -->
                <div style="flex: 2; background: #1e1e1e; padding: 25px; border-radius: 12px; border: 1px solid #333;">
                    <h3 style="color: #fff; border-bottom: 1px solid #333; padding-bottom: 12px; margin-top: 0;">Delivery Details</h3>

                    <div style="margin-bottom: 15px;">
                        <label style="color: #ccc; display: block; margin-bottom: 5px;">Full Name</label>
                        <input type="text" name="deliveryName" value="${loggedInUser.name}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="color: #ccc; display: block; margin-bottom: 5px;">Phone</label>
                        <input type="text" name="deliveryPhone" value="${loggedInUser.phone}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="color: #ccc; display: block; margin-bottom: 5px;">Address Line 1</label>
                        <input type="text" name="deliveryAddressLine1" value="${loggedInUser.addressLine1}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="color: #ccc; display: block; margin-bottom: 5px;">Address Line 2</label>
                        <input type="text" name="deliveryAddressLine2" value="${loggedInUser.addressLine2}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;">
                    </div>

                    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
                        <div style="flex: 1;">
                            <label style="color: #ccc; display: block; margin-bottom: 5px;">City</label>
                            <input type="text" name="deliveryCity" value="${loggedInUser.city}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                        </div>
                        <div style="flex: 1;">
                            <label style="color: #ccc; display: block; margin-bottom: 5px;">State</label>
                            <input type="text" name="deliveryState" value="${loggedInUser.state}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                        </div>
                    </div>

                    <div style="display: flex; gap: 15px; margin-bottom: 20px;">
                        <div style="flex: 1;">
                            <label style="color: #ccc; display: block; margin-bottom: 5px;">Pincode</label>
                            <input type="text" name="deliveryPincode" value="${loggedInUser.pincode}" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                        </div>
                        <div style="flex: 1;">
                            <label style="color: #ccc; display: block; margin-bottom: 5px;">Country</label>
                            <input type="text" name="deliveryCountry" value="India" style="width: 100%; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 6px; box-sizing: border-box;" required>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div style="background: #252525; padding: 15px; border-radius: 8px; border: 1px solid #444;">
                        <h4 style="color: #fff; margin-top: 0; margin-bottom: 10px;">Payment Method</h4>
                        <label style="color: #ddd; display: block; margin-bottom: 8px; cursor: pointer;"><input type="radio" name="paymentMethod" value="UPI" checked style="margin-right: 8px;"> UPI / Online Payment</label>
                        <label style="color: #ddd; display: block; cursor: pointer;"><input type="radio" name="paymentMethod" value="COD" style="margin-right: 8px;"> Cash on Delivery</label>
                    </div>
                </div>

                <!-- Right Column: Order Summary Card with Thumbnails -->
                <div style="flex: 1; background: #1e1e1e; padding: 25px; border-radius: 12px; border: 1px solid #333;">
                    <h3 style="color: #fff; border-bottom: 1px solid #333; padding-bottom: 12px; margin-top: 0;">Order Summary</h3>

                    <div style="max-height: 280px; overflow-y: auto; margin-bottom: 15px;">
                        <c:forEach var="item" items="${cartItems}">
                            <div style="display: flex; align-items: center; justify-content: space-between; background: #252525; padding: 10px; border-radius: 8px; margin-bottom: 10px; border: 1px solid #444;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <c:choose>
                                                <c:when test="${fn:contains(item.imageUrl, 'assets/images/products/')}">
                                                    <c:set var="checkoutImgPath" value="${pageContext.request.contextPath}/${item.imageUrl}" />
                                                </c:when>
                                                <c:when test="${fn:startsWith(item.imageUrl, 'assets/')}">
                                                    <c:set var="checkoutImgPath" value="${pageContext.request.contextPath}/${item.imageUrl}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="cleanCheckoutImg" value="${fn:startsWith(item.imageUrl, '/') ? fn:substring(item.imageUrl, 1, fn:length(item.imageUrl)) : item.imageUrl}" />
                                                    <c:set var="checkoutImgPath" value="${pageContext.request.contextPath}/assets/images/products/${cleanCheckoutImg}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="checkoutImgPath" value="${pageContext.request.contextPath}/assets/images/placeholder.jpg" />
                                        </c:otherwise>
                                    </c:choose>

                                    <img src="${checkoutImgPath}" alt="${item.productName}" style="width: 45px; height: 45px; object-fit: cover; border-radius: 6px; background: #2a2a2a;" onerror="this.style.display='none';">
                                    
                                    <div>
                                        <span style="color: #fff; font-weight: 500; font-size: 13px; display: block;">${item.productName}</span>
                                        <small style="color: #aaa; font-size: 11px;">Qty: ${item.quantity} | Size: ${item.size}</small>
                                    </div>
                                </div>
                                <span style="color: #fff; font-weight: 600; font-size: 13px;">₹<fmt:formatNumber value="${item.price * item.quantity}" minFractionDigits="2"/></span>
                            </div>
                        </c:forEach>
                    </div>

                    <hr style="margin: 20px 0; border: 0; border-top: 1px solid #333;">

                    <div style="display: flex; justify-content: space-between; font-size: 18px; font-weight: bold; color: #fff; margin-bottom: 25px;">
                        <span>Total Amount</span>
                        <span>₹<fmt:formatNumber value="${cartTotal}" minFractionDigits="2"/></span>
                    </div>

                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <button type="submit" style="background: #27ae60; color: white; border: none; padding: 12px; border-radius: 6px; font-weight: bold; cursor: pointer; text-align: center;">Place Order</button>
                        <a href="${pageContext.request.contextPath}/cart?action=view" style="background: transparent; color: #ccc; border: 1px solid #444; padding: 10px; border-radius: 6px; text-decoration: none; text-align: center; font-size: 14px;">Back to Cart</a>
                    </div>
                </div>

            </form>
        </section>
    </main>

</body>
</html>