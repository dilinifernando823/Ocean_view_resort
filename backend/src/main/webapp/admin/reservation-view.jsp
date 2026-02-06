<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Details | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <style>
        .detail-card { background: white; border-radius: 12px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        .detail-card h3 { margin-top: 0; color: #333; font-weight: 700; margin-bottom: 1.5rem; border-bottom: 2px solid #f0f0f0; padding-bottom: 0.5rem; }
        .info-row { display: flex; margin-bottom: 1rem; }
        .info-label { width: 150px; color: #888; font-size: 0.9rem; font-weight: 500; }
        .info-value { flex: 1; color: #333; font-weight: 600; }
        .action-bar { display: flex; gap: 1rem; margin-top: 2rem; padding: 1.5rem; background: #f8f9fa; border-radius: 10px; }
    </style>
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Reservation #${res.id}</h2>
            <a href="${pageContext.request.contextPath}/admin/reservations" class="btn" style="background: #eee; color: #333;">Back to List</a>
        </header>

        <div class="dashboard-container">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                
                <%-- Guest and Reservation Info --%>
                <div>
                    <div class="detail-card">
                        <h3>Guest Details</h3>
                        <div class="info-row">
                            <div class="info-label">Full Name</div>
                            <div class="info-value">${guest.fullName}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Email</div>
                            <div class="info-value">${guest.email}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Phone</div>
                            <div class="info-value">${guest.phone}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">NIC</div>
                            <div class="info-value">${guest.nic}</div>
                        </div>
                    </div>

                    <div class="detail-card">
                        <h3>Reservation Info</h3>
                        <div class="info-row">
                            <div class="info-label">Check-in</div>
                            <div class="info-value"><fmt:formatDate value="${res.checkInDate}" pattern="EEEE, MMMM dd, yyyy" /></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Check-out</div>
                            <div class="info-value"><fmt:formatDate value="${res.checkOutDate}" pattern="EEEE, MMMM dd, yyyy" /></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Total Amount</div>
                            <div class="info-value" style="font-size: 1.2rem; color: #2c3e50;">Rs. ${res.totalAmount}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Current Status</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${res.status == 'pending'}"><span class="badge badge-warning">Pending</span></c:when>
                                    <c:when test="${res.status == 'accepted'}"><span class="badge badge-success">Accepted</span></c:when>
                                    <c:when test="${res.status == 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                                    <c:otherwise><span class="badge badge-secondary">${res.status}</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Payment Status</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${res.paymentStatus == 'paid'}">
                                        <span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Paid</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #e67e22;"><i class="fas fa-clock"></i> Unpaid</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Room Info and Actions --%>
                <div>
                    <div class="detail-card">
                        <h3>Room Details</h3>
                        <img src="${pageContext.request.contextPath}/${room.image1}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem;">
                        <div class="info-row">
                            <div class="info-label">Room Number</div>
                            <div class="info-value">#${room.roomNumber}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Room Name</div>
                            <div class="info-value">${room.roomName}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Price / Night</div>
                            <div class="info-value">Rs. ${room.pricePerNight}</div>
                        </div>
                    </div>

                    <div class="detail-card">
                        <h3>Actions</h3>
                        <c:choose>
                            <c:when test="${res.status == 'pending'}">
                                <div style="display: flex; gap: 1rem;">
                                    <a href="${pageContext.request.contextPath}/admin/reservations?action=status&type=accepted&id=${res.id}" class="btn btn-primary" style="flex: 1; text-align: center;">Accept Reservation</a>
                                    <a href="${pageContext.request.contextPath}/admin/reservations?action=status&type=rejected&id=${res.id}" class="btn" style="flex: 1; text-align: center; background: #e74c3c; color: white;">Reject</a>
                                </div>
                            </c:when>
                            <c:when test="${res.status == 'accepted' && res.paymentStatus != 'paid'}">
                                <div style="text-align: center;">
                                    <p style="color: #666; margin-bottom: 1.5rem;">The reservation is accepted. Complete the process by receiving cash payment.</p>
                                    <a href="${pageContext.request.contextPath}/admin/reservations?action=pay&id=${res.id}" class="btn btn-primary" style="width: 100%; text-align: center; padding: 1rem;">
                                        <i class="fas fa-dollar-sign"></i> Get Cash & Create Invoice
                                    </a>
                                </div>
                            </c:when>
                            <c:when test="${res.paymentStatus == 'paid' && invoice != null}">
                                <div style="text-align: center;">
                                    <div style="background: #e8f5e9; color: #2e7d32; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; font-weight: 600;">
                                        <i class="fas fa-check-circle"></i> Process Completed Successfully
                                    </div>
                                    <a href="${pageContext.request.contextPath}/admin/invoice?id=${invoice.id}" class="btn btn-primary" style="width: 100%; text-align: center;">
                                        <i class="fas fa-file-invoice"></i> View / Print Invoice
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; color: #888;">No further actions available for this status.</div>
                            </c:otherwise>
                        </c:choose>
                        
                        <%-- Permanent Delete Option --%>
                        <div style="margin-top: 2rem; border-top: 1px solid #eee; text-align: center; padding-top: 1.5rem;">
                            <a href="${pageContext.request.contextPath}/admin/reservations?action=delete&id=${res.id}" 
                               style="color: #e74c3c; font-size: 0.9rem; text-decoration: none; font-weight: 600;"
                               onclick="return confirm('WARNING: This will permanently delete this reservation record. Continue?')">
                                <i class="fas fa-trash-alt"></i> Delete Reservation Permanently
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
