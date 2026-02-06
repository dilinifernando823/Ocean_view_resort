<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="sidebar-header" style="background: #2e3b4e;">
        STAFF PANEL
    </div>
    <ul class="sidebar-menu">
        <li class="${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/dashboard">
                <i class="fas fa-th-large"></i> Overview
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-door-open"></i> Check-in / Out
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('cleaning-schedule') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/cleaning-schedule">
                <i class="fas fa-broom"></i> Room Cleaning
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('guest-list') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/guest-list">
                <i class="fas fa-users"></i> Guest List
            </a>
        </li>
        <li class="${pageContext.request.requestURI.contains('help.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/help.jsp">
                <i class="fas fa-question-circle"></i> Staff Help
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
