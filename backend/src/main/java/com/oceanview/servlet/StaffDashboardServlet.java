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
import java.util.stream.Collectors;

@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {
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

        List<Reservation> allReservations = reservationDAO.findAll();
        List<Room> allRooms = roomDAO.findAll();
        
        Date today = new Date();
        String todayStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today);

        // --- Calculate Stats ---
        
        // 1. Today's Check-ins
        long checkInsCount = allReservations.stream()
                .filter(r -> r.getCheckInDate() != null)
                .filter(r -> isSameDay(r.getCheckInDate(), today))
                .filter(r -> "accepted".equalsIgnoreCase(r.getStatus()))
                .count();

        // 2. Today's Check-outs
        long checkOutsCount = allReservations.stream()
                .filter(r -> r.getCheckOutDate() != null)
                .filter(r -> isSameDay(r.getCheckOutDate(), today))
                .filter(r -> "accepted".equalsIgnoreCase(r.getStatus()) || "completed".equalsIgnoreCase(r.getStatus()))
                .count();

        // 3. Pending Requests (Reservations pending approval)
        long pendingRequestsCount = allReservations.stream()
                .filter(r -> "pending".equalsIgnoreCase(r.getStatus()))
                .count();
        
        // 4. Dirty Rooms Count
        long dirtyRoomsCount = allRooms.stream()
                .filter(room -> "dirty".equalsIgnoreCase(room.getStatus()))
                .count();

        request.setAttribute("checkInsCount", checkInsCount);
        request.setAttribute("checkOutsCount", checkOutsCount);
        request.setAttribute("pendingRequestsCount", pendingRequestsCount);
        request.setAttribute("dirtyRoomsCount", dirtyRoomsCount);

        // --- Data for Lists ---
        
        // Dirty Rooms List (Limit 5 for dashboard)
        List<Room> dirtyRooms = allRooms.stream()
                .filter(room -> "dirty".equals(room.getStatus()))
                .limit(5)
                .collect(Collectors.toList());
        request.setAttribute("dirtyRooms", dirtyRooms);

        // Quick Arrival List (Today's Check-ins)
        List<Reservation> todaysArrivals = allReservations.stream()
                .filter(r -> r.getCheckInDate() != null)
                .filter(r -> isSameDay(r.getCheckInDate(), today))
                .filter(r -> "accepted".equals(r.getStatus()))
                .collect(Collectors.toList());
        request.setAttribute("todaysArrivals", todaysArrivals);

        request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
    }

    private boolean isSameDay(Date date1, Date date2) {
        if (date1 == null || date2 == null) return false;
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyyMMdd");
        return fmt.format(date1).equals(fmt.format(date2));
    }
}
