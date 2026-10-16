<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.fashionproject.model.User userCheck = (com.fashionproject.model.User) session.getAttribute("loggedInUser");
    if (userCheck == null || !"ADMIN".equals(userCheck.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User - Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #f8f9fa; 
            color: #3f4254; 
            margin: 0; 
            padding: 40px; 
        }
        .admin-container { 
            max-width: 600px; 
            margin: auto; 
            background: #ffffff; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0 0.1rem 1rem 0.25rem rgba(0, 0, 0, 0.05); 
        }
        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 1px solid #ebedf2;
            padding-bottom: 15px;
        }
        h2 { 
            margin: 0; 
            color: #181c32; 
            font-size: 1.35rem;
            font-weight: 600;
        }
        .back-btn { 
            text-decoration: none; 
            color: #3b82f6; 
            font-weight: 500; 
            font-size: 0.9rem;
        }
        .back-btn:hover {
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 600;
            font-size: 0.85rem;
            color: #181c32;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.02em;
        }
        input[type="text"], input[type="email"], select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #ebedf2;
            border-radius: 6px;
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
            color: #3f4254;
            background-color: #f9fafb;
            box-sizing: border-box;
            outline: none;
            transition: border-color 0.2s;
        }
        input[type="text"]:focus, input[type="email"]:focus, select:focus {
            border-color: #3b82f6;
            background-color: #ffffff;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
            border-top: 1px solid #ebedf2;
            padding-top: 20px;
        }
        .btn-submit {
            background-color: #009ef7;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-submit:hover {
            background-color: #0095e8;
        }
        .btn-cancel {
            background-color: #f3f6f9;
            color: #7e8299;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-cancel:hover {
            background-color: #ebedf2;
            color: #3f4254;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="header-flex">
            <h2>Edit User Details</h2>
            <a href="${pageContext.request.contextPath}/admin/users" class="back-btn">&larr; Back to Users</a>
        </div>
        
        <form action="${pageContext.request.contextPath}/admin/user/update" method="POST">
            <input type="hidden" name="userId" value="${user.userId}">
            
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="${user.name}" required>
            </div>
            
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" value="${user.email}" required>
            </div>
            
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" value="${user.phone}">
            </div>
            
            <div class="form-group">
                <label>City</label>
                <input type="text" name="city" value="${user.city}">
            </div>
            
            <div class="form-group">
                <label>Role</label>
                <select name="role">
                    <option value="CUSTOMER" ${user.role eq 'CUSTOMER' ? 'selected' : ''}>CUSTOMER</option>
                    <option value="ADMIN" ${user.role eq 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                </select>
            </div>
            
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">Save Changes</button>
            </div>
        </form>
    </div>
</body>
</html>