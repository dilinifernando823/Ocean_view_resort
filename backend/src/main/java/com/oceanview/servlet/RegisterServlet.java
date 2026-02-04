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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.findByUsername(username) != null) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password); // In a real app, hash this!
        user.setRole("customer"); // Default role
        user.setCreatedAt(new Date());
        user.setUpdatedAt(new Date());

        userDAO.save(user);

        response.sendRedirect(request.getContextPath() + "/login.jsp?success=1");
    }
}
