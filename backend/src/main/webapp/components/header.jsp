<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
        <img src="${pageContext.request.contextPath}/assets/about_header.png" alt="Ocean View Resort" style="height: 50px; width: auto; object-fit: contain;">
    </a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
        <li><a href="${pageContext.request.contextPath}/rooms">Rooms</a></li>
        <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/help.jsp">Help</a></li>
    </ul>
    <div class="auth-icons">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" title="Dashboard"><i class="fas fa-chart-line"></i></a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'staff'}">
                        <a href="${pageContext.request.contextPath}/staff/dashboard.jsp" title="Staff Panel"><i class="fas fa-clipboard-list"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/profile" title="Profile"><i class="fas fa-user-circle"></i></a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/logout" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" title="Login"><i class="fas fa-user"></i></a>
            </c:otherwise>
        </c:choose>
    </div>
</header>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
