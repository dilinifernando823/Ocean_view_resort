<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${room.roomName} | Ocean View Resort</title>
    <style>
        .details-page {
            padding: 3rem 10%;
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 3rem;
        }

        /* Gallery Styling - Premium Version */
        .gallery-container {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .main-image-display {
            width: 100%;
            height: 500px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            background: #eee;
        }

        .main-image-display img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: opacity 0.3s ease;
        }

        .thumbnail-row {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            padding-bottom: 5px;
            scrollbar-width: thin;
        }

        .thumbnail {
            width: 100px;
            height: 70px;
            border-radius: 10px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            transition: var(--transition);
            opacity: 0.6;
        }

        .thumbnail:hover {
            opacity: 1;
        }

        .thumbnail.active {
            border-color: var(--secondary-color);
            opacity: 1;
            box-shadow: 0 4px 10px rgba(0, 170, 255, 0.2);
        }

        /* Room Info */
        .room-info h1 {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .category-badge {
            display: inline-block;
            background: rgba(0, 170, 255, 0.1);
            color: var(--secondary-color);
            padding: 0.3rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .description {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 2rem;
            line-height: 1.8;
        }

        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .amenity-item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            color: #444;
        }

        .amenity-item i {
            color: var(--secondary-color);
            font-size: 1.2rem;
        }

        /* Booking Card */
        .booking-card {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .price-display {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        }

        .price-display span {
            font-size: 1rem;
            font-weight: 500;
            color: #666;
        }

        .availability-status {
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 600;
        }

        .status-available {
            background: #d4edda;
            color: #155724;
        }

        .status-unavailable {
            background: #f8d7da;
            color: #721c24;
        }

        .booking-summary {
            background: #f9f9f9;
            padding: 1.5rem;
            border-radius: 12px;
            margin-top: 1.5rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .summary-total {
            border-top: 1px solid #ddd;
            padding-top: 1rem;
            margin-top: 1rem;
            font-weight: 800;
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        @media (max-width: 992px) {
            .details-page {
                grid-template-columns: 1fr;
            }
            .carousel-container {
                height: 350px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <div class="details-page">
        <!-- Room Content -->
        <div class="content">
            <div class="gallery-container">
                <div class="main-image-display">
                    <c:choose>
                        <c:when test="${not empty room.image1}">
                            <img src="${pageContext.request.contextPath}/${room.image1}" id="mainDisplayImg" alt="${room.roomName}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/img/placeholder-room.jpg" id="mainDisplayImg" alt="Placeholder">
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="thumbnail-row">
                    <c:if test="${not empty room.image1}">
                        <img src="${pageContext.request.contextPath}/${room.image1}" class="thumbnail active" onclick="updateMainImage(this.src, this)">
                    </c:if>
                    <c:if test="${not empty room.image2}">
                        <img src="${pageContext.request.contextPath}/${room.image2}" class="thumbnail" onclick="updateMainImage(this.src, this)">
                    </c:if>
                    <c:if test="${not empty room.image3}">
                        <img src="${pageContext.request.contextPath}/${room.image3}" class="thumbnail" onclick="updateMainImage(this.src, this)">
                    </c:if>
                </div>
            </div>

            <div class="room-info" style="margin-top: 2rem;">
                <h1>${room.roomName}</h1>
                <div class="category-badge">${category.name}</div>
                
                <div class="description">
                    ${room.description}
                </div>

                <h3>Amenities & Features</h3>
                <div class="amenities-grid">
                    <c:forEach var="amenity" items="${fn:split(room.amenities, ',')}">
                        <div class="amenity-item">
                            <i class="fas fa-check-circle"></i>
                            <span>${fn:trim(amenity)}</span>
                        </div>
                    </c:forEach>
                    <div class="amenity-item">
                        <i class="fas fa-users"></i>
                        <span>Max Capacity: ${room.capacity} Guests</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Sidebar -->
        <aside class="sidebar">
            <div class="booking-card">
                <div class="price-display">
                    LKR ${room.pricePerNight} <span>/ night</span>
                </div>

                <form action="${pageContext.request.contextPath}/rooms" method="GET" id="availabilityForm">
                    <input type="hidden" name="action" value="checkAvailability">
                    <input type="hidden" name="id" value="${room.id}">
                    <input type="hidden" name="roomId" value="${room.id}">
                    
                    <div class="form-group">
                        <label>Stay Dates</label>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 0.5rem;">
                            <div>
                                <small style="display:block; color:#888; margin-bottom: 2px;">Check-in</small>
                                <input type="date" name="checkIn" class="form-control" value="${checkIn != null ? checkIn : param.checkIn}" required>
                            </div>
                            <div>
                                <small style="display:block; color:#888; margin-bottom: 2px;">Check-out</small>
                                <input type="date" name="checkOut" class="form-control" value="${checkOut != null ? checkOut : param.checkOut}" required>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Check Availability</button>
                </form>

                <c:if test="${isAvailable != null}">
                    <div class="availability-status ${isAvailable ? 'status-available' : 'status-unavailable'}" style="margin-top: 1.5rem;">
                        <c:choose>
                            <c:when test="${isAvailable}">
                                <i class="fas fa-check-circle"></i> Room is Available!
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-times-circle"></i> Room is Booked for these dates
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${isAvailable}">
                        <form action="${pageContext.request.contextPath}/reserve" method="POST" style="margin-top: 1.5rem;">
                            <input type="hidden" name="roomId" value="${room.id}">
                            <input type="hidden" name="checkIn" value="${checkIn}">
                            <input type="hidden" name="checkOut" value="${checkOut}">
                            <input type="hidden" name="totalAmount" value="${totalAmount}">
                            
                            <div class="form-group">
                                <label>Number of Guests</label>
                                <input type="number" name="occupancy" class="form-control" min="1" max="${room.capacity}" value="1" required>
                                <small style="color: #888;">Max capacity: ${room.capacity} guests</small>
                            </div>

                            <div class="form-group">
                                <label>Extra Notes (Optional)</label>
                                <textarea name="notes" class="form-control" rows="3" placeholder="Special requests, dietary needs, etc."></textarea>
                            </div>

                            <div class="booking-summary" style="margin-bottom: 1.5rem;">
                                <div class="summary-row">
                                    <span>LKR ${room.pricePerNight} x ${days} nights</span>
                                    <span>LKR ${totalAmount}</span>
                                </div>
                                <div class="summary-total">
                                    <span>Total Amount</span>
                                    <span>LKR ${totalAmount}</span>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <button type="submit" class="btn btn-primary" style="width: 100%; height: 60px; font-size: 1.2rem; background: #28a745;">Confirm Booking</button>
                                </c:when>
                                <c:otherwise>
                                    <div style="text-align:center;">
                                        <p style="margin-bottom: 1rem; color:#666;">Please login to complete your booking</p>
                                        <a href="${pageContext.request.contextPath}/login.jsp?error=login_required" class="btn btn-primary" style="width: 100%; display: block; text-align: center;">Login to Book</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </aside>
    </div>

    <script>
        function updateMainImage(src, thumbElement) {
            const mainImg = document.getElementById('mainDisplayImg');
            if (!mainImg) return;
            
            // Fade effect
            mainImg.style.opacity = '0.4';
            
            setTimeout(() => {
                mainImg.src = src;
                mainImg.style.opacity = '1';
                
                // Update active thumbnail
                document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
                thumbElement.classList.add('active');
            }, 200);
        }

        // Set min date for date inputs to today
        const today = new Date().toISOString().split('T')[0];
        document.querySelectorAll('input[type="date"]').forEach(input => {
            input.setAttribute('min', today);
        });
    </script>
    <jsp:include page="/components/footer.jsp" />
</body>
</html>
