<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="sidebar-header">
        ADMIN PANEL
    </div>
    <ul class="sidebar-menu">
        <li class="${pageContext.request.requestURI.contains('dashboard.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('rooms.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/rooms">
                <i class="fas fa-bed"></i> Manage Rooms
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('room-categories.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/categories">
                <i class="fas fa-tags"></i> Room Categories
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('users.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i> User Accounts
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('reservations.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/reservations">
                <i class="fas fa-calendar-alt"></i> Reservations
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('reviews.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/reviews">
                <i class="fas fa-star"></i> Reviews
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('help.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/help.jsp">
                <i class="fas fa-question-circle"></i> Admin Help
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
