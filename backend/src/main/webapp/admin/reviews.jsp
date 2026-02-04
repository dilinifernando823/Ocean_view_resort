<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <style>
        .star-rating { color: #ffcc00; font-size: 0.9rem; }
        .review-text { font-style: italic; color: #555; background: #f9f9f9; padding: 0.5rem; border-radius: 5px; border-left: 3px solid #ddd; }
        .status-pill { padding: 0.2rem 0.6rem; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
        .status-active { background: #e8f5e9; color: #2e7d32; }
        .status-hidden { background: #ffebee; color: #c62828; }
    </style>
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Guest Reviews Moderation</h2>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Guest / Room</th>
                            <th>Rating</th>
                            <th>Feedback</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="review" items="${reviews}">
                            <tr style="${review.isActive == 0 ? 'opacity: 0.7;' : ''}">
                                <td>
                                    <div style="font-weight: 600;">${guestMap[review.guestId]}</div>
                                    <div style="font-size: 0.8rem; color: #666;">Room: ${roomMap[review.roomId]}</div>
                                </td>
                                <td>
                                    <div class="star-rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="${i <= review.rating ? 'fas' : 'far'} fa-star"></i>
                                        </c:forEach>
                                    </div>
                                </td>
                                <td>
                                    <div class="review-text">${review.feedback}</div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${review.isActive == 1}">
                                            <span class="status-pill status-active">VISIBLE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-pill status-hidden">HIDDEN</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size: 0.85rem;">
                                    <fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.8rem;">
                                        <a href="${pageContext.request.contextPath}/admin/reviews?action=toggle&id=${review.id}" 
                                           title="${review.isActive == 1 ? 'Hide Review' : 'Show Review'}" 
                                           style="color: ${review.isActive == 1 ? '#f39c12' : '#27ae60'};">
                                            <i class="fas ${review.isActive == 1 ? 'fa-eye-slash' : 'fa-eye'}"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/reviews?action=delete&id=${review.id}" 
                                           title="Delete Permanently" style="color: #e74c3c;" 
                                           onclick="return confirm('Delete this review permanently?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty reviews}">
                    <div style="text-align: center; padding: 2rem; color: #888;">
                        <i class="far fa-comment-dots" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <p>No guest reviews found in the system.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
