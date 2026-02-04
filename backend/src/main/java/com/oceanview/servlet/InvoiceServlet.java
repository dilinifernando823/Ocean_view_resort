package com.oceanview.servlet;

import com.oceanview.dao.InvoiceDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Invoice;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import com.oceanview.model.Room;
import com.oceanview.util.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/invoice")
public class InvoiceServlet extends HttpServlet {
    private InvoiceDAO invoiceDAO = new InvoiceDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();
    private UserDAO userDAO = new UserDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        Invoice invoice = invoiceDAO.findById(id);
        if (invoice == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Reservation res = reservationDAO.findById(invoice.getReservationId());
        User guest = userDAO.findById(invoice.getGuestId());
        Room room = roomDAO.findById(res.getRoomId());

        if ("email".equals(action)) {
            if (guest != null && guest.getEmail() != null) {
                String subject = "Your Invoice - Ocean View Resort (" + invoice.getInvoiceNumber() + ")";
                String body = "<h3>Invoice Details</h3>" +
                             "<p>Number: " + invoice.getInvoiceNumber() + "</p>" +
                             "<p>Amount: LKR " + invoice.getAmount() + "</p>" +
                             "<p>Room: " + room.getRoomNumber() + "</p>" +
                             "<p>Thank you for choosing us!</p>";
                EmailUtil.sendEmail(guest.getEmail(), subject, body);
            }
            response.sendRedirect(request.getContextPath() + "/admin/invoice?id=" + id);
            return;
        }

        request.setAttribute("invoice", invoice);
        request.setAttribute("res", res);
        request.setAttribute("guest", guest);
        request.setAttribute("room", room);
        request.getRequestDispatcher("/admin/invoice-view.jsp").forward(request, response);
    }
}
