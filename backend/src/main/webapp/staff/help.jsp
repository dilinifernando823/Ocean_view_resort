<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Help | Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/staff_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Staff Help Center</h2>
            <div style="color: #666;">Usage guide for Ocean View Resort management tools</div>
        </header>

        <div class="dashboard-container">
            <!-- Room Cleaning Section -->
            <div style="background: white; border-radius: 12px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                    <i class="fas fa-broom"></i> Room Cleaning Management
                </h3>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                    <div>
                        <h4 style="margin-bottom: 0.8rem; font-weight: 600;">Understanding Statuses</h4>
                        <ul style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                            <li style="margin-bottom: 0.5rem;">
                                <span class="badge badge-success">Occupied</span> 
                                Room is currently booked and paid for (includes both Accepted and Pending/Paid reservations). Do not enter unless requested.
                            </li>
                            <li style="margin-bottom: 0.5rem;">
                                <span class="badge" style="background: #eee; color: #333;">Vacant</span> 
                                Room is empty but marked as 'Dirty' in the system. Needs cleaning.
                            </li>
                            <li style="margin-bottom: 0.5rem;">
                                <span class="badge badge-success" style="background: #e8f5e9; color: #2e7d32;">Available</span> 
                                Room is clean and ready for new guests.
                            </li>
                        </ul>
                    </div>
                    <div>
                        <h4 style="margin-bottom: 0.8rem; font-weight: 600;">Actions</h4>
                        <ul style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                            <li style="margin-bottom: 0.5rem;">
                                <strong>Mark Ready</strong>: Click this button after you have finished cleaning a Vacant room. This updates the status to 'Available' instantly in the database.
                            </li>
                            <li style="margin-bottom: 0.5rem;">
                                <strong>Mark Dirty</strong>: Use this if an Available room needs maintenance or was used unexpectedly. It resets the status to 'Dirty'.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Dashboard & Guests Section -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-chart-line"></i> Dashboard Overview
                    </h3>
                    <p style="color: #555; line-height: 1.6; margin-bottom: 1rem;">
                        The <strong>Overview</strong> page provides real-time statistics:
                    </p>
                    <ul style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                        <li><strong>Today's Check-ins:</strong> Count of reservations starting today.</li>
                        <li><strong>Dirty Rooms:</strong> Total number of rooms needing attention.</li>
                        <li><strong>Arrival List:</strong> Shows guest names and room numbers for instant preparation.</li>
                    </ul>
                </div>

                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-users"></i> Guest List
                    </h3>
                    <p style="color: #555; line-height: 1.6; margin-bottom: 1rem;">
                        Use the <strong>Guest List</strong> page to find registered customer details.
                    </p>
                    <ul style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                        <li>View full names and contact info (Email, Phone).</li>
                        <li>Verify registered addresses.</li>
                        <li>Help guests with account-related inquiries.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
