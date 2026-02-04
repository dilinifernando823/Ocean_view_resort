<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <div class="header-left">
                <h2 style="font-weight: 700; color: #333;">Dashboard Overview</h2>
            </div>
            <div class="header-right" style="display: flex; align-items: center; gap: 1rem;">
                <span style="color: #666;">Welcome, <strong>${sessionScope.user.username}</strong></span>
                <div style="width: 40px; height: 40px; border-radius: 50%; background: var(--secondary-color); color: white; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                    A
                </div>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background: #e3f2fd; color: #1976d2;">
                        <i class="fas fa-bed"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Total Rooms</h3>
                        <span>45</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #e8f5e9; color: #388e3c;">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Active Bookings</h3>
                        <span>12</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fff3e0; color: #f57c00;">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Total Guests</h3>
                        <span>128</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #f3e5f5; color: #7b1fa2;">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Today's Income</h3>
                        <span>$1,250</span>
                    </div>
                </div>
            </div>

            <div class="data-table-container">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3 style="font-weight: 700;">Recent Reservations</h3>
                    <a href="#" class="btn btn-primary" style="font-size: 0.8rem; padding: 0.5rem 1rem;">View All</a>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Room No.</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>102 (Deluxe)</td>
                            <td>2024-05-15</td>
                            <td>2024-05-18</td>
                            <td><span class="badge badge-success">Approved</span></td>
                            <td><a href="#" style="color: var(--secondary-color);"><i class="fas fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>Jane Smith</td>
                            <td>205 (Suite)</td>
                            <td>2024-05-16</td>
                            <td>2024-05-20</td>
                            <td><span class="badge badge-warning">Pending</span></td>
                            <td><a href="#" style="color: var(--secondary-color);"><i class="fas fa-eye"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
