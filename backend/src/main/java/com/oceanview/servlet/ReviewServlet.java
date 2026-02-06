package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.ReviewDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Review;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/add-review")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String reservationId = request.getParameter("reservationId");
        if (reservationId == null || reservationId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile?error=missing_reservation");
            return;
        }

        // Validate that this reservation belongs to the user and is eligible for review
        Reservation res = reservationDAO.findById(reservationId);
        if (res == null || !res.getGuestId().equals(user.getId())) {
            response.sendRedirect(request.getContextPath() + "/profile?error=invalid_reservation");
            return;
        }

        // Check if review already exists
        if (reviewDAO.findByReservationId(reservationId) != null) {
            response.sendRedirect(request.getContextPath() + "/profile?error=review_exists");
            return;
        }

        request.setAttribute("reservation", res);
        request.getRequestDispatcher("/add-review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String reservationId = request.getParameter("reservationId");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String feedback = request.getParameter("feedback");

        Reservation res = reservationDAO.findById(reservationId);
        if (res == null || !res.getGuestId().equals(user.getId())) {
             response.sendRedirect(request.getContextPath() + "/profile?error=unauthorized");
             return;
        }

        // Double check duplication
        if (reviewDAO.findByReservationId(reservationId) != null) {
            response.sendRedirect(request.getContextPath() + "/profile?error=review_exists");
            return;
        }

        Review review = new Review();
        review.setReservationId(reservationId);
        review.setGuestId(user.getId());
        review.setRoomId(res.getRoomId());
        review.setRating(rating);
        review.setFeedback(feedback);
        review.setIsActive(1);
        review.setCreatedAt(new Date());
        review.setUpdatedAt(new Date());

        reviewDAO.save(review);
        response.sendRedirect(request.getContextPath() + "/profile?message=review_success");
    }
}
