<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest List | Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/staff_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Registered Guest List</h2>
            <div style="color: #666;">View all customer accounts</div>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${guests}" var="guest">
                            <tr>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.8rem;">
                                        <div style="width: 35px; height: 35px; background: #e3f2fd; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-color);">
                                            <i class="fas fa-user domestic-traveler"></i>
                                        </div>
                                        <div style="font-weight: 600;">${guest.fullName}</div>
                                    </div>
                                </td>
                                <td>${guest.email}</td>
                                <td>${guest.phone}</td>
                                <td>${guest.address}</td>
                                <td><span class="badge badge-success">Active</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty guests}">
                            <tr><td colspan="5" style="text-align: center;">No guests found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
