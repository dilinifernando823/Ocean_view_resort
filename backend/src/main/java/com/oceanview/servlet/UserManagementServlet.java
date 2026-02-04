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
import java.util.List;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            User user = userDAO.findById(id);
            request.setAttribute("userToEdit", user);
            request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            User currentUser = (User) request.getSession().getAttribute("user");
            
            // Prevent deleting self
            if (currentUser != null && !currentUser.getId().equals(id)) {
                userDAO.delete(id);
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else if ("new".equals(action)) {
            request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
        } else {
            List<User> users = userDAO.findAll();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");

        User user;
        if (id != null && !id.isEmpty()) {
            user = userDAO.findById(id);
        } else {
            user = new User();
            user.setCreatedAt(new Date());
            user.setPassword(password); // Only set password on creation for simplicity
        }

        user.setUsername(username);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setRole(role);
        user.setPhone(phone);
        user.setNic(nic);
        user.setAddress(address);
        user.setUpdatedAt(new Date());

        userDAO.save(user);
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
