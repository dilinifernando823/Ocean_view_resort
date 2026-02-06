<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Paradise Awaits</title>
</head>
<body>
    <c:if test="${empty categories}">
        <c:redirect url="/home"/>
    </c:if>

    <jsp:include page="/components/header.jsp" />

    <section class="hero">
        <h1>Escape to Serenity</h1>
        <p>Your luxury getaway at Dilini Ocean View Resort offers stunning oceanfront views and world-class service.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary">Book Your Stay</a>
            <a href="${pageContext.request.contextPath}/about.jsp" class="btn" style="background: rgba(255,255,255,0.2); color: white;">Learn More</a>
        </div>
    </section>

    <!-- Browse Room by Categories -->
    <section class="section">
        <h2 class="section-title">Browse by Category</h2>
        <div class="carousel-wrapper" style="position: relative; overflow: hidden; padding: 1rem 0;">
            <div class="carousel" style="display: flex; gap: 2rem; overflow-x: auto; scroll-behavior: smooth; padding-bottom: 1rem; -ms-overflow-style: none; scrollbar-width: none;">
                <c:forEach items="${categories}" var="cat">
                    <c:set var="catImg" value="${not empty cat.image ? cat.image : 'assets/img/placeholder.jpg'}" />
                    <div class="cat-card" style="min-width: 250px; flex: 0 0 auto; text-align: center; cursor: pointer; transition: transform 0.3s;" onclick="location.href='${pageContext.request.contextPath}/rooms?category=${cat.id}'">
                        <div style="width: 100%; height: 300px; border-radius: 20px; background-image: url('${catImg}'); background-size: cover; background-position: center; margin-bottom: 1rem; box-shadow: var(--shadow);"></div>
                        <h3 style="color: var(--primary-color);">${cat.name}</h3>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Featured Rooms -->
    <section class="section" style="background: #f9f9f9;">
        <h2 class="section-title">Featured Accommodations</h2>
        <div class="grid">
            <c:forEach items="${featuredRooms}" var="room">
                <c:set var="roomImg" value="${not empty room.image1 ? room.image1 : 'assets/img/placeholder-room.jpg'}" />
                <div class="card">
                    <div class="card-img" style="background-image: url('${roomImg}');"></div>
                    <div class="card-content">
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:0.5rem;">
                            <h3 style="margin:0;">${room.roomName}</h3>
                            <span style="font-weight:700; color:var(--primary-color);">LKR ${room.pricePerNight}</span>
                        </div>
                        <p>${fn:substring(room.description, 0, 100)}...</p>
                        <a href="${pageContext.request.contextPath}/rooms?action=view&id=${room.id}" class="btn btn-primary" style="display:inline-block; margin-top:1rem;">View Details</a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div style="text-align: center; margin-top: 3rem;">
            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary" style="padding: 1rem 3rem;">View All Rooms</a>
        </div>
    </section>

    <!-- About Navigation -->
    <section class="section">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center; max-width: 1100px; margin: 0 auto;">
            <div>
                <img src="https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80" style="width: 100%; border-radius: 20px; box-shadow: var(--shadow);">
            </div>
            <div>
                <h2 class="section-title" style="text-align: left; margin-bottom: 1.5rem;">Discover Ocean View</h2>
                <p style="color: #666; line-height: 1.8; margin-bottom: 2rem;">
                    Experience the pinnacle of luxury and relaxation. From our world-class amenities to our dedicated staff, everything is designed to make your stay unforgettable.
                </p>
                <div style="display: flex; gap: 1rem;">
                    <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn-primary">About Us</a>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn" style="background: #eee; color: #333;">Contact Us</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Customer Reviews Carousel -->
    <section class="section" style="background: var(--bg-color);">
        <h2 class="section-title">What Our Guests Say</h2>
        <div class="reviews-carousel" style="max-width: 800px; margin: 0 auto; overflow: hidden; position: relative;">
            <div class="reviews-track" style="display: flex; transition: transform 0.5s ease;">
                <c:forEach items="${reviews}" var="review">
                    <div class="review-card" style="min-width: 100%; box-sizing: border-box; padding: 2rem; text-align: center;">
                        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: var(--shadow);">
                            <div style="color: #ffc107; margin-bottom: 1rem;">
                                <c:forEach begin="1" end="${review.rating}">
                                    <i class="fas fa-star"></i>
                                </c:forEach>
                                <c:forEach begin="1" end="${5 - review.rating}">
                                    <i class="far fa-star"></i>
                                </c:forEach>
                            </div>
                            <p style="font-size: 1.2rem; line-height: 1.6; font-style: italic; margin-bottom: 1.5rem;">"${review.feedback}"</p>
                            <h4 style="color: var(--primary-color);">- ${userMap[review.guestId]}</h4>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Simple Controls -->
            <button onclick="prevReview()" style="position: absolute; left: 0; top: 50%; transform: translateY(-50%); background: white; border: none; width: 40px; height: 40px; border-radius: 50%; box-shadow: var(--shadow); cursor: pointer;"><i class="fas fa-chevron-left"></i></button>
            <button onclick="nextReview()" style="position: absolute; right: 0; top: 50%; transform: translateY(-50%); background: white; border: none; width: 40px; height: 40px; border-radius: 50%; box-shadow: var(--shadow); cursor: pointer;"><i class="fas fa-chevron-right"></i></button>
        </div>
    </section>

    <!-- Help & Support Teaser -->
    <section class="section" style="background: var(--primary-color); color: white; text-align: center;">
        <h2 style="color: white; margin-bottom: 1rem;">Need Assistance?</h2>
        <p style="opacity: 0.9; max-width: 600px; margin: 0 auto 2rem;">Our support team is available 24/7 to help you with your booking or answer any questions you may have.</p>
        <a href="${pageContext.request.contextPath}/help.jsp" class="btn" style="background: white; color: var(--primary-color);">Visit Help Center</a>
    </section>

    <script>
        // Simple Carousel Logic
        let currentReview = 0;
        const track = document.querySelector('.reviews-track');
        const reviews = document.querySelectorAll('.review-card');
        
        function showReview(index) {
            if (reviews.length === 0) return;
            if (index < 0) index = reviews.length - 1;
            if (index >= reviews.length) index = 0;
            currentReview = index;
            if(track) track.style.transform = 'translateX(-' + (currentReview * 100) + '%)';
        }

        function nextReview() {
            showReview(currentReview + 1);
        }

        function prevReview() {
            showReview(currentReview - 1);
        }

        // Auto play
        if(reviews.length > 0) {
            setInterval(nextReview, 5000);
        }
    </script>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
