<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">User Management</h2>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/users?action=new" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Add New User
                </a>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>User Details</th>
                            <th>Role</th>
                            <th>Phone / NIC</th>
                            <th>Joined Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>
                                    <div style="font-weight: 600;">${user.fullName}</div>
                                    <div style="font-size: 0.8rem; color: #666;">@${user.username} | ${user.email}</div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">
                                            <span class="badge badge-danger">Administrator</span>
                                        </c:when>
                                        <c:when test="${user.role == 'staff'}">
                                            <span class="badge badge-warning">Staff</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-success">Customer</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div style="font-size: 0.85rem;">${user.phone}</div>
                                    <div style="font-size: 0.8rem; color: #888;">${user.nic}</div>
                                </td>
                                <td style="font-size: 0.85rem;">
                                    ${user.createdAt}
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.8rem;">
                                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.id}" title="Edit" style="color: #3498db;">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:if test="${sessionScope.user.id != user.id}">
                                            <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${user.id}" title="Delete" style="color: #e74c3c;" onclick="return confirm('Are you sure you want to delete this user?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
