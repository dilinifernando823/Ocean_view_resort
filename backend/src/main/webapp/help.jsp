<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & FAQ | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="hero-small" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');">
        <h1>Help & Support</h1>
        <p>Everything you need to know about your stay.</p>
    </section>

    <section class="section">
        <div class="container" style="max-width: 800px; margin: 0 auto;">
            
            <div class="faq-item" style="margin-bottom: 2rem; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); margin-bottom: 1rem;"><i class="fas fa-calendar-check"></i> How to Make a Reservation</h3>
                <p style="color: #666; line-height: 1.6;">
                    1. <strong>Browse Rooms:</strong> Navigate to the "Rooms" page to view our available accommodations.<br>
                    2. <strong>Check Availability:</strong> Select a room and enter your desired Check-in and Check-out dates. Click "Check Availability".<br>
                    3. <strong>Book:</strong> If available, you will see a booking form. Enter the number of guests and any special requests.<br>
                    4. <strong>Confirm:</strong> Click "Confirm Booking". You will need to be logged in to complete this step.
                </p>
            </div>

            <div class="faq-item" style="margin-bottom: 2rem; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); margin-bottom: 1rem;"><i class="fas fa-credit-card"></i> Payment Methods</h3>
                <p style="color: #666; line-height: 1.6;">
                    We accept all major credit cards including Visa, MasterCard, and American Express. 
                    <br><br>
                    <strong>Payment Process:</strong><br>
                    After your reservation is accepted by our staff, you can view it in your "Profile". 
                    Click the "Pay Now" button to securely settle your bill online correctly generating an invoice.
                </p>
            </div>

            <div class="faq-item" style="margin-bottom: 2rem; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); margin-bottom: 1rem;"><i class="fas fa-clock"></i> Check-in & Check-out</h3>
                <p style="color: #666; line-height: 1.6;">
                    <strong>Check-in:</strong> 2:00 PM onwards.<br>
                    <strong>Check-out:</strong> By 11:00 AM.<br>
                    <br>
                    Early check-in or late check-out requests are subject to availability. Please contact us in advance if you require these services.
                </p>
            </div>

            <div class="faq-item" style="margin-bottom: 2rem; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-color); margin-bottom: 1rem;"><i class="fas fa-ban"></i> Cancellation Policy</h3>
                <p style="color: #666; line-height: 1.6;">
                    Free cancellation is available up to 48 hours before your check-in date. 
                    Cancellations made within 48 hours of check-in may be subject to a cancellation fee equivalent to the first night's stay.
                </p>
            </div>

            <div style="text-align: center; margin-top: 3rem;">
                <p style="color: #666; margin-bottom: 1rem;">Still have questions?</p>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-primary">Contact Support</a>
            </div>

        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
