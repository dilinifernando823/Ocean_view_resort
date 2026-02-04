<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <div class="auth-container">
        <div class="auth-header">
            <h2>Welcome Back</h2>
            <p>Please login to your account</p>
        </div>
        
        <c:if test="${not empty error}">
            <div style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="form-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem; font-size: 0.9rem;">
                <label><input type="checkbox"> Remember me</label>
                <a href="${pageContext.request.contextPath}/forgot-password.jsp" style="color: var(--secondary-color);">Forgot Password?</a>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Sign In</button>
        </form>
        <p style="text-align: center; margin-top: 1.5rem;">
            Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" style="color: var(--secondary-color); font-weight: 600;">Register Now</a>
        </p>
    </div>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
