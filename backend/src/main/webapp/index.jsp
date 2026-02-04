<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Paradise Awaits</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="hero">
        <h1>Escape to Serenity</h1>
        <p>Your luxury getaway at Dilini Ocean View Resort offers stunning oceanfront views and world-class service.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/rooms.jsp" class="btn btn-primary">Book Your Stay</a>
            <a href="${pageContext.request.contextPath}/about.jsp" class="btn" style="background: rgba(255,255,255,0.2); color: white;">Learn More</a>
        </div>
    </section>

    <section class="section">
        <h2 class="section-title">Our Premier Accommodations</h2>
        <div class="grid">
            <div class="card">
                <div class="card-img" style="background-image: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');"></div>
                <div class="card-content">
                    <h3>Deluxe Ocean Suite</h3>
                    <p>Panoramic views of the coastline with private balcony and luxury amenities.</p>
                    <a href="#" class="btn btn-primary" style="display:inline-block; margin-top:1rem;">View Details</a>
                </div>
            </div>
            <div class="card">
                <div class="card-img" style="background-image: url('https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');"></div>
                <div class="card-content">
                    <h3>Pool Terrace Villa</h3>
                    <p>Direct access to our infinity pool with spacious living area and tropical gardens.</p>
                    <a href="#" class="btn btn-primary" style="display:inline-block; margin-top:1rem;">View Details</a>
                </div>
            </div>
            <div class="card">
                <div class="card-img" style="background-image: url('https://images.unsplash.com/photo-1582719478250-c89cae4df85b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');"></div>
                <div class="card-content">
                    <h3>Sunset Garden Room</h3>
                    <p>Quiet and peaceful rooms surrounded by lush tropical greenery.</p>
                    <a href="#" class="btn btn-primary" style="display:inline-block; margin-top:1rem;">View Details</a>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
