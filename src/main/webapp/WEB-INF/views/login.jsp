<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login - Fashion Project</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

    <!-- Creative High-Fashion Ambient Mesh Background & Styling -->
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: #fbf5f0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow-x: hidden;
            position: relative;
        }

        body::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                linear-gradient(rgba(226, 88, 62, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(226, 88, 62, 0.03) 1px, transparent 1px);
            background-size: 40px 40px;
            z-index: 0;
            pointer-events: none;
        }

        .bg-orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            z-index: 0;
            animation: floatOrb 12s infinite alternate ease-in-out;
        }

        .bg-orb-1 {
            width: 550px;
            height: 550px;
            background: rgba(226, 88, 62, 0.18);
            top: -120px;
            left: -100px;
        }

        .bg-orb-2 {
            width: 450px;
            height: 450px;
            background: rgba(245, 203, 167, 0.45);
            bottom: -100px;
            right: -80px;
            animation-delay: -6s;
        }

        .bg-orb-3 {
            width: 350px;
            height: 350px;
            background: rgba(216, 67, 21, 0.12);
            top: 40%;
            right: 25%;
            animation-delay: -3s;
        }

        @keyframes floatOrb {
            0% { transform: translateY(0px) scale(1); }
            100% { transform: translateY(35px) scale(1.08); }
        }

        .auth-split-wrapper {
            position: relative;
            z-index: 1;
            display: flex;
            width: 1080px;
            max-width: 92%;
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(20px);
            border-radius: 28px;
            box-shadow: 0 35px 70px rgba(180, 100, 60, 0.18), 0 10px 20px rgba(0, 0, 0, 0.03);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.9);
        }

        .auth-image-panel {
            flex: 1.15;
            position: relative;
            min-height: 580px;
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
            visibility: hidden;
            transition: opacity 1.2s ease-in-out, visibility 1.2s ease-in-out, transform 6s ease-out;
            transform: scale(1.05);
        }

        .slide.active {
            opacity: 1;
            visibility: visible;
            transform: scale(1);
        }

        .auth-image-panel::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(180deg, rgba(15, 15, 15, 0.2) 0%, rgba(15, 15, 15, 0.8) 100%);
            z-index: 1;
        }

        .brand-badge {
            position: relative;
            z-index: 2;
            align-self: flex-start;
            background: rgba(255, 255, 255, 0.25);
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
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
            line-height: 1.2;
        }

        .brand-overlay-content p {
            font-size: 14px;
            color: #f3f4f6;
            line-height: 1.6;
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
            padding: 45px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: rgba(255, 255, 255, 0.85);
        }

        .auth-header h1 {
            font-size: 28px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }

        /* Tab Switcher Styling */
        .login-tabs {
            display: flex;
            background: #f3f4f6;
            border-radius: 10px;
            padding: 4px;
            margin-bottom: 20px;
        }

        .login-tab {
            flex: 1;
            text-align: center;
            padding: 8px;
            font-size: 13px;
            font-weight: 700;
            color: #6b7280;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .login-tab.active {
            background: #ffffff;
            color: #e2583e;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .auth-form-group input {
            width: 100%;
            padding: 13px 18px;
            font-size: 14px;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px !important;
            outline: none;
            background-color: #f9fafb;
            transition: all 0.25s ease;
        }

        .auth-form-group input:focus {
            border-color: #e2583e !important;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(226, 88, 62, 0.15) !important;
        }

        .btn-primary.auth-submit-btn {
            width: 100%;
            padding: 14px;
            font-size: 15px;
            font-weight: 700;
            color: #fff !important;
            background: linear-gradient(135deg, #e2583e 0%, #d84315 100%) !important;
            border: none !important;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 8px 20px rgba(226, 88, 62, 0.3) !important;
        }

        .btn-primary.auth-submit-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(135deg, #d84315 0%, #bf360c 100%) !important;
            box-shadow: 0 12px 25px rgba(226, 88, 62, 0.4) !important;
        }

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
            .auth-image-panel { display: none; }
            .auth-split-wrapper { max-width: 440px; }
            .auth-form-panel { padding: 35px 25px; }
        }
    </style>
</head>

<body>

<!-- Creative Glowing Mesh Orbs -->
<div class="bg-orb bg-orb-1"></div>
<div class="bg-orb bg-orb-2"></div>
<div class="bg-orb bg-orb-3"></div>

