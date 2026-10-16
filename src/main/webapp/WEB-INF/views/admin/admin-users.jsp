<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.fashionproject.model.User user = (com.fashionproject.model.User) session.getAttribute("loggedInUser");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Admin Dashboard</title>
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
            max-width: 1100px; 
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
            margin-bottom: 20px;
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
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
            font-size: 0.9rem;
        }
        th, td { 
            padding: 12px 15px; 
            text-align: left; 
            border-bottom: 1px solid #ebedf2; 
        }
        th { 
            background-color: #f9fafb; 
            color: #181c32; 
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
        }
        tr:hover {
            background-color: #f9fafb;
        }
        .badge-admin {
            background-color: #eee5ff;
            color: #8950fc;
            padding: 4px 8px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.8rem;
        }
        .badge-customer {
            background-color: #e1f0ff;
            color: #009ef7;
            padding: 4px 8px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.8rem;
        }
        .btn-action {
            display: inline-block;
            padding: 5px 10px;
            font-size: 0.75rem;
            font-weight: 600;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 5px;
        }
        .btn-edit {
            background-color: #e1f0ff;
            color: #009ef7;
        }
        .btn-edit:hover {
            opacity: 0.85;
        }
        .btn-delete {
            background-color: #ffe2e5;
            color: #f1416c;
        }
        .btn-delete:hover {
            opacity: 0.85;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="header-flex">
            <h2>Manage Users</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">&larr; Back to Dashboard</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>City</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${userList}">
                    <tr>
                        <td>${u.userId}</td>
                        <td>${u.name}</td>
                        <td>${u.email}</td>
                        <td>${u.phone}</td>
                        <td>${u.city}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.role eq 'ADMIN'}">
                                    <span class="badge-admin">ADMIN</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-customer">CUSTOMER</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.userId}" class="btn-action btn-edit">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.userId}" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>