package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.InvoiceDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import com.oceanview.model.Room;
import com.oceanview.model.Invoice;
import com.oceanview.util.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/reservations")
public class ReservationManagementServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private UserDAO userDAO = new UserDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private InvoiceDAO invoiceDAO = new InvoiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("view".equals(action)) {
            Reservation res = reservationDAO.findById(id);
            User guest = userDAO.findById(res.getGuestId());
            Room room = roomDAO.findById(res.getRoomId());
            Invoice invoice = invoiceDAO.findByReservationId(id);

            request.setAttribute("res", res);
            request.setAttribute("guest", guest);
            request.setAttribute("room", room);
            request.setAttribute("invoice", invoice);
            request.getRequestDispatcher("/admin/reservation-view.jsp").forward(request, response);
        } else if ("status".equals(action)) {
            String status = request.getParameter("type"); // accepted, rejected
            Reservation res = reservationDAO.findById(id);
            if (res != null) {
                res.setStatus(status);
                res.setUpdatedAt(new Date());
                reservationDAO.save(res);
                
                // Send Email Notification
                User guest = userDAO.findById(res.getGuestId());
                if (guest != null && guest.getEmail() != null) {
                    String subject = "Reservation " + status.toUpperCase() + " - Ocean View Resort";
                    String body = "<h3>Hello " + guest.getFullName() + ",</h3>" +
                                 "<p>Your reservation for Room ID: " + res.getRoomId() + " has been <strong>" + status + "</strong>.</p>" +
                                 "<p>Thank you for choosing Ocean View Resort.</p>";
                    EmailUtil.sendEmail(guest.getEmail(), subject, body);
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
        } else if ("pay".equals(action)) {
            Reservation res = reservationDAO.findById(id);
            if (res != null && "accepted".equals(res.getStatus())) {
                res.setPaymentStatus("paid");
                res.setUpdatedAt(new Date());
                reservationDAO.save(res);

                // Create Invoice
                Invoice invoice = new Invoice();
                invoice.setReservationId(res.getId());
                invoice.setGuestId(res.getGuestId());
                invoice.setInvoiceNumber("INV-" + System.currentTimeMillis());
                invoice.setAmount(res.getTotalAmount());
                invoice.setInvoicedAt(new Date());
                invoice.setCreatedAt(new Date());
                invoice.setUpdatedAt(new Date());
                invoiceDAO.save(invoice);
            }
            response.sendRedirect(request.getContextPath() + "/admin/reservations?action=view&id=" + id);
        } else if ("delete".equals(action)) {
            reservationDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
        } else {
            List<Reservation> reservations = reservationDAO.findAll();
            request.setAttribute("reservations", reservations);
            request.getRequestDispatcher("/admin/reservations.jsp").forward(request, response);
        }
    }
}
