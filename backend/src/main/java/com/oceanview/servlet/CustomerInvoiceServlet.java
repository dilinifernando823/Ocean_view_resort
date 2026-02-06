package com.oceanview.servlet;

import com.oceanview.dao.InvoiceDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Invoice;
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

@WebServlet("/customer/invoice")
public class CustomerInvoiceServlet extends HttpServlet {
    private InvoiceDAO invoiceDAO = new InvoiceDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String invoiceId = request.getParameter("id");
        Invoice invoice = invoiceDAO.findById(invoiceId);

        if (invoice == null || !invoice.getGuestId().equals(user.getId())) {
            response.sendRedirect(request.getContextPath() + "/profile?error=access_denied");
            return;
        }

        Reservation res = reservationDAO.findById(invoice.getReservationId());
        Room room = roomDAO.findById(res.getRoomId());

        request.setAttribute("invoice", invoice);
        request.setAttribute("res", res);
        request.setAttribute("room", room);
        request.getRequestDispatcher("/invoice.jsp").forward(request, response);
    }
}
