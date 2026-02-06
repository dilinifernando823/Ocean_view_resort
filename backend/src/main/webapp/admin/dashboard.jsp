<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <span>${totalRooms}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #e8f5e9; color: #388e3c;">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Active Bookings</h3>
                        <span>${activeBookings}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fff3e0; color: #f57c00;">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Total Guests</h3>
                        <span>${totalGuests}</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #f3e5f5; color: #7b1fa2;">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Total Income</h3>
                        <span>LKR ${totalIncome}</span>
                    </div>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
                <div class="data-table-container">
                    <h3 style="font-weight: 700; margin-bottom: 1.5rem;">Reservation Trends</h3>
                    <div style="position: relative; height: 300px; width: 100%;">
                        <canvas id="bookingsChart"></canvas>
                    </div>
                </div>
                
                <div class="data-table-container">
                     <h3 style="font-weight: 700; margin-bottom: 1rem;">Quick Actions</h3>
                     <div style="display: flex; flex-direction: column; gap: 1rem;">
                        <a href="${pageContext.request.contextPath}/admin/rooms?action=new" class="btn btn-primary" style="display:block; text-align:center;">
                            <i class="fas fa-plus-circle"></i> Add New Room
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/categories?action=new" class="btn" style="display:block; text-align:center; background: #eee; color: #333;">
                            <i class="fas fa-tags"></i> Add Category
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/help.jsp" class="btn" style="display:block; text-align:center; background: #e3f2fd; color: #1565c0;">
                            <i class="fas fa-question-circle"></i> Admin Help
                        </a>
                     </div>
                </div>
            </div>

            <div class="data-table-container" style="margin-top: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3 style="font-weight: 700;">Recent Reservations</h3>
                    <a href="${pageContext.request.contextPath}/admin/reservations" class="btn btn-primary" style="font-size: 0.8rem; padding: 0.5rem 1rem;">View All</a>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Room No.</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                            <th>Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${recentReservations}" var="res">
                            <tr>
                                <td>${guestNames[res.guestId]}</td>
                                <td>${roomNumbers[res.roomId]}</td>
                              <td>
    <fmt:formatDate value="${res.checkInDate}" pattern="yyyy-MM-dd"/>
</td>
<td>
    <fmt:formatDate value="${res.checkOutDate}" pattern="yyyy-MM-dd"/>
</td>

                                <td>LKR ${res.totalAmount}</td>
                                <td>
                                    <span class="badge ${res.status == 'accepted' ? 'badge-success' : res.status == 'pending' ? 'badge-warning' : 'badge-danger'}">
                                        ${res.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentReservations}">
                            <tr><td colspan="6" style="text-align: center;">No reservations found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('bookingsChart').getContext('2d');
        const bookingChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ${chartLabels},
                datasets: [{
                    label: 'New Bookings',
                    data: ${chartData},
                    borderColor: '#2196f3',
                    backgroundColor: 'rgba(33, 150, 243, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { borderDash: [5, 5] }
                    },
                    x: {
                        grid: { display: false }
                    }
                },
                plugins: {
                    legend: { display: false },
                    title: { display: true, text: 'Last 6 Months Performance' }
                }
            }
        });
    </script>
</body>
</html>
