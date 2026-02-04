<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="section">
        <div style="max-width: 800px; margin: 0 auto;">
            <div style="background: white; padding: 2rem; border-radius: 20px; box-shadow: var(--shadow);">
                <h2 style="margin-bottom: 2rem; border-bottom: 2px solid var(--bg-color); padding-bottom: 1rem;">Guest Profile Information</h2>
                
                <form action="${pageContext.request.contextPath}/update-profile" method="POST">
                    <div class="grid" style="grid-template-columns: 1fr 1fr;">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" class="form-control" value="${sessionScope.user.username}" readonly style="background: #f9f9f9;">
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" class="form-control" value="${sessionScope.user.email}" readonly style="background: #f9f9f9;">
                        </div>
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="${sessionScope.user.fullName}" placeholder="Enter your full name">
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" placeholder="+94 7X XXX XXXX">
                        </div>
                        <div class="form-group" style="grid-column: span 2;">
                            <label>NIC / Passport Number</label>
                            <input type="text" name="nic" class="form-control" value="${sessionScope.user.nic}" placeholder="Your Identity Number">
                        </div>
                        <div class="form-group" style="grid-column: span 2;">
                            <label>Home Address</label>
                            <textarea name="address" class="form-control" rows="3" placeholder="Enter your full mailing address">${sessionScope.user.address}</textarea>
                        </div>
                    </div>
                    
                    <div style="margin-top: 2rem; display: flex; gap: 1rem;">
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                        <a href="${pageContext.request.contextPath}/logout" class="btn" style="background: #eee; color: #333;">Logout</a>
                    </div>
                </form>
            </div>
            
            <div style="margin-top: 3rem;">
                <h3 style="margin-bottom: 1.5rem;">My Recent Bookings</h3>
                <div style="background: white; padding: 2rem; border-radius: 20px; box-shadow: var(--shadow); text-align: center; color: #888;">
                    <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                    <p>You have no active or past reservations yet.</p>
                    <a href="${pageContext.request.contextPath}/rooms.jsp" class="btn btn-primary" style="display:inline-block; margin-top: 1rem;">Browse Rooms</a>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
