package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/staff/cleaning-schedule")
public class StaffCleaningServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch all rooms to iterate through
        List<Room> rooms = roomDAO.findAll();
        
        // Fetch only active reservations to map to rooms
        List<Reservation> activeReservations = reservationDAO.findAll().stream()
                .filter(r -> "accepted".equals(r.getStatus()) || 
                            ("pending".equals(r.getStatus()) && "paid".equals(r.getPaymentStatus())))
                .collect(Collectors.toList());

        // Create a map for easy lookup: RoomID -> Reservation
        Map<String, Reservation> activeResMap = activeReservations.stream()
                .collect(Collectors.toMap(Reservation::getRoomId, r -> r, (r1, r2) -> r1)); // duplicate handling: keep first
        
        request.setAttribute("rooms", rooms);
        request.setAttribute("activeResMap", activeResMap);
        
        request.getRequestDispatcher("/staff/cleaning-schedule.jsp").forward(request, response);
    }
}
