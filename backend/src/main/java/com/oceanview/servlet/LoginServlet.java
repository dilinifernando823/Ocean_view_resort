package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    // Rate limiting constants
    private static final int MAX_ATTEMPTS = 5;
    private static final long ATTEMPT_WINDOW_MINUTES = 1;
    private static final long ATTEMPT_WINDOW_MILLIS = ATTEMPT_WINDOW_MINUTES * 60 * 1000;

    // Map to track login attempts: IP -> Queue of attempt timestamps
    private static Map<String, Queue<Long>> loginAttempts = new HashMap<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");

        // Get client IP
        String clientIP = getClientIP(request);

        // Trim inputs
        usernameOrEmail = usernameOrEmail != null ? usernameOrEmail.trim() : "";
        password = password != null ? password : "";

        // Validate inputs
        if (usernameOrEmail.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Username and password are required!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Check rate limiting
        String rateLimitError = checkRateLimit(clientIP);
        if (rateLimitError != null) {
            request.setAttribute("error", rateLimitError);
            request.setAttribute("locked", "true");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Record attempt
        recordLoginAttempt(clientIP);

        // Authenticate user
        User user = userDAO.findByUsername(usernameOrEmail);
        if (user == null) {
            user = userDAO.findByEmail(usernameOrEmail);
        }

        if (user != null && user.getPassword().equals(password)) {
            // Clear attempts on successful login
            loginAttempts.remove(clientIP);

            // Start session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on role
            String role = user.getRole();
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else if ("staff".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/profile.jsp");
            }
        } else {
            int attemptsRemaining = MAX_ATTEMPTS - getAttemptCount(clientIP);
            String error;
            if (attemptsRemaining <= 0) {
                error = "Too many failed attempts. Please try again in 1 minute.";
                request.setAttribute("locked", "true");
            } else {
                error = String.format("Invalid username or password! (%d attempt(s) remaining)", attemptsRemaining);
            }
            request.setAttribute("error", error);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Records a login attempt for the given IP address
     */
    private synchronized void recordLoginAttempt(String clientIP) {
        Queue<Long> attempts = loginAttempts.computeIfAbsent(clientIP, k -> new LinkedList<>());
        attempts.offer(System.currentTimeMillis());

        // Clean up old attempts outside the window
        long cutoffTime = System.currentTimeMillis() - ATTEMPT_WINDOW_MILLIS;
        while (!attempts.isEmpty() && attempts.peek() < cutoffTime) {
            attempts.poll();
        }
    }

    /**
     * Gets the count of attempts within the window
     */
    private synchronized int getAttemptCount(String clientIP) {
        Queue<Long> attempts = loginAttempts.get(clientIP);
        if (attempts == null || attempts.isEmpty()) {
            return 0;
        }

        long cutoffTime = System.currentTimeMillis() - ATTEMPT_WINDOW_MILLIS;
        int count = 0;
        for (Long timestamp : attempts) {
            if (timestamp >= cutoffTime) {
                count++;
            }
        }
        return count;
    }

    /**
     * Checks if the user has exceeded the rate limit
     * Returns error message if exceeded, null otherwise
     */
    private String checkRateLimit(String clientIP) {
        int attemptCount = getAttemptCount(clientIP);
        if (attemptCount >= MAX_ATTEMPTS) {
            return "Too many failed login attempts. Please try again in 1 minute.";
        }
        return null;
    }

    /**
     * Gets the client's IP address, handling proxy headers
     */
    private String getClientIP(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isEmpty()) {
            return xRealIp;
        }
        return request.getRemoteAddr();
    }
}
