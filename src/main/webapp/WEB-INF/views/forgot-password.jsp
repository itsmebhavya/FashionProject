<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Forgot Password - Fashion Project</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

    <!-- Custom Luxury Warm Beige & Model Slider Styling (Warm Orange Accent Theme) -->
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
            width: 1080px;
            max-width: 92%;
            background: #ffffff;
            border-radius: 28px;
            box-shadow: 0 30px 60px rgba(120, 80, 40, 0.15);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        /* Left Side: Dynamic Sliding Model Panel */
        .auth-image-panel {
            flex: 1.15;
            position: relative;
            min-height: 540px;
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

        /* Right Side: Form Container */
        .auth-form-panel {
            flex: 1;
            padding: 55px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #ffffff;
        }

        .auth-header h1 {
            font-size: 28px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }

        .auth-form-group input {
            width: 100%;
            padding: 14px 18px;
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
            padding: 15px;
            font-size: 15px;
            font-weight: 700;
            color: #fff;
            background: linear-gradient(135deg, #e2583e 0%, #d84315 100%);
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 8px 20px rgba(226, 88, 62, 0.3);
        }

        .btn-primary.auth-submit-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(135deg, #d84315 0%, #bf360c 100%);
            box-shadow: 0 12px 25px rgba(226, 88, 62, 0.4);
        }

        .login-link {
            color: #e2583e !important;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link:hover {
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
                padding: 40px 30px;
            }
        }
    </style>
</head>

<body>

<main>
    <div class="auth-split-wrapper">
        
        <!-- Left Visual Side: Sliding Model Panel -->
        <div class="auth-image-panel">
            <div class="slider-slides">
                <div class="slide active" style="background-image: url('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=1200&q=80');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=1200&q=80');"></div>
            </div>

            <div class="brand-badge">Fashion Project</div>

            <div class="brand-overlay-content">
                <h2>Account Recovery</h2>
                <p>We've got you covered. Enter your registered email to reset your password securely.</p>
                
                <div class="slider-dots">
                    <div class="dot active"></div>
                    <div class="dot"></div>
                    <div class="dot"></div>
                </div>
            </div>
        </div>

        <!-- Right Side: Forgot Password Form Panel -->
        <div class="auth-form-panel">

            <div class="auth-header">
                <h1>Forgot Password?</h1>
            </div>

            <p style="color: #6b7280; font-size: 0.92rem; margin-top: 0px; margin-bottom: 30px;">
                Enter your email address and we'll send you instructions to reset your password.
            </p>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div style="color: #d9534f; background-color: #f2dede; padding: 10px; border-radius: 6px; margin-bottom: 20px; text-align: center; font-size: 0.85rem;">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Success Message -->
            <c:if test="${not empty successMessage}">
                <div style="color: #2b542c; background-color: #dff0d8; padding: 10px; border-radius: 6px; margin-bottom: 20px; text-align: center; font-size: 0.85rem;">
                    ${successMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="POST" class="auth-form" autocomplete="off">

                <div class="auth-form-group" style="margin-bottom: 24px;">
                    <label for="email" style="display: block; font-size: 13px; font-weight: 700; color: #374151; margin-bottom: 8px;">Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="name@example.com">
                </div>

                <button type="submit" class="btn-primary auth-submit-btn">Send Reset Link</button>

                <div class="auth-footer-text" style="text-align: center; margin-top: 24px; font-size: 13px; color: #6b7280;">
                    <p>Remember your password? <a href="${pageContext.request.contextPath}/login" class="login-link">Back to Login</a></p>
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