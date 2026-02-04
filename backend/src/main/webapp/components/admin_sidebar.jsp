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
        <li>
            <a href="#">
                <i class="fas fa-bed"></i> Manage Rooms
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-tags"></i> Room Categories
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-users"></i> User Accounts
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-calendar-check"></i> All Reservations
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-file-invoice-dollar"></i> Invoices
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-star"></i> Reviews
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
