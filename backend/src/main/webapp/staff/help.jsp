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
            <div style="color: #666;">Guidelines and procedures for Ocean View Resort operations</div>
        </header>

        <div class="dashboard-container">
            <!-- Housekeeping Section -->
            <div style="background: white; border-radius: 12px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                    <i class="fas fa-broom"></i> Housekeeping Procedures
                </h3>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                    <div>
                        <h4 style="margin-bottom: 0.8rem; font-weight: 600;">Standard Room Cleaning</h4>
                        <ol style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                            <li>Wait for guest check-out or check "Please Clean" status.</li>
                            <li>Strip all bed linens and towels.</li>
                            <li>Sanitize all high-touch surfaces (doorknobs, remotes).</li>
                            <li>Replenish amenities (soap, shampoo, water).</li>
                            <li>Final vacuum and mop.</li>
                        </ol>
                    </div>
                    <div>
                        <h4 style="margin-bottom: 0.8rem; font-weight: 600;">Status Codes</h4>
                        <ul style="padding-left: 1.2rem; line-height: 1.6; color: #555;">
                            <li><span class="badge badge-success">Occupied</span>: Guest currently in room. Only clean if requested.</li>
                            <li><span class="badge badge-danger">Dirty</span>: Guest checked out. Needs full turnover.</li>
                            <li><span class="badge">Ready</span>: Inspected and ready for new guest.</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Guest Services Section -->
            <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 1.5rem;">
                    <i class="fas fa-concierge-bell"></i> Guest Services
                </h3>
                
                <p style="margin-bottom: 1rem; color: #555;">Always greet guests with a smile and "Ayubowan". Report any maintenance issues immediately to the administration panel.</p>
                
                <div style="background: #f9f9f9; padding: 1rem; border-left: 4px solid var(--primary-color); border-radius: 4px;">
                    <strong>Emergency Contact:</strong> Admin Manager - Ext 100
                </div>
            </div>
        </div>
    </div>
</body>
</html>
