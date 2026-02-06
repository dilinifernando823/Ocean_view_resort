<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Help | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Admin Help Center</h2>
            <div style="color: #666;">Comprehensive guide for system administrators</div>
        </header>

        <div class="dashboard-container">
            
            <div class="stats-grid" style="grid-template-columns: repeat(2, 1fr);">
                <!-- Dashboard Overview -->
                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-tachometer-alt"></i> Dashboard Overview
                    </h3>
                    <p style="color: #555; margin-bottom: 1rem;">The dashboard provides a high-level view of the hotel's performance.</p>
                    <ul style="padding-left: 1.2rem; color: #555; line-height: 1.6;">
                        <li><strong>Stats:</strong> View real-time counts for active bookings, total guests, and income.</li>
                        <li><strong>Chart:</strong> "New Bookings" graph shows the trend of reservations over the last 6 months.</li>
                        <li><strong>Recent Actions:</strong> Quickly access common tasks like adding rooms or categories.</li>
                    </ul>
                </div>

                <!-- Reservation Management -->
                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-calendar-check"></i> Reservation Management
                    </h3>
                    <p style="color: #555; margin-bottom: 1rem;">Manage guest bookings effectively.</p>
                    <ul style="padding-left: 1.2rem; color: #555; line-height: 1.6;">
                        <li><strong>Pending:</strong> New requests that need approval. Checking availability is crucial before accepting.</li>
                        <li><strong>Accepted:</strong> Confirmed bookings. Ensure guests are notified.</li>
                        <li><strong>Completed:</strong> Past stays. Useful for history and reviews.</li>
                        <li><strong>Actions:</strong> You can Accept or Reject reservations from the list view.</li>
                    </ul>
                </div>
            </div>

            <div class="stats-grid" style="grid-template-columns: repeat(2, 1fr); margin-top: 2rem;">
                <!-- Room & Category Management -->
                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-bed"></i> Rooms & Categories
                    </h3>
                    <ul style="padding-left: 1.2rem; color: #555; line-height: 1.6;">
                        <li><strong>Categories:</strong> Define types of rooms (e.g., Deluxe, Suite). Include an image and description.</li>
                        <li><strong>Rooms:</strong> Create individual room units (e.g., Room 101). Assign them to a category and set status (Available/Dirty).</li>
                        <li><strong>Tip:</strong> Ensure valid images URLs are used for better frontend presentation.</li>
                    </ul>
                </div>

                <!-- User & Review Management -->
                <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                    <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-users"></i> Users & Reviews
                    </h3>
                     <ul style="padding-left: 1.2rem; color: #555; line-height: 1.6;">
                        <li><strong>Users:</strong> View registered customer details. Useful for contacting guests directly.</li>
                        <li><strong>Reviews:</strong> Monitor guest feedback. You can delete inappropriate reviews if necessary.</li>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
