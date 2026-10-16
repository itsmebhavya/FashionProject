<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Features - Fashion Project</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;1,400&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Shop Theme -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/shop-theme.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background: #f7f4ee;
            color: #1a1a1a;
            font-family: 'Inter', sans-serif;
        }

        .features-page {
            max-width: 1200px;
            margin: auto;
            padding: 30px 20px 80px;
        }

        /* HERO */

        .features-hero {
            position: relative;
            text-align: center;
            padding: 70px 20px 60px;
            overflow: hidden;
        }

        .hero-small {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 999px;
            background: #ffffff;
            color: #e05638;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.04);
            margin-bottom: 25px;
        }

        .hero-small i {
            font-size: 11px;
        }

        .features-hero h1 {
            margin: 0 auto 20px;
            max-width: 800px;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: clamp(42px, 6vw, 76px);
            font-weight: 400;
            line-height: 1.05;
            letter-spacing: -0.03em;
        }

        .features-hero h1 em {
            color: #e05638;
            font-weight: 400;
        }

        .features-hero p {
            max-width: 570px;
            margin: 0 auto;
            color: #6f6d6a;
            font-size: 15px;
            line-height: 1.7;
        }

        .hero-circle {
            position: absolute;
            border-radius: 50%;
            pointer-events: none;
            z-index: -1;
        }

        .circle-one {
            width: 180px;
            height: 180px;
            background: rgba(224, 86, 56, 0.06);
            left: -80px;
            top: 30px;
        }

        .circle-two {
            width: 240px;
            height: 240px;
            background: rgba(255, 255, 255, 0.8);
            right: -110px;
            bottom: 0;
        }

        /* FEATURE GRID */

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .feature-card {
            position: relative;
            background: #ffffff;
            border-radius: 28px;
            padding: 32px;
            min-height: 310px;
            overflow: hidden;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.045);
            transition: transform 0.3s ease, box-shadow 0.3s ease;

            cursor: pointer;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.09);
        }

        .feature-number {
            position: absolute;
            top: 25px;
            right: 28px;
            color: #dedbd5;
            font-size: 14px;
            font-weight: 600;
        }

        .feature-icon {
            width: 58px;
            height: 58px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f7f4ee;
            border-radius: 18px;
            color: #e05638;
            font-size: 22px;
            margin-bottom: 28px;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            background: #e05638;
            color: #ffffff;
            transform: rotate(-5deg);
        }

        .feature-card h3 {
            margin: 0 0 12px;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 26px;
            font-weight: 400;
        }

        .feature-card p {
            margin: 0;
            color: #77736f;
            font-size: 14px;
            line-height: 1.7;
        }

        .feature-link {
            position: absolute;
            left: 32px;
            bottom: 28px;
            color: #1a1a1a;
            font-size: 13px;
            font-weight: 600;
        }

        .feature-link span {
            color: #e05638;
            margin-left: 5px;
            transition: margin-left 0.2s ease;
        }

        .feature-card:hover .feature-link span {
            margin-left: 10px;
        }

        /* SPOTLIGHT */

        .spotlight {
            margin-top: 25px;
            background: #1a1a1a;
            color: #ffffff;
            border-radius: 32px;
            padding: 50px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        .spotlight-content {
            position: relative;
            z-index: 2;
        }

        .spotlight-label {
            color: #e05638;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        .spotlight h2 {
            margin: 0 0 18px;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 42px;
            font-weight: 400;
            line-height: 1.15;
        }

        .spotlight p {
            margin: 0;
            max-width: 480px;
            color: #bcbab6;
            font-size: 14px;
            line-height: 1.8;
        }

        .spotlight-visual {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            position: relative;
            z-index: 2;
        }

        .visual-box {
            height: 190px;
            border-radius: 22px;
            background: #292929;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease;

            cursor: pointer;
        }

        .visual-box:hover {
            transform: translateY(-6px);
        }

        .visual-box i {
            font-size: 46px;
            color: #e05638;
        }

        .visual-box:nth-child(2) {
            margin-top: 35px;
        }

        .visual-box:nth-child(3) {
            margin-top: -35px;
        }

        .visual-box span {
            display: block;
            margin-top: 10px;
            font-size: 11px;
            color: #aaa;
        }

        /* WHY CHOOSE US */

        .why-section {
            margin-top: 80px;
        }

        .section-heading {
            text-align: center;
            margin-bottom: 35px;
        }

        .section-heading > span {
            color: #e05638;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.12em;
            text-transform: uppercase;
        }

        .section-heading h2 {
            margin: 10px 0 12px;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 42px;
            font-weight: 400;
        }

        .section-heading p {
            max-width: 500px;
            margin: auto;
            color: #77736f;
            font-size: 14px;
            line-height: 1.6;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
        }

        .benefit {
            background: #ffffff;
            border-radius: 22px;
            padding: 28px 20px;
            text-align: center;
            transition: transform 0.3s ease;

            cursor: pointer;
        }

        .benefit:hover {
            transform: translateY(-5px);
        }

        .benefit i {
            color: #e05638;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .benefit h4 {
            margin: 0 0 8px;
            font-size: 14px;
            font-weight: 600;
        }

        .benefit p {
            margin: 0;
            color: #888;
            font-size: 12px;
            line-height: 1.6;
        }

        /* CTA */

        .features-cta {
            margin-top: 70px;
            text-align: center;
            background: #ffffff;
            border-radius: 32px;
            padding: 55px 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.04);
        }

        .features-cta h2 {
            margin: 0 0 12px;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 40px;
            font-weight: 400;
        }

        .features-cta p {
            margin: 0 auto 25px;
            max-width: 450px;
            color: #77736f;
            font-size: 14px;
            line-height: 1.6;
        }

        .cta-button {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #e05638;
            color: #ffffff;
            padding: 13px 28px;
            border-radius: 999px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            box-shadow: 0 8px 22px rgba(224, 86, 56, 0.25);
            transition: all 0.3s ease;
        }

        .cta-button:hover {
            background: #1a1a1a;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        /* RESPONSIVE */

        @media (max-width: 900px) {

            .feature-grid {
                grid-template-columns: 1fr 1fr;
            }

            .spotlight {
                grid-template-columns: 1fr;
            }

            .benefits-grid {
                grid-template-columns: 1fr 1fr;
            }

        }

        @media (max-width: 600px) {

            .features-page {
                padding: 15px 15px 60px;
            }

            .features-hero {
                padding: 50px 10px 40px;
            }

            .features-hero h1 {
                font-size: 42px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .feature-card {
                min-height: 280px;
            }

            .spotlight {
                padding: 32px 25px;
                border-radius: 25px;
            }

            .spotlight h2 {
                font-size: 32px;
            }

            .spotlight-visual {
                grid-template-columns: 1fr 1fr;
            }

            .visual-box {
                height: 140px;
            }

            .benefits-grid {
                grid-template-columns: 1fr 1fr;
            }

            .section-heading h2 {
                font-size: 34px;
            }

            .features-cta {
                padding: 40px 20px;
            }

            .features-cta h2 {
                font-size: 32px;
            }

        }

    </style>

</head>

<body>

    <!-- Navigation -->
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <main class="features-page">

        <!-- HERO -->

        <section class="features-hero">

            <div class="hero-circle circle-one"></div>

            <div class="hero-circle circle-two"></div>

            <div class="hero-small">
                <i class="fa-solid fa-wand-magic-sparkles"></i>
                Fashion Project
            </div>

            <h1>
                Everything you need
                <br>
                for your <em>perfect style.</em>
            </h1>

            <p>
                From discovering new styles to placing your order,
                Fashion Project brings together a simple, stylish
                and seamless shopping experience.
            </p>

        </section>


        <!-- MAIN FEATURES -->

        <section class="feature-grid">

            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/products">

                <span class="feature-number">01</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-shirt"></i>
                </div>

                <h3>Endless Style</h3>

                <p>
                    Explore carefully selected collections for men,
                    women, kids and accessories. Find something
                    that fits your personality and everyday style.
                </p>

                <span class="feature-link">
                    Explore Collection
                    <span>→</span>
                </span>

            </div>


            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/products">

                <span class="feature-number">02</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-filter"></i>
                </div>

                <h3>Find It Faster</h3>

                <p>
                    Search products easily and discover exactly
                    what you need using categories, price ranges,
                    sorting and product filters.
                </p>

                <span class="feature-link">
                    Start Shopping
                    <span>→</span>
                </span>

            </div>


            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/cart">

                <span class="feature-number">03</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-cart-shopping"></i>
                </div>

                <h3>Easy Shopping</h3>

                <p>
                    Add your favourite products to the cart,
                    manage quantities and continue smoothly
                    from shopping to checkout.
                </p>

                <span class="feature-link">
                    View Cart
                    <span>→</span>
                </span>

            </div>


            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/products">

                <span class="feature-number">04</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>

                <h3>Secure Checkout</h3>

                <p>
                    Complete your purchase through a structured
                    checkout process with customer details,
                    delivery information and payment options.
                </p>

                <span class="feature-link">
                    Shop Securely
                    <span>→</span>
                </span>

            </div>


            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/products">

                <span class="feature-number">05</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-credit-card"></i>
                </div>

                <h3>Flexible Payments</h3>

                <p>
                    Choose a convenient payment method during
                    checkout and enjoy a simple and organized
                    order placement experience.
                </p>

                <span class="feature-link">
                    Discover More
                    <span>→</span>
                </span>

            </div>


            <div class="feature-card"
                 data-url="${pageContext.request.contextPath}/products">

                <span class="feature-number">06</span>

                <div class="feature-icon">
                    <i class="fa-solid fa-truck-fast"></i>
                </div>

                <h3>Order Tracking</h3>

                <p>
                    Stay updated with your order journey from
                    confirmation and processing to shipping
                    and final delivery.
                </p>

                <span class="feature-link">
                    Start Your Journey
                    <span>→</span>
                </span>

            </div>

        </section>


        <!-- SPOTLIGHT -->

        <section class="spotlight">

            <div class="spotlight-content">

                <div class="spotlight-label">
                    Designed for you
                </div>

                <h2>
                    Shopping should feel
                    effortless.
                </h2>

                <p>
                    Fashion Project combines a clean shopping
                    experience with practical features that help
                    you discover products, manage your cart,
                    complete checkout and follow your order.
                </p>

            </div>


            <div class="spotlight-visual">

                <div class="visual-box"
                     data-url="${pageContext.request.contextPath}/products">

                    <div>
                        <i class="fa-solid fa-magnifying-glass"></i>

                        <span>Discover</span>
                    </div>

                </div>


                <div class="visual-box"
                     data-url="${pageContext.request.contextPath}/products">

                    <div>
                        <i class="fa-solid fa-bag-shopping"></i>

                        <span>Shop</span>
                    </div>

                </div>


                <div class="visual-box"
                     data-url="${pageContext.request.contextPath}/cart">

                    <div>
                        <i class="fa-solid fa-box"></i>

                        <span>Receive</span>
                    </div>

                </div>


                <div class="visual-box"
                     data-url="${pageContext.request.contextPath}/products">

                    <div>
                        <i class="fa-solid fa-heart"></i>

                        <span>Enjoy</span>
                    </div>

                </div>

            </div>

        </section>


        <!-- WHY CHOOSE US -->

        <section class="why-section">

            <div class="section-heading">

                <span>Why Fashion Project?</span>

                <h2>Made for modern shoppers.</h2>

                <p>
                    Every part of the experience is designed
                    to make fashion shopping simple, clear
                    and enjoyable.
                </p>

            </div>


            <div class="benefits-grid">

                <div class="benefit"
                     data-url="${pageContext.request.contextPath}/products">

                    <i class="fa-solid fa-bolt"></i>

                    <h4>Simple Experience</h4>

                    <p>
                        Clean navigation makes shopping easier.
                    </p>

                </div>


                <div class="benefit"
                     data-url="${pageContext.request.contextPath}/products">

                    <i class="fa-solid fa-mobile-screen"></i>

                    <h4>Responsive Design</h4>

                    <p>
                        Comfortable experience across devices.
                    </p>

                </div>


                <div class="benefit"
                     data-url="${pageContext.request.contextPath}/cart">

                    <i class="fa-solid fa-box-open"></i>

                    <h4>Order Management</h4>

                    <p>
                        Keep your shopping journey organized.
                    </p>

                </div>


                <div class="benefit"
                     data-url="${pageContext.request.contextPath}/products">

                    <i class="fa-solid fa-headset"></i>

                    <h4>Customer Focused</h4>

                    <p>
                        Designed around a smooth user journey.
                    </p>

                </div>

            </div>

        </section>


        <!-- CTA -->

        <section class="features-cta">

            <h2>
                Ready to find your style?
            </h2>

            <p>
                Explore our collection and discover
                something made for your wardrobe.
            </p>

            <a href="${pageContext.request.contextPath}/products"
               class="cta-button">

                Explore All Products

                <i class="fa-solid fa-arrow-right"></i>

            </a>

        </section>

    </main>


    <!-- CARD CLICK SCRIPT -->

    <script>

        document.querySelectorAll('.feature-card[data-url], .visual-box[data-url], .benefit[data-url]')
            .forEach(function(card) {

                card.addEventListener('click', function() {

                    window.location.href = card.getAttribute('data-url');

                });

            });

    </script>

</body>

</html>