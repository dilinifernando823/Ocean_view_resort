<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Details | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <style>
        .details-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
        .info-group { margin-bottom: 1.5rem; }
        .info-group label { display: block; font-size: 0.8rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 0.3rem; }
        .info-group span { font-size: 1.1rem; font-weight: 600; color: #333; }
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; margin-top: 1rem; }
        .gallery-item { border-radius: 8px; overflow: hidden; height: 200px; border: 1px solid #eee; }
        .gallery-item img { width: 100%; height: 100%; object-fit: cover; }
        .amenity-tag { display: inline-block; background: #e3f2fd; color: #1976d2; padding: 0.4rem 1rem; border-radius: 50px; font-size: 0.85rem; margin-right: 0.5rem; margin-bottom: 0.5rem; }
    </style>
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Room ${room.roomNumber} - ${room.roomName}</h2>
            <div style="display: flex; gap: 1rem;">
                <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${room.id}" class="btn btn-primary"><i class="fas fa-edit"></i> Edit Room</a>
                <a href="${pageContext.request.contextPath}/admin/rooms" class="btn" style="background: #eee; color: #333;">Back to List</a>
            </div>
        </header>

        <div class="dashboard-container">
            <div style="background: white; padding: 3rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
                <div class="details-grid">
                    <div>
                        <div class="info-group">
                            <label>Room Category</label>
                            <span style="color: var(--secondary-color);">${category.name}</span>
                        </div>
                        <div class="info-group">
                            <label>Description</label>
                            <p style="color: #666; line-height: 1.6;">${room.description}</p>
                        </div>
                        <div class="info-group">
                            <label>Capacity</label>
                            <span><i class="fas fa-users"></i> ${room.capacity} Persons</span>
                        </div>
                        <div class="info-group">
                            <label>Price Per Night (LKR)</label>
                            <span style="font-size: 1.5rem; color: #2c3e50;">Rs. ${room.pricePerNight}</span>
                        </div>
                        <div class="info-group">
                            <label>Amenities</label>
                            <div style="margin-top: 0.5rem;">
                                <c:set var="amenityList" value="${fn:split(room.amenities, ',')}" />
                                <c:forEach var="amenity" items="${amenityList}">
                                    <span class="amenity-tag"><i class="fas fa-check-circle"></i> ${fn:trim(amenity)}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="info-group">
                            <label>Current Status</label>
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
                                <c:otherwise>
                                    <span class="badge badge-danger">${room.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="info-group">
                            <label>Gallery Images</label>
                            <div class="gallery-grid">
                                <div class="gallery-item">
                                    <img src="${pageContext.request.contextPath}/${not empty room.image1 ? room.image1 : 'assets/images/placeholder-room.jpg'}">
                                </div>
                                <div class="gallery-item">
                                    <img src="${pageContext.request.contextPath}/${not empty room.image2 ? room.image2 : 'assets/images/placeholder-room.jpg'}">
                                </div>
                                <div class="gallery-item">
                                    <img src="${pageContext.request.contextPath}/${not empty room.image3 ? room.image3 : 'assets/images/placeholder-room.jpg'}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
