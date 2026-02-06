package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomCategoryDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.model.RoomCategory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/rooms")
public class CustomerRoomServlet extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();
    private RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            showRoomDetails(request, response);
        } else if ("checkAvailability".equals(action)) {
            checkAvailability(request, response);
        } else {
            listRooms(request, response);
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Room> rooms = roomDAO.findAll();
        List<RoomCategory> categories = categoryDAO.findAll();

        // Filtering logic
        String categoryId = request.getParameter("category");
        String maxPriceStr = request.getParameter("maxPrice");
        String search = request.getParameter("search");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        if (categoryId != null && !categoryId.isEmpty() && !"all".equals(categoryId)) {
            rooms = rooms.stream()
                    .filter(r -> categoryId.equals(r.getCategoryId()))
                    .collect(Collectors.toList());
        }

        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            double maxPrice = Double.parseDouble(maxPriceStr);
            rooms = rooms.stream()
                    .filter(r -> r.getPricePerNight() <= maxPrice)
                    .collect(Collectors.toList());
        }

        if (search != null && !search.isEmpty()) {
            String searchLow = search.toLowerCase();
            rooms = rooms.stream()
                    .filter(r -> r.getRoomName().toLowerCase().contains(searchLow) || 
                                 r.getDescription().toLowerCase().contains(searchLow) ||
                                 r.getRoomNumber().toLowerCase().contains(searchLow))
                    .collect(Collectors.toList());
        }

        // Filter by date availability
        if (checkIn != null && !checkIn.isEmpty() && checkOut != null && !checkOut.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date start = sdf.parse(checkIn);
                Date end = sdf.parse(checkOut);
                
                List<String> bookedRoomIds = getBookedRoomIds(start, end);
                rooms = rooms.stream()
                        .filter(r -> !bookedRoomIds.contains(r.getId()))
                        .collect(Collectors.toList());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("rooms", rooms);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/rooms.jsp").forward(request, response);
    }

    private void showRoomDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Room room = roomDAO.findById(id);
        if (room != null) {
            RoomCategory category = categoryDAO.findById(room.getCategoryId());
            request.setAttribute("room", room);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/room-details.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/rooms");
        }
    }

    private void checkAvailability(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomId = request.getParameter("roomId");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        if (roomId == null || roomId.isEmpty() || checkIn == null || checkIn.isEmpty() || checkOut == null || checkOut.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/rooms?action=view&id=" + roomId + "&error=missing_fields");
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date start = sdf.parse(checkIn);
            Date end = sdf.parse(checkOut);
            
            // Normalize inputs to midnight
            start = normalizeDate(start);
            end = normalizeDate(end);

            // Validate dates
            Date today = normalizeDate(new Date());

            if (start.before(today)) {
                 response.sendRedirect(request.getContextPath() + "/rooms?action=view&id=" + roomId + "&error=past_date");
                 return;
            }

            if (end.before(start) || end.equals(start)) {
                 response.sendRedirect(request.getContextPath() + "/rooms?action=view&id=" + roomId + "&error=invalid_range");
                 return;
            }

            boolean isAvailable = isRoomAvailable(roomId, start, end);
            
            Room room = roomDAO.findById(roomId);
            if (room == null) {
                response.sendRedirect(request.getContextPath() + "/rooms?error=room_not_found");
                return;
            }
            RoomCategory category = categoryDAO.findById(room.getCategoryId());
            
            request.setAttribute("room", room);
            request.setAttribute("category", category);
            request.setAttribute("isAvailable", isAvailable);
            request.setAttribute("checkIn", checkIn);
            request.setAttribute("checkOut", checkOut);
            
            // Calculate total days and amount
            long diffInMillies = Math.abs(end.getTime() - start.getTime());
            long diffDays = diffInMillies / (1000 * 60 * 60 * 24);
            if (diffDays == 0) diffDays = 1;
            double totalAmount = diffDays * room.getPricePerNight();
            
            request.setAttribute("days", diffDays);
            request.setAttribute("totalAmount", totalAmount);

            request.getRequestDispatcher("/room-details.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in checkAvailability: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/rooms?action=view&id=" + roomId + "&error=invalid_dates_exception");
        }
    }

    private Date normalizeDate(Date date) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(date);
        cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
        cal.set(java.util.Calendar.MINUTE, 0);
        cal.set(java.util.Calendar.SECOND, 0);
        cal.set(java.util.Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    private boolean isRoomAvailable(String roomId, Date start, Date end) {
        try {
            List<Reservation> allReservations = reservationDAO.findAll();
            if (allReservations == null) return true;

            List<Reservation> reservations = allReservations.stream()
                    .filter(res -> res != null && res.getRoomId() != null && res.getRoomId().equals(roomId))
                    .filter(res -> res.getStatus() != null && !"cancelled".equals(res.getStatus()) && !"rejected".equals(res.getStatus()))
                    .collect(Collectors.toList());

            for (Reservation res : reservations) {
                if (res.getCheckInDate() != null && res.getCheckOutDate() != null) {
                    Date resStart = normalizeDate(res.getCheckInDate());
                    Date resEnd = normalizeDate(res.getCheckOutDate());
                    
                    System.out.println("Checking availability for Room: " + roomId);
                    System.out.println("  Request: " + start + " to " + end);
                    System.out.println("  Existing: " + resStart + " to " + resEnd + " (Res ID: " + res.getId() + ")");
                    
                    if (start.before(resEnd) && end.after(resStart)) {
                        System.out.println("  -> CONFLICT FOUND");
                        return false;
                    } else {
                        System.out.println("  -> No Conflict");
                    }
                } else {
                     System.out.println("Skipping reservation " + res.getId() + " due to null dates.");
                }
            }
            System.out.println("Room " + roomId + " is AVAILABLE.");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in isRoomAvailable: " + e.getMessage());
            return false; // Fail safe
        }
    }

    private List<String> getBookedRoomIds(Date start, Date end) {
        try {
            List<Reservation> allReservations = reservationDAO.findAll();
            if (allReservations == null) return new ArrayList<>();
            
            Date normStart = normalizeDate(start);
            Date normEnd = normalizeDate(end);

            return allReservations.stream()
                    .filter(res -> res != null && res.getStatus() != null && !"cancelled".equals(res.getStatus()) && !"rejected".equals(res.getStatus()))
                    .filter(res -> {
                        if (res.getCheckInDate() == null || res.getCheckOutDate() == null) return false;
                        Date resStart = normalizeDate(res.getCheckInDate());
                        Date resEnd = normalizeDate(res.getCheckOutDate());
                        return normStart.before(resEnd) && normEnd.after(resStart);
                    })
                    .map(Reservation::getRoomId)
                    .filter(id -> id != null)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
