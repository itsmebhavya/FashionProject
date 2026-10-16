<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - FashionProject</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0;">
    <div class="container" style="max-width: 400px; margin: 80px auto; padding: 30px; background: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
        <h2 style="text-align: center; color: #333; margin-bottom: 20px;">Set New Password</h2>
        
        <!-- Display Error Message -->
        <c:if test="${not empty errorMessage}">
            <div style="color: #d9534f; background-color: #f2dede; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center;">
                ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <!-- Pass the email securely as a hidden field -->
            <input type="hidden" name="email" value="${param.email}">

            <div style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #555;">New Password:</label>
                <input type="password" name="newPassword" required placeholder="Enter new password" style="width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px;">
            </div>

            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #555;">Confirm Password:</label>
                <input type="password" name="confirmPassword" required placeholder="Confirm new password" style="width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px;">
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #007bff; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer;">Update Password</button>
        </form>
    </div>
</body>
</html>