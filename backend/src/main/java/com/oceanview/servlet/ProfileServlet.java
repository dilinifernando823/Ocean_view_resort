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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private com.oceanview.dao.InvoiceDAO invoiceDAO = new com.oceanview.dao.InvoiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        System.out.println("ProfileServlet: Fetching reservations for User ID: " + user.getId());
        List<Reservation> reservations = reservationDAO.findByGuestId(user.getId());
        System.out.println("ProfileServlet: Found " + reservations.size() + " reservations.");

        // Fetch room details and invoices for each reservation
        Map<String, Room> roomMap = new HashMap<>();
        Map<String, com.oceanview.model.Invoice> invoiceMap = new HashMap<>();
        
        for (Reservation res : reservations) {
            System.out.println("ProfileServlet: Processing Reservation " + res.getId() + " - Room ID: " + res.getRoomId());
            if (!roomMap.containsKey(res.getRoomId())) {
                Room room = roomDAO.findById(res.getRoomId());
                if (room != null) {
                    roomMap.put(res.getRoomId(), room);
                } else {
                     System.out.println("ProfileServlet: Room not found for ID: " + res.getRoomId());
                }
            }
            
            com.oceanview.model.Invoice inv = invoiceDAO.findByReservationId(res.getId());
            if (inv != null) {
                invoiceMap.put(res.getId(), inv);
            }
        }

        request.setAttribute("reservations", reservations);
        request.setAttribute("roomMap", roomMap);
        request.setAttribute("invoiceMap", invoiceMap);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
