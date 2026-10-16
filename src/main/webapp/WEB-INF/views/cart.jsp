<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Bag - Fashion Project</title>
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Ultra-Clean Bright Boutique Background Styling -->
    <style>
        html, body.cart-body, body {
            /* Bright, subtle boutique background image with light white overlay */
            background: linear-gradient(rgba(252, 251, 250, 0.92), rgba(252, 251, 250, 0.94)), 
                        url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1920&auto=format&fit=crop') center/cover no-repeat fixed !important;
            color: #1a1a1a !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .cart-container {
            max-width: 1260px;
            margin: 40px auto;
            padding: 0 28px;
            position: relative;
            z-index: 1;
        }

        .cart-header-section {
            margin-bottom: 30px;
            border-bottom: 2px solid #ede8df;
            padding-bottom: 18px;
        }

        .cart-header-section h2 {
            color: #1a1a1a;
            font-family: Georgia, serif;
            font-size: 2.3rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .cart-header-section p {
            color: #666666;
            font-size: 1rem;
            margin: 0;
        }

        /* Clean White Shipping Banner */
        .shipping-banner {
            background: #ffffff !important;
            border: 1px solid #e8e2d5;
            border-left: 5px solid #e05638;
            padding: 16px 22px;
            border-radius: 12px;
            color: #1a1a1a;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 14px;
            font-size: 0.95rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
        }

        .cart-grid {
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 35px;
            align-items: start;
        }

        .cart-items-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Crisp Solid White Product Card */
        .cart-item-card {
            background: #ffffff !important;
            border: 1px solid #e8e2d5 !important;
            border-radius: 16px;
            padding: 24px;
            display: flex;
            gap: 24px;
            align-items: center;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.03);
            transition: all 0.25s ease;
        }

        .cart-item-card:hover {
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.07);
            border-color: #dcd4c5 !important;
            transform: translateY(-2px);
        }

        .item-img-wrapper img {
            width: 115px;
            height: 145px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #ede8df;
        }

        .item-details {
            flex-grow: 1;
        }

        .item-title {
            color: #1c1c1c;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .item-meta {
            color: #666666;
            font-size: 0.9rem;
            margin-bottom: 16px;
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .badge-size {
            background: #f7f4ed;
            padding: 4px 12px;
            border-radius: 6px;
            border: 1px solid #e8e2d5;
            color: #444444;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .item-unit-price {
            color: #666666;
            font-size: 0.9rem;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .qty-input {
            background: #f7f4ed;
            border: 1px solid #e8e2d5;
            color: #1a1a1a;
            padding: 7px 10px;
            border-radius: 6px;
            width: 55px;
            text-align: center;
            font-weight: 600;
        }

        .item-price-action {
            text-align: right;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 12px;
            min-width: 120px;
        }

        .item-subtotal {
            color: #1a1a1a;
            font-size: 1.35rem;
            font-weight: 700;
        }

        .btn-remove {
            background: transparent;
            border: 1px solid #fca5a5;
            color: #dc2626;
            padding: 7px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }

        .btn-remove:hover {
            background: #dc2626;
            color: #ffffff;
        }

        .cart-footer-actions {
            display: flex;
            justify-content: flex-start;
            margin-top: 5px;
        }

        .btn-clear-cart {
            background: #ffffff;
            border: 1px solid #e8e2d5;
            color: #666666;
            padding: 9px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-clear-cart:hover {
            border-color: #bbbbbb;
            color: #1a1a1a;
        }

        /* Solid White Summary Card */
        .cart-summary-card {
            background: #ffffff !important;
            border: 1px solid #e8e2d5 !important;
            border-radius: 18px;
            padding: 30px;
            position: sticky;
            top: 90px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.04);
        }

        .cart-summary-card h3 {
            color: #1a1a1a;
            font-family: Georgia, serif;
            font-size: 1.45rem;
            font-weight: 500;
            margin-top: 0;
            margin-bottom: 24px;
            border-bottom: 1px solid #ede8df;
            padding-bottom: 14px;
        }

        .promo-box {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
        }

        .promo-input {
            flex: 1;
            background: #f7f4ed;
            border: 1px solid #e8e2d5;
            color: #1a1a1a;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .promo-input:focus {
            outline: none;
            border-color: #e05638;
        }

        .btn-apply {
            background: #f7f4ed;
            color: #e05638;
            border: 1px solid #e8e2d5;
            padding: 0 18px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.2s;
        }

        .btn-apply:hover {
            background: #e8e2d5;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 16px;
            color: #666666;
            font-size: 0.95rem;
        }

        .summary-row.total-row {
            color: #1a1a1a;
            font-size: 1.3rem;
            font-weight: 700;
            border-top: 1px solid #ede8df;
            padding-top: 18px;
            margin-top: 10px;
        }

        .free-badge {
            color: #10b981;
            font-weight: 600;
            background: rgba(16, 185, 129, 0.1);
            padding: 3px 10px;
            border-radius: 6px;
        }

        .btn-checkout {
            display: block;
            background: #e05638;
            color: #ffffff;
            text-align: center;
            padding: 15px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1rem;
            margin-top: 24px;
            box-shadow: 0 4px 12px rgba(224, 86, 56, 0.25);
            transition: all 0.2s;
        }

        .btn-checkout:hover {
            background: #c8472c;
            transform: translateY(-1px);
        }

        .secure-checkout-note {
            text-align: center;
            color: #777777;
            font-size: 0.85rem;
            margin-top: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .continue-shopping-link {
            text-align: center;
            margin-top: 20px;
            border-top: 1px solid #ede8df;
            padding-top: 18px;
        }

        .continue-shopping-link a {
            color: #777777;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .continue-shopping-link a:hover {
            color: #e05638;
        }
    </style>
</head>
<body class="cart-body">

    <!-- Navbar Include -->
    <jsp:include page="navbar.jsp" />

    <div class="cart-container">
        <!-- Page Header -->
        <div class="cart-header-section">
            <h2>Your Shopping Bag</h2>
            <p>Curated style, ready for secure checkout.</p>
        </div>

        <c:if test="${empty cartItems}">
            <div class="empty-cart-state" style="text-align: center; padding: 70px 20px; background: #ffffff; border: 1px solid #e8e2d5; border-radius: 18px; box-shadow: 0 6px 20px rgba(0,0,0,0.03);">
                <div class="empty-icon-wrapper" style="font-size: 3.5rem; color: #e05638; margin-bottom: 20px;">
                    <i class="fa-solid fa-shirt"></i>
                </div>
                <h3 style="color: #1a1a1a; font-size: 1.5rem; margin-bottom: 10px;">Your shopping bag is empty</h3>
                <p style="color: #666666; margin-bottom: 25px;">Discover our latest seasonal arrivals and find your signature look.</p>
                <a href="${pageContext.request.contextPath}/products" style="display: inline-block; background: #e05638; color: #ffffff; padding: 12px 26px; border-radius: 8px; text-decoration: none; font-weight: 600;">Explore Collection</a>
            </div>
        </c:if>

        <c:if test="${not empty cartItems}">
            <!-- Free Shipping Progress Tracker -->
            <div class="shipping-banner">
                <i class="fa-solid fa-truck-fast" style="font-size: 1.2rem; color: #e05638;"></i>
                <span>You've unlocked <strong>Free Express Shipping</strong> on this order!</span>
            </div>

            <div class="cart-grid">
                <!-- Left: Items Container -->
                <div class="cart-items-list">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item-card">
                            <div class="item-img-wrapper">
                                <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.productName}" onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg'">
                            </div>
                            <div class="item-details">
                                <h3 class="item-title">${item.productName}</h3>
                                <div class="item-meta">
                                    <span class="badge-size">Size: <strong>${item.size}</strong></span>
                                    <span class="item-unit-price">Unit: ₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                                </div>
                                
                                <div class="quantity-control">
                                    <label for="qty-${item.cartItemId}" style="color: #666666; font-size: 0.9rem;">Qty:</label>
                                    <input type="number" id="qty-${item.cartItemId}" name="quantity" value="${item.quantity}" min="1" max="10" class="qty-input"
                                           onchange="updateQuantity(${item.cartItemId}, this.value)">
                                </div>
                            </div>
                            <div class="item-price-action">
                                <span class="item-subtotal" id="subtotal-${item.cartItemId}">₹<fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0.00"/></span>
                                
                                <!-- Working Remove Form passing cartItemId -->
                                <form action="${pageContext.request.contextPath}/cart" method="get" style="margin: 0; display: inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <button type="submit" class="btn-remove" title="Remove item">
                                        <i class="fa-solid fa-trash-can"></i> Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="cart-footer-actions">
                        <form action="${pageContext.request.contextPath}/cart" method="get">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn-clear-cart"><i class="fa-solid fa-trash"></i> Clear Entire Bag</button>
                        </form>
                    </div>
                </div>

                <!-- Right: Order Summary Sticky Card -->
                <div class="cart-summary-card">
                    <h3>Order Summary</h3>
                    
                    <div class="promo-box">
                        <input type="text" placeholder="Promo code" class="promo-input">
                        <button type="button" class="btn-apply">Apply</button>
                    </div>

                    <div class="summary-row">
                        <span>Bag Subtotal</span>
                        <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span class="free-badge">FREE</span>
                    </div>
                    <div class="summary-row total-row">
                        <span>Total Amount</span>
                        <span id="cart-grand-total">₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">
                        Proceed to Secure Checkout <i class="fa-solid fa-arrow-right" style="margin-left: 6px;"></i>
                    </a>

                    <div class="secure-checkout-note">
                        <i class="fa-solid fa-shield-halved" style="color: #e05638;"></i> Safe &amp; Secure SSL Encrypted Checkout
                    </div>
                    
                    <div class="continue-shopping-link">
                        <a href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-arrow-left"></i> Continue Shopping</a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- AJAX Quantity Update Script -->
    <script>
    function updateQuantity(cartItemId, quantity) {
        if (quantity < 1) return;

        const xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/cart", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        document.getElementById("subtotal-" + cartItemId).innerText = "₹" + response.itemSubtotal;
                        document.getElementById("cart-grand-total").innerText = "₹" + response.cartTotal;
                    } else {
                        alert("Failed to update cart quantity.");
                    }
                } catch (e) {
                    console.error("Error parsing JSON response", e);
                }
            }
        };

        xhr.send("action=update&ajax=true&cartItemId=" + encodeURIComponent(cartItemId) + "&quantity=" + encodeURIComponent(quantity));
    }
    </script>
</body>
</html>