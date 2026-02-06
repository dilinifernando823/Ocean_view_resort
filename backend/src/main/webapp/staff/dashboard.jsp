<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%-- Redirect to Servlet if data is missing --%>
    <c:if test="${empty checkInsCount}">
        <c:redirect url="/staff/dashboard"/>
    </c:if>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/staff_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <div class="header-left">
                <h2 style="font-weight: 700; color: #333;">Staff Operations Console</h2>
            </div>
            <div class="header-right" style="display: flex; align-items: center; gap: 1rem;">
                <span style="color: #666;">Staff User: <strong>${sessionScope.user.username}</strong></span>
                <div style="width: 40px; height: 40px; border-radius: 50%; background: #2c3e50; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                    S
                </div>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background: #e3f2fd; color: #1976d2;">
                        <i class="fas fa-sign-in-alt"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Today's Check-ins</h3>
                        <span>${checkInsCount}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fff3e0; color: #f57c00;">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Today's Check-outs</h3>
                        <span>${checkOutsCount}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #f3e5f5; color: #7b1fa2;">
                        <i class="fas fa-concierge-bell"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Pending Requests</h3>
                        <span>${pendingRequestsCount}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #ffebee; color: #c62828;">
                        <i class="fas fa-broom"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Dirty Rooms</h3>
                        <span>${dirtyRoomsCount}</span>
                    </div>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 2rem;">
                <div class="data-table-container">
                    <h3 style="font-weight: 700; margin-bottom: 1.5rem;">Rooms Needing Attention</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Room</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${dirtyRooms}" var="room">
                                <tr>
                                    <td>
                                        <strong>${room.roomName}</strong><br>
                                        <span style="font-size: 0.8rem; color: #888;">Room #${room.roomNumber}</span>
                                    </td>
                                    <td><span class="badge badge-danger">Dirty</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/staff/update-room-status?id=${room.id}&status=available" class="btn btn-primary" style="font-size: 0.7rem; padding: 0.3rem 0.8rem;">Mark Ready</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty dirtyRooms}">
                                <tr><td colspan="3" style="text-align: center; color: #888;">No rooms currently marked for cleaning.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div style="margin-top: 1rem; text-align: center;">
                        <a href="${pageContext.request.contextPath}/staff/cleaning-schedule" class="btn" style="font-size: 0.8rem; background: #eee; color: #333;">View Full Schedule</a>
                    </div>
                </div>

                <div class="data-table-container">
                    <h3 style="font-weight: 700; margin-bottom: 1.5rem;">Quick Arrival List (Today)</h3>
                    <div style="display: flex; flex-direction: column; gap: 1rem;">
                        <c:forEach items="${todaysArrivals}" var="res">
                            <div style="padding: 1rem; border-left: 4px solid var(--secondary-color); background: #f9f9f9; border-radius: 4px;">
                                <div style="font-weight: 600;">Guest ID: ${res.guestId}</div>
                                <div style="font-size: 0.8rem; color: #666;">
                                    Res #${res.id} | ${res.occupancy} Guests
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty todaysArrivals}">
                            <div style="padding: 1rem; text-align: center; color: #888; font-style: italic;">
                                No check-ins scheduled for today.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
