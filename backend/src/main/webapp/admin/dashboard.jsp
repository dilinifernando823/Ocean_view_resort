<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Ocean View Resort</title>
</head>
<body style="background: #f0f2f5;">
    <jsp:include page="/components/header.jsp" />

    <section class="section">
        <h2 class="section-title">Administrator Console</h2>
        <div class="grid">
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-bed" style="font-size: 2.5rem; color: var(--secondary-color);"></i>
                <h3>Manage Rooms</h3>
                <p>Add, edit or remove rooms from the listing.</p>
            </div>
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-users" style="font-size: 2.5rem; color: var(--secondary-color);"></i>
                <h3>User Management</h3>
                <p>Monitor guest activity and staff accounts.</p>
            </div>
            <div class="card" style="padding: 2rem; text-align: center;">
                <i class="fas fa-file-invoice-dollar" style="font-size: 2.5rem; color: var(--secondary-color);"></i>
                <h3>Financial Reports</h3>
                <p>View invoices and daily revenue status.</p>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
