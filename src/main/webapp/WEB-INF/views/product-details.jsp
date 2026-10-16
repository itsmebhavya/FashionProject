<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fashion Store - Product Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-details.css">
</head>
<body style="background-color: #121212; color: #e0e0e0; font-family: sans-serif; margin: 0;">

    <!-- Header Navbar -->
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <main class="product-details-page" style="padding: 40px 6%;">
        <div class="product-details-section">
            
            <!-- Main Product Card -->
            <div class="product-details-card" style="background-color: #1e1e1e; border-radius: 16px; padding: 40px; display: grid; grid-template-columns: 1fr 1fr; gap: 40px; align-items: center; box-shadow: 0 8px 24px rgba(0,0,0,0.5);">
                
                <!-- Product Image Box -->
                <div class="product-details-image" style="background-color: #2a2a2a; border-radius: 12px; display: flex; align-items: center; justify-content: center; overflow: hidden; min-height: 350px; position: relative;">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <c:choose>
                                <c:when test="${fn:contains(product.imageUrl, 'assets/images/products/')}">
                                    <c:set var="finalImgPath" value="${pageContext.request.contextPath}/${product.imageUrl}" />
                                </c:when>
                                <c:when test="${fn:startsWith(product.imageUrl, 'assets/')}">
                                    <c:set var="finalImgPath" value="${pageContext.request.contextPath}/${product.imageUrl}" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="cleanImgName" value="${fn:startsWith(product.imageUrl, '/') ? fn:substring(product.imageUrl, 1, fn:length(product.imageUrl)) : product.imageUrl}" />
                                    <c:set var="finalImgPath" value="${pageContext.request.contextPath}/assets/images/products/${cleanImgName}" />
                                </c:otherwise>
                            </c:choose>
                            
                            <img src="${finalImgPath}" alt="${product.productName}" style="width: 100%; height: 100%; object-fit: cover; display: block;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                            <span style="display: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 0.85rem; color: #ef4444; text-align: center; width: 100%; padding: 0 10px;">
                                Image missing: ${finalImgPath}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: #888; font-size: 1.2rem;">${product.productName}</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Product Details Content -->
                <div class="product-details-content">
                    <p style="color: #aaa; font-size: 0.9rem; margin-bottom: 8px;">${product.brand}</p>
                    <h1 style="color: #ffffff; font-size: 2.2rem; margin-bottom: 15px; font-weight: bold;">${product.productName}</h1>
                    <p style="font-size: 1.8rem; color: #ffffff; font-weight: bold; margin-bottom: 20px;">Rs. ${product.price}</p>
                    
                    <div style="margin-bottom: 20px;">
                        <h4 style="color: #bbb; font-size: 1rem; margin-bottom: 5px;">Description</h4>
                        <p style="color: #aaa; line-height: 1.5; font-size: 0.95rem;">${product.description}</p>
                    </div>

                    <!-- Available Sizes Selector -->
                    <div class="size-selector" style="margin-bottom: 20px;">
                        <h4 style="color: #fff; font-size: 1rem; margin-bottom: 10px;">Available Sizes</h4>
                        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                            <c:forEach var="variant" items="${variants}">
                                <button type="button" class="size-btn" data-variant-id="${variant.variantId}" 
                                    style="padding: 10px 18px; border: 1px solid #444; background: #2a2a2a; color: #fff; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.2s;">
                                    ${variant.size}
                                </button>
                            </c:forEach>
                        </div>
                    </div>

                    <p id="size-error" style="color: #e74c3c; font-size: 0.85rem; margin-bottom: 15px; display: none;">Please select a size to continue</p>
                    <p id="size-instruction" style="color: #777; font-size: 0.85rem; margin-bottom: 20px;">Select a size to continue</p>

                    <!-- Add to Cart Form -->
                    <form action="${pageContext.request.contextPath}/cart" method="POST" id="add-to-cart-form" style="display: inline-block; margin-right: 15px; margin-bottom: 15px;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="variantId" id="selectedVariantId" value="">

                        <!-- Quantity Selector -->
                        <div style="margin-bottom: 20px;">
                            <label for="quantity" style="display: block; color: #fff; font-size: 1rem; margin-bottom: 8px;">Quantity</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" 
                                   style="width: 90px; padding: 10px; background: #2a2a2a; border: 1px solid #444; color: #fff; border-radius: 8px; font-size: 1rem; outline: none;">
                        </div>

                        <button type="submit" id="submit-btn" style="background: #3498db; color: #fff; padding: 12px 28px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; font-size: 0.95rem;">
                            Add to Cart
                        </button>
                    </form>

                    <!-- Add to Wishlist Form -->
                    <form action="${pageContext.request.contextPath}/wishlist" method="POST" id="add-to-wishlist-form" style="display: inline-block; margin-bottom: 15px;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="variantId" id="wishlistVariantId" value="">
                        <button type="submit" style="background: transparent; color: #ef4444; border: 1px solid #ef4444; padding: 12px 20px; border-radius: 8px; font-weight: bold; cursor: pointer; font-size: 0.95rem; transition: all 0.2s;">
                            ❤ Add to Wishlist
                        </button>
                    </form>

                    <div>
                        <a href="${pageContext.request.contextPath}/products" style="background: transparent; color: #ccc; border: 1px solid #444; padding: 11px 20px; border-radius: 8px; text-decoration: none; font-size: 0.95rem; font-weight: 500; display: inline-block;">
                            Back to Products
                        </a>
                    </div>
                </div>
            </div>

            <!-- Related Products Section -->
            <section style="margin-top: 50px;">
                <h2 style="color: #fff; font-size: 1.6rem; margin-bottom: 20px;">Related Products</h2>
                
                <c:choose>
                    <c:when test="${not empty relatedProducts}">
                        <div style="display: flex; gap: 20px; flex-wrap: wrap;">
                            <c:forEach var="relProd" items="${relatedProducts}">
                                <div style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; padding: 15px; width: 200px; text-align: center;">
                                    
                                    <!-- Clickable Image Container -->
                                    <div style="background-color: #2a2a2a; height: 160px; border-radius: 8px; margin-bottom: 12px; overflow: hidden; position: relative;">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${relProd.productId}" style="display: block; width: 100%; height: 100%; text-decoration: none;">
                                            <c:choose>
                                                <c:when test="${fn:contains(relProd.imageUrl, 'assets/images/products/')}">
                                                    <c:set var="relFinalImgPath" value="${pageContext.request.contextPath}/${relProd.imageUrl}" />
                                                </c:when>
                                                <c:when test="${fn:startsWith(relProd.imageUrl, 'assets/')}">
                                                    <c:set var="relFinalImgPath" value="${pageContext.request.contextPath}/${relProd.imageUrl}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="cleanRelImgName" value="${fn:startsWith(relProd.imageUrl, '/') ? fn:substring(relProd.imageUrl, 1, fn:length(relProd.imageUrl)) : relProd.imageUrl}" />
                                                    <c:set var="relFinalImgPath" value="${pageContext.request.contextPath}/assets/images/products/${cleanRelImgName}" />
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <img src="${relFinalImgPath}" alt="${relProd.productName}" style="width: 100%; height: 100%; object-fit: cover; display: block;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                            <span style="display: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 0.75rem; color: #ef4444; text-align: center; width: 100%; padding: 0 5px;">
                                                Missing
                                            </span>
                                        </a>
                                    </div>

                                    <!-- Clickable Product Title -->
                                    <h4 style="font-size: 0.95rem; margin-bottom: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${relProd.productId}" style="color: #fff; text-decoration: none;">
                                            ${relProd.productName}
                                        </a>
                                    </h4>

                                    <p style="color: #bbb; font-weight: bold; margin-bottom: 12px; font-size: 0.9rem;">Rs. ${relProd.price}</p>
                                    
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${relProd.productId}" style="background: #3498db; color: #fff; padding: 6px 12px; text-decoration: none; border-radius: 6px; font-size: 0.8rem; display: inline-block;">View Details</a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p style="color: #777; font-style: italic;">No related products available.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/partials/footer.jsp" />

    <!-- Size Selection Script -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const sizeButtons = document.querySelectorAll(".size-btn");
            const variantIdInput = document.getElementById("selectedVariantId");
            const wishlistVariantIdInput = document.getElementById("wishlistVariantId");
            const sizeError = document.getElementById("size-error");
            const sizeInstruction = document.getElementById("size-instruction");
            const cartForm = document.getElementById("add-to-cart-form");
            const wishlistForm = document.getElementById("add-to-wishlist-form");

            sizeButtons.forEach(button => {
                button.addEventListener("click", function () {
                    sizeButtons.forEach(btn => {
                        btn.style.background = "#2a2a2a";
                        btn.style.borderColor = "#444";
                        btn.style.color = "#fff";
                    });

                    this.style.background = "#3498db";
                    this.style.borderColor = "#3498db";
                    this.style.color = "#fff";

                    const selectedId = this.getAttribute("data-variant-id");
                    variantIdInput.value = selectedId;
                    wishlistVariantIdInput.value = selectedId;
                    
                    sizeError.style.display = "none";
                    sizeInstruction.style.display = "block";
                    sizeInstruction.innerText = "Selected size ready";
                });
            });

            cartForm.addEventListener("submit", function (e) {
                if (!variantIdInput.value) {
                    e.preventDefault();
                    sizeError.style.display = "block";
                    sizeInstruction.style.display = "none";
                }
            });

            wishlistForm.addEventListener("submit", function (e) {
                if (!wishlistVariantIdInput.value) {
                    e.preventDefault();
                    sizeError.style.display = "block";
                    sizeInstruction.style.display = "none";
                }
            });
        });
    </script>
</body>
</html>