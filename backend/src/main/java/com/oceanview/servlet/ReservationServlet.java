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
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/reserve")
public class ReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=please_login");
            return;
        }

        String roomId = request.getParameter("roomId");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        int occupancy = Integer.parseInt(request.getParameter("occupancy"));
        String notes = request.getParameter("notes");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = sdf.parse(checkInStr);
            Date checkOut = sdf.parse(checkOutStr);

            Reservation reservation = new Reservation();
            reservation.setGuestId(user.getId());
            reservation.setRoomId(roomId);
            reservation.setCheckInDate(checkIn);
            reservation.setCheckOutDate(checkOut);
            reservation.setTotalAmount(totalAmount);
            reservation.setOccupancy(occupancy);
            reservation.setNotes(notes);
            reservation.setStatus("pending");
            reservation.setPaymentStatus("unpaid");
            reservation.setCreatedAt(new Date());
            reservation.setUpdatedAt(new Date());

            reservationDAO.save(reservation);

            response.sendRedirect(request.getContextPath() + "/profile?message=reservation_success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/rooms?action=view&id=" + roomId + "&error=reservation_failed");
        }
    }
}
