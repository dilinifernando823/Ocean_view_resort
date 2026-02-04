<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <div class="auth-container">
        <div class="auth-header">
            <h2>Start Your Journey</h2>
            <p>Create a customer account to book your stay</p>
        </div>
        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Create Account</button>
        </form>
        <p style="text-align: center; margin-top: 1.5rem;">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" style="color: var(--secondary-color); font-weight: 600;">Sign In</a>
        </p>
    </div>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
