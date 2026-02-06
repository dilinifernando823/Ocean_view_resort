package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.UserDAO;
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
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Reservation> allReservations = reservationDAO.findAll();
        List<Room> allRooms = roomDAO.findAll();
        List<User> allUsers = userDAO.findAll();

        // 1. Total Rooms
        int totalRooms = allRooms.size();

        // 2. Active Bookings (Accepted)
        long activeBookings = allReservations.stream()
                .filter(r -> "accepted".equalsIgnoreCase(r.getStatus()))
                .count();

        // 3. Total Guests (Customers)
        long totalGuests = allUsers.stream()
                .filter(u -> "customer".equalsIgnoreCase(u.getRole()))
                .count();

        // 4. Total Income (Sum of accepted/paid reservations)
        double totalIncome = allReservations.stream()
                .filter(r -> "accepted".equalsIgnoreCase(r.getStatus()) || "paid".equalsIgnoreCase(r.getPaymentStatus()))
                .mapToDouble(Reservation::getTotalAmount)
                .sum();


        // Recent Reservations (limit 5)
        List<Reservation> recentReservations = allReservations.stream()
                .sorted((r1, r2) -> r2.getCreatedAt().compareTo(r1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        
        // Map data for Recent Reservations table (Guest Name and Room Number)
        Map<String, String> guestNames = new HashMap<>();
        Map<String, String> roomNumbers = new HashMap<>();
        for(Reservation r : recentReservations) {
            User u = userDAO.findById(r.getGuestId());
            if(u != null) guestNames.put(r.getGuestId(), u.getFullName());
            
            Room room = roomDAO.findById(r.getRoomId());
            if(room != null) roomNumbers.put(r.getRoomId(), room.getRoomNumber() + " (" + room.getRoomName() + ")");
        }


        // Chart Data Preparation
        
        // A. Bookings by Month (Last 6 months)
        Map<String, Integer> monthlyBookings = new LinkedHashMap<>();
        SimpleDateFormat monthFormat = new SimpleDateFormat("MMM yyyy", Locale.US);
        Calendar cal = Calendar.getInstance();
        
        // Initialize last 6 months with 0
        for (int i = 5; i >= 0; i--) {
            cal.setTime(new Date());
            cal.add(Calendar.MONTH, -i);
            monthlyBookings.put(monthFormat.format(cal.getTime()), 0);
        }
        
        for (Reservation r : allReservations) {
            if (r.getCreatedAt() != null) {
                String monthKey = monthFormat.format(r.getCreatedAt());
                if (monthlyBookings.containsKey(monthKey)) {
                    monthlyBookings.put(monthKey, monthlyBookings.get(monthKey) + 1);
                }
            }
        }
        
        // Arrays for Chart.js
        String chartLabels = "['" + String.join("', '", monthlyBookings.keySet()) + "']";
        String chartData = "[" + monthlyBookings.values().stream().map(String::valueOf).collect(Collectors.joining(", ")) + "]";


        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("activeBookings", activeBookings);
        request.setAttribute("totalGuests", totalGuests);
        request.setAttribute("totalIncome", totalIncome);
        request.setAttribute("recentReservations", recentReservations);
        request.setAttribute("guestNames", guestNames);
        request.setAttribute("roomNumbers", roomNumbers);
        
        request.setAttribute("chartLabels", chartLabels);
        request.setAttribute("chartData", chartData);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
