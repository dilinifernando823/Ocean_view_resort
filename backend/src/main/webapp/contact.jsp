<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="hero-small" style="background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');">
        <h1>Contact Us</h1>
        <p>We'd love to hear from you. Reach out for any inquiries or bookings.</p>
    </section>

    <div class="section" style="padding-top: 0;">
        <c:if test="${not empty param.success}">
            <div style="background: #d4edda; color: #155724; padding: 1rem; border-radius: 10px; margin-bottom: 2rem; text-align: center;">
                ${param.success}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 10px; margin-bottom: 2rem; text-align: center;">
                ${param.error}
            </div>
        </c:if>

        <div class="contact-container">
            <!-- Contact Info -->
            <div class="contact-info">
                <h3>Get in Touch</h3>
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <strong>Location</strong>
                        <p>123 Ocean Drive, Coastal Paradise, SL</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone-alt"></i>
                    <div>
                        <strong>Phone</strong>
                        <p>+94 11 234 5678</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <div>
                        <strong>Email</strong>
                        <p>info@oceanviewresort.com</p>
                    </div>
                </div>

                <h3>Follow Us</h3>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="auth-container" style="margin: 0; max-width: none;">
                <form action="${pageContext.request.contextPath}/contact-submit" method="POST">
                    <div class="form-group">
                        <label>Your Name</label>
                        <input type="text" name="name" class="form-control" placeholder="John Doe" required>
                    </div>
                    <div class="form-group">
                        <label>Your Email</label>
                        <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject" class="form-control" placeholder="Room Inquiry">
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <textarea name="message" class="form-control" rows="5" placeholder="Your message here..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width:100%;">Send Message</button>
                </form>
            </div>
        </div>

        <!-- Google Map -->
        <div class="map-container">
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d126743.58585974!2d79.8211859!3d6.9218374!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae253d10f7a70ad%3A0x3914c4da641293f!2sColombo!5e0!3m2!1sen!2slk!4v1683881456789!5m2!1sen!2slk" 
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
