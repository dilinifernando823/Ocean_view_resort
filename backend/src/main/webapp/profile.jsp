<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                <h3 style="margin-bottom: 1.5rem;">My Reservations</h3>
                <c:choose>
                    <c:when test="${empty reservations}">
                        <div style="background: white; padding: 2rem; border-radius: 20px; box-shadow: var(--shadow); text-align: center; color: #888;">
                            <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                            <p>You have no active or past reservations yet.</p>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary" style="display:inline-block; margin-top: 1rem;">Browse Rooms</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="display: grid; gap: 1.5rem;">
                            <c:forEach var="res" items="${reservations}">
                                <c:set var="room" value="${roomMap[res.roomId]}" />
                                <c:set var="statusStyle">
                                    <c:choose>
                                        <c:when test="${res.status == 'accepted'}">background: #d4edda; color: #155724;</c:when>
                                        <c:when test="${res.status == 'pending'}">background: #fff3cd; color: #856404;</c:when>
                                        <c:when test="${res.status == 'rejected'}">background: #f8d7da; color: #721c24;</c:when>
                                        <c:otherwise>background: #eee; color: #333;</c:otherwise>
                                    </c:choose>
                                </c:set>
                                <div style="background: white; padding: 1.5rem; border-radius: 20px; box-shadow: var(--shadow); display: flex; gap: 1.5rem; align-items: center;">
                                    <img src="${pageContext.request.contextPath}/${not empty room.image1 ? room.image1 : 'assets/img/placeholder-room.jpg'}" 
                                         style="width: 150px; height: 100px; object-fit: cover; border-radius: 12px;">
                                    <div style="flex: 1;">
                                        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                            <h4 style="color: var(--primary-color); font-size: 1.2rem; margin-bottom: 0.3rem;">${room.roomName}</h4>
                                            <span style="padding: 0.3rem 0.8rem; border-radius: 50px; font-size: 0.8rem; font-weight: 600; ${statusStyle}">
                                                ${fn:toUpperCase(fn:substring(res.status, 0, 1))}${fn:substring(res.status, 1, fn:length(res.status))}
                                            </span>
                                        </div>
                                        <div style="color: #666; font-size: 0.9rem; margin-bottom: 0.5rem;">
                                            <i class="fas fa-calendar-check"></i> 
                                            <fmt:formatDate value="${res.checkInDate}" pattern="MMM dd, yyyy" /> - 
                                            <fmt:formatDate value="${res.checkOutDate}" pattern="MMM dd, yyyy" />
                                        </div>
                                        <div style="color: #666; font-size: 0.85rem; margin-bottom: 0.8rem;">
                                            <span><i class="fas fa-users"></i> Guests: ${res.occupancy}</span>
                                            <c:if test="${not empty res.notes}">
                                                <div style="margin-top: 0.3rem; font-style: italic; color: #888;">
                                                    <i class="fas fa-sticky-note"></i> "${res.notes}"
                                                </div>
                                            </c:if>
                                            
                                            <%-- Add Review Button Logic --%>
                                            <c:if test="${(res.status == 'accepted' || res.status == 'completed') && empty reviewMap[res.id]}">
                                                <div style="margin-top: 1rem;">
                                                    <a href="${pageContext.request.contextPath}/add-review?reservationId=${res.id}" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #fffbe6; color: #f59e0b; border: 1px solid #f59e0b; border-radius: 8px;">
                                                        <i class="fas fa-star"></i> Write a Review
                                                    </a>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty reviewMap[res.id]}">
                                                 <div style="margin-top: 1rem; color: #f59e0b; font-size: 0.85rem; font-weight: 600;">
                                                    <i class="fas fa-check-circle"></i> Thanks for your review!
                                                </div>
                                            </c:if>
                                        </div>
                                        <div style="display: flex; justify-content: space-between; align-items: center;">
                                            <div style="font-weight: 700; color: var(--primary-color);">LKR ${res.totalAmount}</div>
                                            <div style="display: flex; gap: 0.8rem; align-items: center;">
                                                <c:choose>
                                                    <c:when test="${res.paymentStatus == 'paid'}">
                                                        <c:set var="inv" value="${invoiceMap[res.id]}" />
                                                        <c:if test="${not empty inv}">
                                                            <a href="${pageContext.request.contextPath}/customer/invoice?id=${inv.id}" class="btn" style="padding: 0.5rem 1rem; font-size: 0.8rem; background: #e3f2fd; color: #1976d2; border-radius: 8px;">
                                                                <i class="fas fa-file-invoice"></i> Download Invoice
                                                            </a>
                                                        </c:if>
                                                        <span style="color: #28a745; font-weight: 600; font-size: 0.85rem;">
                                                            <i class="fas fa-check-circle"></i> Paid
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${res.status == 'accepted' || res.status == 'pending'}">
                                                            <a href="${pageContext.request.contextPath}/pay?reservationId=${res.id}" class="btn btn-primary" style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                                                <i class="fas fa-credit-card"></i> Pay Now
                                                            </a>
                                                        </c:if>
                                                        <span style="color: #ffc107; font-weight: 600; font-size: 0.85rem;">
                                                            <i class="fas fa-clock"></i> Payment Pending
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
