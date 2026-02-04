package com.oceanview.servlet;

import com.oceanview.dao.ReviewDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Review;
import com.oceanview.model.User;
import com.oceanview.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/reviews")
public class ReviewManagementServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private UserDAO userDAO = new UserDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action)) {
            reviewDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
            return;
        } else if ("toggle".equals(action)) {
            Review review = reviewDAO.findById(id);
            if (review != null) {
                review.setIsActive(review.getIsActive() == 1 ? 0 : 1);
                review.setUpdatedAt(new Date());
                reviewDAO.save(review);
            }
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
            return;
        }

        List<Review> reviews = reviewDAO.findAll();
        
        // Fetch extra info for display (Guest Name, Room No)
        Map<String, String> guestMap = new HashMap<>();
        Map<String, String> roomMap = new HashMap<>();
        
        for (Review r : reviews) {
            if (r.getGuestId() != null && !guestMap.containsKey(r.getGuestId())) {
                User u = userDAO.findById(r.getGuestId());
                if (u != null) guestMap.put(r.getGuestId(), u.getFullName() != null ? u.getFullName() : u.getUsername());
            }
            if (r.getRoomId() != null && !roomMap.containsKey(r.getRoomId())) {
                Room room = roomDAO.findById(r.getRoomId());
                if (room != null) roomMap.put(r.getRoomId(), room.getRoomNumber());
            }
        }

        request.setAttribute("reviews", reviews);
        request.setAttribute("guestMap", guestMap);
        request.setAttribute("roomMap", roomMap);
        request.getRequestDispatcher("/admin/reviews.jsp").forward(request, response);
    }
}
