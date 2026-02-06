<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reservations | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Reservations Management</h2>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Reservation ID</th>
                            <th>Check In/Out</th>
                            <th>Total Price</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="res" items="${reservations}">
                            <tr>
                                <td>
                                    <div style="font-weight: 600;">#${res.id}</div>
                                    <div style="font-size: 0.75rem; color: #888;">Placed: <fmt:formatDate value="${res.createdAt}" pattern="yyyy-MM-dd" /></div>
                                </td>
                                <td>
                                    <div style="font-size: 0.85rem;"><strong>In:</strong> <fmt:formatDate value="${res.checkInDate}" pattern="yyyy-MM-dd" /></div>
                                    <div style="font-size: 0.85rem;"><strong>Out:</strong> <fmt:formatDate value="${res.checkOutDate}" pattern="yyyy-MM-dd" /></div>
                                </td>
                                <td style="font-weight: 600;">Rs. ${res.totalAmount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${res.status == 'pending'}"><span class="badge badge-warning">Pending</span></c:when>
                                        <c:when test="${res.status == 'accepted'}"><span class="badge badge-success">Accepted</span></c:when>
                                        <c:when test="${res.status == 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                                        <c:otherwise><span class="badge badge-secondary">${res.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${res.paymentStatus == 'paid'}">
                                            <span style="color: #27ae60; font-weight: 600;"><i class="fas fa-check-circle"></i> Paid</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #e67e22; font-weight: 600;"><i class="fas fa-clock"></i> Unpaid</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <a href="${pageContext.request.contextPath}/admin/reservations?action=view&id=${res.id}" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #3498db; color: white; display: flex; align-items: center; gap: 0.3rem;">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/reservations?action=delete&id=${res.id}" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #e74c3c; color: white; display: flex; align-items: center; gap: 0.3rem;" onclick="return confirm('Are you sure you want to delete this reservation?')">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
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
