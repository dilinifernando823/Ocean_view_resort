package com.oceanview.servlet;

import com.oceanview.dao.InvoiceDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Invoice;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/pay")
public class PaymentServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private InvoiceDAO invoiceDAO = new InvoiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reservationId = request.getParameter("reservationId");
        Reservation res = reservationDAO.findById(reservationId);
        
        if (res == null) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        request.setAttribute("reservation", res);
        request.getRequestDispatcher("/payment.jsp").forward(request, response);
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
        Reservation res = reservationDAO.findById(reservationId);

        if (res != null && "unpaid".equals(res.getPaymentStatus())) {
            // Update Reservation Status
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

            response.sendRedirect(request.getContextPath() + "/profile?message=payment_complete");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=invalid_reservation");
        }
    }
}
