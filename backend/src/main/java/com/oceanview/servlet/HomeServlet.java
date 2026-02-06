
package com.oceanview.servlet;

import com.oceanview.dao.ReviewDAO;
import com.oceanview.dao.RoomCategoryDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.Review;
import com.oceanview.model.Room;
import com.oceanview.model.RoomCategory;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/index"})
public class HomeServlet extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();
    private RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch Categories
        List<RoomCategory> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);

        // Fetch Featured Rooms (Latest 6)
        List<Room> allRooms = roomDAO.findAll();
        List<Room> featuredRooms = allRooms.stream()
                .limit(6)
                .collect(Collectors.toList());
        request.setAttribute("featuredRooms", featuredRooms);

        // Fetch Active Reviews
        List<Review> reviews = reviewDAO.findAll().stream()
                .filter(r -> r.getIsActive() == 1)
                .collect(Collectors.toList());
        request.setAttribute("reviews", reviews);

        // Map User IDs to Names for Reviews
        Map<String, String> userMap = new HashMap<>();
        for (Review review : reviews) {
            String guestId = review.getGuestId();
            if (!userMap.containsKey(guestId)) {
                User user = userDAO.findById(guestId);
                if (user != null) {
                    userMap.put(guestId, user.getFullName());
                } else {
                    userMap.put(guestId, "Guest");
                }
            }
        }
        request.setAttribute("userMap", userMap);
        request.setAttribute("isHomeLoaded", true);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
