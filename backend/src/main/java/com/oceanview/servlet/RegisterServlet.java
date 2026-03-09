package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    // Validation patterns
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern USERNAME_PATTERN = 
        Pattern.compile("^[A-Za-z0-9_-]{3,20}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Trim inputs
        username = username != null ? username.trim() : "";
        email = email != null ? email.trim() : "";
        password = password != null ? password : "";
        confirmPassword = confirmPassword != null ? confirmPassword : "";

        // Validate username
        String usernameError = validateUsername(username);
        if (usernameError != null) {
            request.setAttribute("error", usernameError);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Validate email
        String emailError = validateEmail(email);
        if (emailError != null) {
            request.setAttribute("error", emailError);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Validate password
        String passwordError = validatePassword(password);
        if (passwordError != null) {
            request.setAttribute("error", passwordError);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (userDAO.findByUsername(username) != null) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password); // In production: use bcrypt or similar
        user.setRole("customer"); // Default role
        user.setCreatedAt(new Date());
        user.setUpdatedAt(new Date());

        userDAO.save(user);

        response.sendRedirect(request.getContextPath() + "/login.jsp?success=1");
    }

    /**
     * Validates username
     * Requirements: 3-20 characters, alphanumeric with underscores and hyphens only
     */
    private String validateUsername(String username) {
        if (username == null || username.isEmpty()) {
            return "Username is required!";
        }
        if (username.length() < 3) {
            return "Username must be at least 3 characters long!";
        }
        if (username.length() > 20) {
            return "Username must not exceed 20 characters!";
        }
        if (!USERNAME_PATTERN.matcher(username).matches()) {
            return "Username can only contain letters, numbers, underscores, and hyphens!";
        }
        return null;
    }

    /**
     * Validates email format
     */
    private String validateEmail(String email) {
        if (email == null || email.isEmpty()) {
            return "Email address is required!";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Please enter a valid email address!";
        }
        return null;
    }

    /**
     * Validates password strength
     * Requirements:
     * - Minimum 8 characters
     * - At least 1 uppercase letter
     * - At least 1 lowercase letter
     * - At least 1 number
     * - At least 1 special character (!@#$%^&*)
     */
    private String validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            return "Password is required!";
        }
        if (password.length() < 8) {
            return "Password must be at least 8 characters long!";
        }
        if (!password.matches(".*[A-Z].*")) {
            return "Password must contain at least one uppercase letter!";
        }
        if (!password.matches(".*[a-z].*")) {
            return "Password must contain at least one lowercase letter!";
        }
        if (!password.matches(".*\\d.*")) {
            return "Password must contain at least one number!";
        }
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};:'\",.<>?/\\\\|`~].*")) {
            return "Password must contain at least one special character (!@#$%^&* etc.)!";
        }
        return null;
    }
}
