<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Ocean View Resort</title>
    <style>
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .form-group input.is-invalid {
            border-color: #dc3545;
            background-color: #fff5f5;
        }

        .form-group input.is-valid {
            border-color: #28a745;
        }

        .password-strength {
            margin-top: 0.5rem;
        }

        .strength-meter {
            height: 4px;
            background-color: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .strength-meter-fill {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease, background-color 0.3s ease;
        }

        .strength-meter-fill.weak {
            width: 25%;
            background-color: #dc3545;
        }

        .strength-meter-fill.fair {
            width: 50%;
            background-color: #ffc107;
        }

        .strength-meter-fill.good {
            width: 75%;
            background-color: #17a2b8;
        }

        .strength-meter-fill.strong {
            width: 100%;
            background-color: #28a745;
        }

        .strength-text {
            font-size: 0.875rem;
            font-weight: 500;
        }

        .strength-text.weak {
            color: #dc3545;
        }

        .strength-text.fair {
            color: #ffc107;
        }

        .strength-text.good {
            color: #17a2b8;
        }

        .strength-text.strong {
            color: #28a745;
        }

        .requirements {
            font-size: 0.875rem;
            margin-top: 0.75rem;
            padding: 0.75rem;
            background-color: #f8f9fa;
            border-radius: 4px;
            display: none;
        }

        .requirements.show {
            display: block;
        }

        .requirement {
            margin: 0.25rem 0;
            display: flex;
            align-items: center;
        }

        .requirement-icon {
            margin-right: 0.5rem;
            font-weight: bold;
        }

        .requirement.met {
            color: #28a745;
        }

        .requirement.unmet {
            color: #6c757d;
        }

        .requirement.unmet .requirement-icon::before {
            content: "✗";
        }

        .requirement.met .requirement-icon::before {
            content: "✓";
        }

        .form-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 0.75rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            display: none;
        }

        .form-error.show {
            display: block;
        }

        .success-message {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 0.75rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            display: none;
        }

        .success-message.show {
            display: block;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <div class="auth-container">
        <div class="auth-header">
            <h2>Start Your Journey</h2>
            <p>Create a customer account to book your stay</p>
        </div>

        <!-- Error Message Display -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="form-error show">
                <%= error %>
            </div>
        <% } %>

        <form id="registrationForm" action="${pageContext.request.contextPath}/register" method="POST">
            <!-- Username Field -->
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" required 
                       placeholder="3-20 characters (letters, numbers, _, -)">
                <div class="error-message" id="usernameError"></div>
            </div>

            <!-- Email Field -->
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required 
                       placeholder="you@example.com">
                <div class="error-message" id="emailError"></div>
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required 
                       placeholder="Enter a strong password">
                <div class="error-message" id="passwordError"></div>

                <!-- Password Strength Meter -->
                <div class="password-strength" id="passwordStrength" style="display: none;">
                    <div class="strength-meter">
                        <div class="strength-meter-fill" id="strengthMeterFill"></div>
                    </div>
                    <div class="strength-text" id="strengthText">Strength: Weak</div>
                </div>

                <!-- Password Requirements -->
                <div class="requirements" id="requirements">
                    <div class="requirement unmet" id="req-length">
                        <span class="requirement-icon"></span>
                        <span>Minimum 8 characters</span>
                    </div>
                    <div class="requirement unmet" id="req-uppercase">
                        <span class="requirement-icon"></span>
                        <span>At least one uppercase letter (A-Z)</span>
                    </div>
                    <div class="requirement unmet" id="req-lowercase">
                        <span class="requirement-icon"></span>
                        <span>At least one lowercase letter (a-z)</span>
                    </div>
                    <div class="requirement unmet" id="req-number">
                        <span class="requirement-icon"></span>
                        <span>At least one number (0-9)</span>
                    </div>
                    <div class="requirement unmet" id="req-special">
                        <span class="requirement-icon"></span>
                        <span>At least one special character (!@#$%^&*)</span>
                    </div>
                </div>
            </div>

            <!-- Confirm Password Field -->
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required 
                       placeholder="Re-enter your password">
                <div class="error-message" id="confirmPasswordError"></div>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%;">Create Account</button>
        </form>
        <p style="text-align: center; margin-top: 1.5rem;">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" style="color: var(--secondary-color); font-weight: 600;">Sign In</a>
        </p>
    </div>

    <jsp:include page="/components/footer.jsp" />

    <script>
        const form = document.getElementById('registrationForm');
        const usernameInput = document.getElementById('username');
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordStrength = document.getElementById('passwordStrength');
        const requirements = document.getElementById('requirements');

        // Username validation
        function validateUsername(username) {
            if (!username) return 'Username is required!';
            if (username.length < 3) return 'Username must be at least 3 characters long!';
            if (username.length > 20) return 'Username must not exceed 20 characters!';
            if (!/^[A-Za-z0-9_-]{3,20}$/.test(username)) {
                return 'Username can only contain letters, numbers, underscores, and hyphens!';
            }
            return null;
        }

        // Email validation
        function validateEmail(email) {
            if (!email) return 'Email address is required!';
            if (!/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
                return 'Please enter a valid email address!';
            }
            return null;
        }

        // Password validation
        function validatePassword(password) {
            if (!password) return 'Password is required!';
            if (password.length < 8) return 'Password must be at least 8 characters long!';
            if (!/[A-Z]/.test(password)) return 'Password must contain at least one uppercase letter!';
            if (!/[a-z]/.test(password)) return 'Password must contain at least one lowercase letter!';
            if (!/\d/.test(password)) return 'Password must contain at least one number!';
            if (!/[!@#$%^&*()_+\-=\[\]{};:'",.<>?/\\|`~]/.test(password)) {
                return 'Password must contain at least one special character (!@#$%^&* etc.)!';
            }
            return null;
        }

        // Calculate password strength
        function calculatePasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.length >= 12) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[!@#$%^&*()_+\-=\[\]{};:'",.<>?/\\|`~]/.test(password)) strength++;
            return strength;
        }

        // Get password strength level
        function getPasswordStrengthLevel(score) {
            if (score <= 2) return 'weak';
            if (score <= 3) return 'fair';
            if (score <= 4) return 'good';
            return 'strong';
        }

        // Update password strength meter
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            
            if (password.length === 0) {
                passwordStrength.style.display = 'none';
                requirements.classList.remove('show');
                return;
            }

            // Show requirements
            requirements.classList.add('show');

            // Update requirement indicators
            document.getElementById('req-length').classList.toggle('met', password.length >= 8);
            document.getElementById('req-length').classList.toggle('unmet', password.length < 8);
            
            document.getElementById('req-uppercase').classList.toggle('met', /[A-Z]/.test(password));
            document.getElementById('req-uppercase').classList.toggle('unmet', !/[A-Z]/.test(password));
            
            document.getElementById('req-lowercase').classList.toggle('met', /[a-z]/.test(password));
            document.getElementById('req-lowercase').classList.toggle('unmet', !/[a-z]/.test(password));
            
            document.getElementById('req-number').classList.toggle('met', /\d/.test(password));
            document.getElementById('req-number').classList.toggle('unmet', !/\d/.test(password));
            
            document.getElementById('req-special').classList.toggle('met', /[!@#$%^&*()_+\-=\[\]{};:'",.<>?/\\|`~]/.test(password));
            document.getElementById('req-special').classList.toggle('unmet', !/[!@#$%^&*()_+\-=\[\]{};:'",.<>?/\\|`~]/.test(password));

            // Update strength meter
            const strength = calculatePasswordStrength(password);
            const level = getPasswordStrengthLevel(strength);
            const strengthMeterFill = document.getElementById('strengthMeterFill');
            const strengthText = document.getElementById('strengthText');

            strengthMeterFill.className = `strength-meter-fill ${level}`;
            strengthText.className = `strength-text ${level}`;
            strengthText.textContent = `Strength: ${level.charAt(0).toUpperCase() + level.slice(1)}`;
            passwordStrength.style.display = 'block';
        });

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

        emailInput.addEventListener('blur', function() {
            const error = validateEmail(this.value);
            const errorDiv = document.getElementById('emailError');
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

        confirmPasswordInput.addEventListener('blur', function() {
            const errorDiv = document.getElementById('confirmPasswordError');
            if (passwordInput.value !== this.value) {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
                errorDiv.textContent = 'Passwords do not match!';
                errorDiv.classList.add('show');
            } else {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
                errorDiv.classList.remove('show');
            }
        });

        // Form submission validation
        form.addEventListener('submit', function(e) {
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

            const emailError = validateEmail(emailInput.value);
            if (emailError) {
                document.getElementById('emailError').textContent = emailError;
                document.getElementById('emailError').classList.add('show');
                emailInput.classList.add('is-invalid');
                isValid = false;
            }

            const passwordError = validatePassword(passwordInput.value);
            if (passwordError) {
                document.getElementById('passwordError').textContent = passwordError;
                document.getElementById('passwordError').classList.add('show');
                passwordInput.classList.add('is-invalid');
                isValid = false;
            }

            if (passwordInput.value !== confirmPasswordInput.value) {
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match!';
                document.getElementById('confirmPasswordError').classList.add('show');
                confirmPasswordInput.classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                this.submit();
            }
        });
    </script>
</body>
</html>
