<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Ocean View Resort</title>
    <style>
        .error-message {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .warning-message {
            background: #fff3cd;
            border: 1px solid #ffeeba;
            color: #856404;
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
        }

        .error-message.locked {
            background: #f8d7da;
            border: 2px solid #dc3545;
        }

        .form-field-error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }

        .form-field-error.show {
            display: block;
        }

        .form-control.is-invalid {
            border-color: #dc3545;
            background-color: #fff5f5;
        }

        .form-control.is-valid {
            border-color: #28a745;
        }

        .info-text {
            font-size: 0.875rem;
            margin-top: 1rem;
            padding: 0.75rem;
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
            border-radius: 4px;
            text-align: center;
        }

        .loading-spinner {
            display: none;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <div class="auth-container">
        <div class="auth-header">
            <h2>Welcome Back</h2>
            <p>Please login to your account</p>
        </div>
        
        <!-- Success Message -->
        <c:if test="${not empty param.success}">
            <div style="background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 0.75rem; border-radius: 8px; margin-bottom: 1.5rem; text-align: center;">
                Account created successfully! Please login.
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="error-message ${locked == 'true' ? 'locked' : ''}">
                ${error}
            </div>
        </c:if>

        <!-- Form -->
        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="POST" ${locked == 'true' ? 'style="opacity: 0.5; pointer-events: none;"' : ''}>
            <div class="form-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" class="form-control" required 
                       placeholder="Enter your username or email" ${locked == 'true' ? 'disabled' : ''}>
                <div class="form-field-error" id="usernameError"></div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required 
                       placeholder="Enter your password" ${locked == 'true' ? 'disabled' : ''}>
                <div class="form-field-error" id="passwordError"></div>
            </div>

            <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem; font-size: 0.9rem;">
                <label><input type="checkbox" name="remember"> Remember me</label>
                <a href="${pageContext.request.contextPath}/forgot-password.jsp" style="color: var(--secondary-color);">Forgot Password?</a>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%;" ${locked == 'true' ? 'disabled' : ''}>
                <span>Sign In</span>
                <span class="loading-spinner" style="display: none;">
                    <i class="fas fa-spinner fa-spin"></i> Signing in...
                </span>
            </button>
        </form>

        <!-- Info Messages -->
        <c:if test="${locked == 'true'}">
            <div class="info-text">
                ⏱️ Too many failed attempts. Please wait 1 minute before trying again.
            </div>
        </c:if>

        <p style="text-align: center; margin-top: 1.5rem;">
            Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" style="color: var(--secondary-color); font-weight: 600;">Register Now</a>
        </p>
    </div>

    <jsp:include page="/components/footer.jsp" />

    <script>
        const form = document.getElementById('loginForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const isLocked = ${locked == 'true' ? 'true' : 'false'};

        // Validation functions
        function validateUsername(username) {
            if (!username) return 'Username or email is required!';
            if (username.length < 3) return 'Please enter a valid username or email!';
            return null;
        }

        function validatePassword(password) {
            if (!password) return 'Password is required!';
            if (password.length < 1) return 'Password cannot be empty!';
            return null;
        }

        // Real-time validation
        usernameInput.addEventListener('blur', function() {
            const error = validateUsername(this.value);
            const errorDiv = document.getElementById('usernameError');
            if (error) {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
                errorDiv.textContent = error;
                errorDiv.classList.add('show');
            } else {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
                errorDiv.classList.remove('show');
            }
        });

        usernameInput.addEventListener('input', function() {
            if (this.classList.contains('is-invalid')) {
                const error = validateUsername(this.value);
                if (!error) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                    document.getElementById('usernameError').classList.remove('show');
                }
            }
        });

        passwordInput.addEventListener('blur', function() {
            const error = validatePassword(this.value);
            const errorDiv = document.getElementById('passwordError');
            if (error) {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
                errorDiv.textContent = error;
                errorDiv.classList.add('show');
            } else {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
                errorDiv.classList.remove('show');
            }
        });

        passwordInput.addEventListener('input', function() {
            if (this.classList.contains('is-invalid')) {
                const error = validatePassword(this.value);
                if (!error) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                    document.getElementById('passwordError').classList.remove('show');
                }
            }
        });

        // Form submission
        form.addEventListener('submit', function(e) {
            if (isLocked) {
                e.preventDefault();
                alert('Too many failed login attempts. Please try again in 1 minute.');
                return;
            }

            e.preventDefault();

            let isValid = true;

            // Validate all fields
            const usernameError = validateUsername(usernameInput.value);
            if (usernameError) {
                document.getElementById('usernameError').textContent = usernameError;
                document.getElementById('usernameError').classList.add('show');
                usernameInput.classList.add('is-invalid');
                isValid = false;
            }

            const passwordError = validatePassword(passwordInput.value);
            if (passwordError) {
                document.getElementById('passwordError').textContent = passwordError;
                document.getElementById('passwordError').classList.add('show');
                passwordInput.classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                // Show loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                const btnText = submitBtn.querySelector('span');
                const spinner = submitBtn.querySelector('.loading-spinner');
                
                submitBtn.disabled = true;
                btnText.style.display = 'none';
                spinner.style.display = 'inline';

                // Submit form
                this.submit();
            }
        });

        // Clear validation errors when user starts typing
        [usernameInput, passwordInput].forEach(input => {
            input.addEventListener('focus', function() {
                if (this.classList.contains('is-invalid')) {
                    // Keep the error visible for now
                }
            });
        });
    </script>
</body>
</html>
