<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Register | Fashion Project</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

    <!-- Custom Luxury Warm Beige & Model Slider Styling (Warm Orange Theme) -->
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #fae5d3 0%, #fdebd0 50%, #f5cba7 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow-x: hidden;
            position: relative;
            padding: 20px 0;
        }

        body::before {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: rgba(226, 88, 62, 0.08);
            border-radius: 50%;
            top: -100px;
            left: -100px;
            z-index: 0;
            filter: blur(70px);
        }

        .auth-split-wrapper {
            position: relative;
            z-index: 1;
            display: flex;
            width: 1120px;
            max-width: 95%;
            background: #ffffff;
            border-radius: 28px;
            box-shadow: 0 30px 60px rgba(120, 80, 40, 0.15);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.8);
            margin: auto;
        }

        .auth-image-panel {
            flex: 1.15;
            position: relative;
            min-height: 700px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 45px;
            color: #ffffff;
        }

        .slider-slides {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center 20%;
            opacity: 0;
            transition: opacity 1.2s ease-in-out, transform 6s ease-out;
            transform: scale(1.05);
        }

        .slide.active {
            opacity: 1;
            transform: scale(1);
        }

        .auth-image-panel::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(180deg, rgba(15, 15, 15, 0.25) 0%, rgba(15, 15, 15, 0.75) 100%);
            z-index: 1;
        }

        .brand-badge {
            position: relative;
            z-index: 2;
            align-self: flex-start;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(12px);
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            border: 1px solid rgba(255, 255, 255, 0.4);
        }

        .brand-overlay-content {
            position: relative;
            z-index: 2;
        }

        .brand-overlay-content h2 {
            font-size: 34px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
            line-height: 1.2;
        }

        .brand-overlay-content p {
            font-size: 14px;
            color: #f3f4f6;
            line-height: 1.5;
            font-weight: 400;
            opacity: 0.95;
            margin-bottom: 20px;
        }

        .slider-dots {
            display: flex;
            gap: 8px;
        }

        .dot {
            width: 28px;
            height: 4px;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 2px;
            transition: all 0.4s ease;
        }

        .dot.active {
            background: #ffffff;
            width: 40px;
        }

        .auth-form-panel {
            flex: 1;
            padding: 40px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #ffffff;
            max-height: 750px;
            overflow-y: auto;
        }

        .auth-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 4px;
            letter-spacing: -0.5px;
        }

        .auth-form-group {
            margin-bottom: 12px;
        }

        .auth-form-group label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #374151;
            margin-bottom: 4px;
        }

        .auth-form-group input {
            width: 100%;
            padding: 10px 14px;
            font-size: 13px;
            border: 1.5px solid #e5e7eb;
            border-radius: 10px !important;
            outline: none;
            background-color: #f9fafb;
            transition: all 0.25s ease;
        }

        .auth-form-group input:focus {
            border-color: #e2583e !important;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(226, 88, 62, 0.15) !important;
        }

        .optional-label {
            font-weight: 400;
            color: #9ca3af;
            font-size: 11px;
        }

        /* Warm Orange Submit Button */
        .btn-primary.auth-submit-btn {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            font-weight: 700;
            color: #fff !important;
            background: linear-gradient(135deg, #e2583e 0%, #d84315 100%) !important;
            border: none !important;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 6px 15px rgba(226, 88, 62, 0.3) !important;
            margin-top: 5px;
        }

        .btn-primary.auth-submit-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(135deg, #d84315 0%, #bf360c 100%) !important;
            box-shadow: 0 10px 20px rgba(226, 88, 62, 0.4) !important;
        }

        /* Warm Orange Accent Links */
        .auth-form-panel a {
            color: #e2583e !important;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .auth-form-panel a:hover {
            color: #bf360c !important;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .auth-image-panel {
                display: none;
            }
            .auth-split-wrapper {
                max-width: 440px;
            }
            .auth-form-panel {
                padding: 35px 25px;
                max-height: none;
            }
        }
    </style>
</head>

<body>

<main>
    <div class="auth-split-wrapper">
        
        <div class="auth-image-panel">
            <div class="slider-slides">
                <div class="slide active" style="background-image: url('https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80');"></div>
            </div>

            <div class="brand-badge">Fashion Project</div>

            <div class="brand-overlay-content">
                <h2>Join Our Community</h2>
                <p>Create an account to track orders, manage your wishlist, and enjoy exclusive boutique offers.</p>
                
                <div class="slider-dots">
                    <div class="dot active"></div>
                    <div class="dot"></div>
                    <div class="dot"></div>
                </div>
            </div>
        </div>

        <div class="auth-form-panel">
            <div class="auth-header">
                <h1>Create Account</h1>
            </div>

            <p style="color: #6b7280; font-size: 0.85rem; margin-bottom: 18px;">
                Enter your details to get started with Fashion Project.
            </p>

            <c:if test="${not empty errorMessage}">
                <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 6px; margin-bottom: 15px; font-size: 0.85rem; text-align: center; border: 1px solid #f5c6cb;">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" class="auth-form" autocomplete="off">

                <div class="auth-form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" required maxlength="100" placeholder="Enter your full name">
                </div>

                <div class="auth-form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required maxlength="100" placeholder="Enter your email">
                </div>

                <div class="auth-form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required pattern=".{6,100}" title="Password must be at least 6 characters long" placeholder="Create a password">
                </div>

                <div class="auth-form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required maxlength="10" pattern="[0-9]{10}" placeholder="Enter 10-digit phone number">
                </div>

                <div class="auth-form-group">
                    <label for="addressLine1">Address</label>
                    <input type="text" id="addressLine1" name="addressLine1" required maxlength="255" placeholder="Enter your address">
                </div>

                <div class="auth-form-group">
                    <label for="addressLine2">Address Line 2 <span class="optional-label">(Optional)</span></label>
                    <input type="text" id="addressLine2" name="addressLine2" maxlength="255" placeholder="Apartment, landmark, etc.">
                </div>

                <div class="auth-form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" required maxlength="50" placeholder="Enter your city">
                </div>

                <div class="auth-form-group">
                    <label for="state">State</label>
                    <input type="text" id="state" name="state" required maxlength="50" placeholder="Enter your state">
                </div>

                <div class="auth-form-group">
                    <label for="pincode">Pincode</label>
                    <input type="text" id="pincode" name="pincode" required maxlength="6" pattern="[0-9]{6}" placeholder="Enter 6-digit pincode">
                </div>

                <button type="submit" class="btn-primary auth-submit-btn">Create Account</button>

                <div class="auth-footer-text" style="text-align: center; margin-top: 18px; font-size: 13px; color: #6b7280;">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
                </div>

            </form>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const slides = document.querySelectorAll('.slide');
        const dots = document.querySelectorAll('.dot');
        let currentSlide = 0;
        const totalSlides = slides.length;

        function nextSlide() {
            slides[currentSlide].classList.remove('active');
            dots[currentSlide].classList.remove('active');
            currentSlide = (currentSlide + 1) % totalSlides;
            slides[currentSlide].classList.add('active');
            dots[currentSlide].classList.add('active');
        }
        setInterval(nextSlide, 4000);
    });
</script>

</body>
</html>