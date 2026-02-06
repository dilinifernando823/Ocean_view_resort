<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Rooms & Suites | Ocean View Resort</title>
    <style>
        .rooms-page {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            padding: 3rem 5%;
        }

        /* Sidebar Styling */
        .filters-sidebar {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: var(--shadow);
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .filter-section {
            margin-bottom: 2rem;
        }

        .filter-section h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.8rem;
            border-radius: 12px;
            margin-bottom: 0.5rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            color: var(--text-color);
            border: 1px solid transparent;
        }

        .category-item:hover, .category-item.active {
            background: rgba(0, 170, 255, 0.1);
            border-color: var(--secondary-color);
        }

        .category-img {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
        }

        .category-info span {
            font-weight: 500;
            display: block;
        }

        /* Search & Date Filter */
        .search-box {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .search-box input {
            width: 100%;
            padding: 0.8rem 1rem 0.8rem 2.5rem;
            border: 1px solid #ddd;
            border-radius: 10px;
            outline: none;
        }

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        .date-inputs {
            display: grid;
            gap: 1rem;
        }

        /* Room Grid */
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        .room-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border: 1px solid #eee;
        }

        .room-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .room-img-wrapper {
            position: relative;
            height: 250px;
        }

        .room-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .room-price-tag {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--primary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 700;
            backdrop-filter: blur(5px);
        }

        .room-details {
            padding: 1.5rem;
        }

        .room-title {
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }

        .room-meta {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            color: #666;
            font-size: 0.9rem;
        }

        .room-meta span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .room-features {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-tag {
            background: #f0f4f8;
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            color: #555;
        }

        .card-actions {
            display: flex;
            gap: 1rem;
        }

        .btn-view {
            flex: 1;
            text-align: center;
            padding: 0.8rem;
            background: var(--primary-color);
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-view:hover {
            background: var(--secondary-color);
        }

        @media (max-width: 992px) {
            .rooms-page {
                grid-template-columns: 1fr;
            }
            .filters-sidebar {
                position: static;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="hero-small" style="background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');">
        <h1>Discover Your Perfect Stay</h1>
        <p>Luxury meets comfort in our curated selection of rooms</p>
    </section>

    <div class="rooms-page">
        <!-- Sidebar Filters -->
        <aside class="filters-sidebar">
            <form action="${pageContext.request.contextPath}/rooms" method="GET">
                <div class="filter-section">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" name="search" placeholder="Search rooms..." value="${param.search}">
                    </div>
                </div>

                <div class="filter-section">
                    <h3><i class="fas fa-calendar-alt"></i> Availability</h3>
                    <div class="date-inputs">
                        <div class="form-group">
                            <label>Check-in</label>
                            <input type="date" name="checkIn" class="form-control" value="${param.checkIn}">
                        </div>
                        <div class="form-group">
                            <label>Check-out</label>
                            <input type="date" name="checkOut" class="form-control" value="${param.checkOut}">
                        </div>
                    </div>
                </div>

                <div class="filter-section">
                    <h3><i class="fas fa-tags"></i> Categories</h3>
                    <a href="${pageContext.request.contextPath}/rooms" class="category-item ${empty param.category or param.category == 'all' ? 'active' : ''}">
                        <div class="category-info"><span>All Rooms</span></div>
                    </a>
                    <c:forEach var="cat" items="${categories}">
                        <a href="${pageContext.request.contextPath}/rooms?category=${cat.id}" class="category-item ${param.category == cat.id ? 'active' : ''}">
                            <img src="${pageContext.request.contextPath}/${cat.image}" alt="${cat.name}" class="category-img">
                            <div class="category-info">
                                <span>${cat.name}</span>
                            </div>
                        </a>
                    </c:forEach>
                    <input type="hidden" name="category" value="${param.category}">
                </div>

                <div class="filter-section">
                    <h3><i class="fas fa-dollar-sign"></i> Max Price</h3>
                    <input type="range" name="maxPrice" min="0" max="50000" step="500" value="${param.maxPrice != null ? param.maxPrice : 50000}" 
                           oninput="this.nextElementSibling.value = 'Up to LKR ' + this.value" style="width: 100%;">
                    <output style="display: block; text-align: center; margin-top: 0.5rem; font-weight: 600;">
                        Up to LKR ${param.maxPrice != null ? param.maxPrice : 50000}
                    </output>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Apply Filters</button>
                <a href="${pageContext.request.contextPath}/rooms" class="btn" style="width: 100%; display: block; text-align: center; margin-top: 0.5rem; background: #eee; color: #333;">Reset</a>
            </form>
        </aside>

        <!-- Room Listing -->
        <main class="rooms-container">
            <c:if test="${empty rooms}">
                <div style="text-align: center; padding: 5rem; background: white; border-radius: 20px;">
                    <i class="fas fa-search" style="font-size: 3rem; color: #ddd; margin-bottom: 1rem;"></i>
                    <h3>No rooms found matching your criteria</h3>
                    <p>Try adjusting your filters or search terms</p>
                </div>
            </c:if>
            
            <div class="rooms-grid">
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card">
                        <div class="room-img-wrapper">
                            <img src="${pageContext.request.contextPath}/${not empty room.image1 ? room.image1 : 'assets/img/placeholder-room.jpg'}" alt="${room.roomName}" class="room-img">
                            <div class="room-price-tag">LKR ${room.pricePerNight} / Night</div>
                        </div>
                        <div class="room-details">
                            <h2 class="room-title">${room.roomName}</h2>
                            <div class="room-meta">
                                <span><i class="fas fa-user-friends"></i> Up to ${room.capacity} Guests</span>
                                <span><i class="fas fa-door-open"></i> Room ${room.roomNumber}</span>
                            </div>
                            <div class="room-features">
                                <c:forEach var="amenity" items="${fn:split(room.amenities, ',')}">
                                    <span class="feature-tag">${fn:trim(amenity)}</span>
                                </c:forEach>
                            </div>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/rooms?action=view&id=${room.id}" class="btn-view">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
