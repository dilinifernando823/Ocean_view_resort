<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rooms | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Room Inventory</h2>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/rooms?action=new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Room
                </a>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Preview</th>
                            <th>Room No / Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="room" items="${rooms}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/${room.image1 != null ? room.image1 : 'assets/images/placeholder-room.jpg'}" 
                                         alt="${room.roomNumber}" 
                                         style="width: 70px; height: 45px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;">
                                </td>
                                <td>
                                    <div style="font-weight: 600;">Room ${room.roomNumber}</div>
                                    <div style="font-size: 0.8rem; color: #666;">${room.roomName}</div>
                                </td>
                                <td>
                                    <span style="font-size: 0.85rem; background: #e3f2fd; color: #1976d2; padding: 4px 10px; border-radius: 4px; font-weight: 500;">
                                        ${categoryMap[room.categoryId] != null ? categoryMap[room.categoryId] : 'Uncategorized'}
                                    </span>
                                </td>
                                <td style="font-weight: 600; color: #2c3e50;">
                                    Rs. ${room.pricePerNight}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${room.status == 'available'}">
                                            <span class="badge badge-success">Available</span>
                                        </c:when>
                                        <c:when test="${room.status == 'booked'}">
                                            <span class="badge badge-warning">Booked</span>
                                        </c:when>
                                        <c:when test="${room.status == 'dirty'}">
                                            <span class="badge badge-info">Dirty</span>
                                        </c:when>
                                        <c:when test="${room.status == 'maintenance'}">
                                            <span class="badge badge-danger">Maintenance</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${room.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.8rem;">
                                        <a href="${pageContext.request.contextPath}/admin/rooms?action=view&id=${room.id}" title="View Details" style="color: #6c757d;">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${room.id}" title="Edit" style="color: #3498db;">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${room.id}" title="Delete" style="color: #e74c3c;" onclick="return confirm('Are you sure you want to delete this room?')">
                                            <i class="fas fa-trash"></i>
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
