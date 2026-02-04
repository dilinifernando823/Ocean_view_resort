<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
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
                <h2 style="font-weight: 700; color: #333;">Operations Console</h2>
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
                        <span>8</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fff3e0; color: #f57c00;">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Today's Check-outs</h3>
                        <span>5</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #f3e5f5; color: #7b1fa2;">
                        <i class="fas fa-concierge-bell"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Requests</h3>
                        <span>3</span>
                    </div>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 2rem;">
                <div class="data-table-container">
                    <h3 style="font-weight: 700; margin-bottom: 1.5rem;">Room Cleaning Status</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Room</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Task</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>101</td>
                                <td>Standard</td>
                                <td><span class="badge badge-danger">Dirty</span></td>
                                <td><button class="btn btn-primary" style="font-size: 0.7rem;">Clean</button></td>
                            </tr>
                            <tr>
                                <td>102</td>
                                <td>Deluxe</td>
                                <td><span class="badge badge-warning">Cleaning</span></td>
                                <td><button class="btn" style="font-size: 0.7rem; background: #eee;">Finish</button></td>
                            </tr>
                            <tr>
                                <td>105</td>
                                <td>Suite</td>
                                <td><span class="badge badge-success">Available</span></td>
                                <td>-</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="data-table-container">
                    <h3 style="font-weight: 700; margin-bottom: 1.5rem;">Quick Arrival List</h3>
                    <div style="display: flex; flex-direction: column; gap: 1rem;">
                        <div style="padding: 1rem; border-left: 4px solid var(--secondary-color); background: #f9f9f9; border-radius: 4px;">
                            <div style="font-weight: 600;">Peter Parker</div>
                            <div style="font-size: 0.8rem; color: #666;">Room 204 | Time: 2:00 PM</div>
                        </div>
                        <div style="padding: 1rem; border-left: 4px solid var(--secondary-color); background: #f9f9f9; border-radius: 4px;">
                            <div style="font-weight: 600;">Tony Stark</div>
                            <div style="font-size: 0.8rem; color: #666;">Room 501 | Time: 4:30 PM</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
