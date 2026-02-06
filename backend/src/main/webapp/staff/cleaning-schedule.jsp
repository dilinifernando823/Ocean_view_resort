<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cleaning Schedule | Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/staff_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Room Cleaning Schedule</h2>
            <div style="color: #666;">View housekeeping status</div>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Room Info</th>
                            <th>Reservation Status</th>
                            <th>Occupancy</th>
                            <th>Housekeeping</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${rooms}" var="room">
                            <c:set var="activeRes" value="${activeResMap[room.id]}" />
                            
                            <tr>
                                <td>
                                    <strong>${room.roomName}</strong><br>
                                    <span style="font-size: 0.8rem; color: #888;">Room #${room.roomNumber}</span>
                                </td>
                                
                                <c:choose>
                                    <%-- Case 1: Room is Occupied --%>
                                    <c:when test="${not empty activeRes}">
                                        <td>
                                            <span class="badge badge-success">Occupied</span><br>
                                            <small><fmt:formatDate value="${activeRes.checkInDate}" pattern="MMM dd"/> - <fmt:formatDate value="${activeRes.checkOutDate}" pattern="MMM dd"/></small>
                                        </td>
                                        <td>${activeRes.occupancy} Guests</td>
                                        <td>
                                            <span class="badge badge-warning" style="background: #fff3e0; color: #e65100;">Needs Service</span>
                                        </td>
                                        <td>
                                            <%-- Could add a 'Mark Serviced' button here for daily cleaning --%>
                                            <button class="btn btn-primary" style="font-size: 0.8rem; padding: 0.3rem 0.8rem; opacity: 0.5; cursor: default;">Occupied</button>
                                        </td>
                                    </c:when>

                                    <%-- Case 2: Room is Empty but Dirty --%>
                                    <c:when test="${room.status == 'dirty'}">
                                        <td>
                                            <span class="badge" style="background: #eee; color: #333;">Vacant</span>
                                        </td>
                                        <td style="color: #888; font-size: 0.9rem;">Max: ${room.capacity}</td>
                                        <td>
                                            <span class="badge badge-danger">Dirty / Turnaround</span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/staff/update-room-status?id=${room.id}&status=available" class="btn btn-primary" style="font-size: 0.8rem; padding: 0.3rem 0.8rem;">Mark Ready</a>
                                        </td>
                                    </c:when>

                                    <%-- Case 3: Room is Available (Clean) --%>
                                    <c:otherwise>
                                        <td>
                                            <span class="badge badge-success" style="background: #e8f5e9; color: #2e7d32;">Available</span>
                                        </td>
                                        <td style="color: #888; font-size: 0.9rem;">Max: ${room.capacity}</td>
                                        <td>
                                            <span class="badge badge-success">Clean & Ready</span>
                                        </td>
                                        <td>
                                            <%-- Toggle back to dirty for internal testing/manual override --%>
                                            <a href="${pageContext.request.contextPath}/staff/update-room-status?id=${room.id}&status=dirty" class="btn" style="font-size: 0.8rem; padding: 0.3rem 0.8rem; background: #eee; color: #333;">Mark Dirty</a>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty rooms}">
                            <tr><td colspan="5" style="text-align: center;">No rooms found in the system.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