<main>
    <div class="auth-split-wrapper">
        
        <div class="auth-image-panel">
            <div class="slider-slides">
                <div class="slide active" style="background-image: url('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80');"></div>
            </div>

            <div class="brand-badge">Fashion Project</div>

            <div class="brand-overlay-content">
                <h2>Redefining Modern Style</h2>
                <p>Welcome to Fashion Project. Explore curated collections, luxury trends, and a seamless boutique experience.</p>
                
                <div class="slider-dots">
                    <div class="dot active"></div>
                    <div class="dot"></div>
                    <div class="dot"></div>
                </div>
            </div>
        </div>

        <div class="auth-form-panel">
            <div class="auth-header">
                <h1>Welcome Back</h1>
            </div>

            <p style="color: #6b7280; font-size: 0.88rem; margin-bottom: 20px;">
                Please select your preferred sign-in method.
            </p>

            <!-- Login Mode Tabs -->
            <div class="login-tabs">
                <div class="login-tab active" onclick="switchLoginMode('password')">Password Login</div>
                <div class="login-tab" onclick="switchLoginMode('otp')">Mobile / OTP</div>
            </div>

            <c:if test="${param.reset eq 'success'}">
                <div style="background: #27ae60; color: white; padding: 10px; border-radius: 6px; margin-bottom: 15px; font-size: 0.85rem; text-align: center;">
                    Password reset successfully! Please log in.
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 6px; margin-bottom: 15px; font-size: 0.85rem; text-align: center; border: 1px solid #f5c6cb;">
                    ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 6px; margin-bottom: 15px; font-size: 0.85rem; text-align: center; border: 1px solid #c3e6cb;">
                    ${successMessage}
                </div>
            </c:if>

            <!-- 1. PASSWORD LOGIN FORM -->
            <form id="passwordLoginForm" action="${pageContext.request.contextPath}/login" method="POST" class="auth-form" autocomplete="off">
                <input type="hidden" name="loginType" value="password">

                <div class="auth-form-group" style="margin-bottom: 16px;">
                    <label for="email" style="display: block; font-size: 13px; font-weight: 700; color: #374151; margin-bottom: 6px;">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="name@example.com" required>
                </div>

                <div class="auth-form-group" style="margin-bottom: 16px;">
                    <label for="password" style="display: block; font-size: 13px; font-weight: 700; color: #374151; margin-bottom: 6px;">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <div class="form-row-extra" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 0.85rem;">
                    <label style="display: flex; align-items: center; gap: 6px; cursor: pointer; color: #4b5563; font-weight: 500;">
                        <input type="checkbox" name="rememberMe"> Remember me
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="btn-primary auth-submit-btn">Sign In</button>
            </form>

            <!-- 2. MOBILE / OTP LOGIN FORM -->
            <form id="otpLoginForm" action="${pageContext.request.contextPath}/login" method="POST" class="auth-form" style="display: none;" autocomplete="off">
                <input type="hidden" name="loginType" value="otp">

                <div class="auth-form-group" style="margin-bottom: 16px;">
                    <label for="phone" style="display: block; font-size: 13px; font-weight: 700; color: #374151; margin-bottom: 6px;">Mobile Number</label>
                    <div style="display: flex; gap: 8px;">
                        <input type="text" id="phone" name="phone" placeholder="Enter 10-digit mobile no." value="${param.phone}" required>
                        <button type="submit" name="action" value="sendOtp" style="padding: 0 16px; background: #374151; color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; white-space: nowrap; font-size: 13px;">Send OTP</button>
                    </div>
                </div>

                <div class="auth-form-group" style="margin-bottom: 20px;">
                    <label for="otp" style="display: block; font-size: 13px; font-weight: 700; color: #374151; margin-bottom: 6px;">Enter 6-Digit OTP</label>
                    <input type="text" id="otp" name="otp" placeholder="123456" maxlength="6">
                </div>

                <button type="submit" name="action" value="verifyOtp" class="btn-primary auth-submit-btn">Verify &amp; Sign In</button>
            </form>

            <div class="auth-footer-text" style="text-align: center; margin-top: 20px; font-size: 13px; color: #6b7280;">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
            </div>
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

    function switchLoginMode(mode) {
        const passwordTab = document.querySelectorAll('.login-tab')[0];
        const otpTab = document.querySelectorAll('.login-tab')[1];
        const passwordForm = document.getElementById('passwordLoginForm');
        const otpForm = document.getElementById('otpLoginForm');

        if (mode === 'password') {
            passwordTab.classList.add('active');
            otpTab.classList.remove('active');
            passwordForm.style.display = 'block';
            otpForm.style.display = 'none';
        } else {
            otpTab.classList.add('active');
            passwordTab.classList.remove('active');
            otpForm.style.display = 'block';
            passwordForm.style.display = 'none';
        }
    }

    <c:if test="${param.loginType eq 'otp' or not empty sessionScope.generatedOtp}">
        switchLoginMode('otp');
    </c:if>
</script>

</body>
</html>