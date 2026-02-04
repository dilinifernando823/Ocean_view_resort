<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Panel | Ocean View Resort</title>
</head>
<body style="background: #f0f2f5;">
    <jsp:include page="/components/header.jsp" />

    <section class="section">
        <h2 class="section-title">Staff Operational Panel</h2>
        <div class="grid">
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-check-circle" style="font-size: 2.5rem; color: #28a745;"></i>
                <h3>Check-ins</h3>
                <p>Verify guest arrivals and assign keys.</p>
            </div>
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-broom" style="font-size: 2.5rem; color: #ffc107;"></i>
                <h3>Housekeeping</h3>
                <p>Track room cleaning status and maintenance.</p>
            </div>
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-concierge-bell" style="font-size: 2.5rem; color: var(--secondary-color);"></i>
                <h3>Guest Services</h3>
                <p>Manage special requests and room service.</p>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
