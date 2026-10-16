<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - Fashion Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f7f4ee; color: #333; margin: 0; padding: 0; }
        .profile-container { max-width: 700px; margin: 50px auto; background: #fff; padding: 40px; border-radius: 14px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #ebe7df; }
        h2 { font-family: 'Playfair Display', serif; color: #171717; margin-top: 0; margin-bottom: 25px; border-bottom: 2px solid #f0ede7; padding-bottom: 12px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: 600; font-size: 13px; color: #555; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
        input[type="text"], input[type="email"] { width: 100%; padding: 12px 15px; border: 1px solid #dedad2; border-radius: 8px; font-size: 14px; box-sizing: border-box; background: #faf9f6; }
        input:focus { border-color: #e05638; outline: none; background: #fff; }
        .btn-save { background: #e05638; color: white; padding: 12px 25px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .btn-save:hover { background: #c9452c; }
        .alert-success { background: #e6f4ea; color: #137333; padding: 12px 15px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; }
        .alert-error { background: #fce8e6; color: #c5221f; padding: 12px 15px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <div class="profile-container">
        <h2>Account Settings</h2>

        <c:if test="${not empty successMessage}">
            <div class="alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert-error">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/profile" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="${user.name}" required />
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" value="${user.email}" required />
            </div>

            <div class="form-group">
                <label>Role</label>
                <input type="text" value="${user.role}" disabled style="color: #888; cursor: not-allowed;" />
            </div>

            <button type="submit" class="btn-save">Update Profile</button>
        </form>
    </div>

</body>
</html>