package com.oceanview.servlet;

import com.oceanview.util.EmailUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact-submit")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageDetail = request.getParameter("message");

        if (name == null || email == null || messageDetail == null || name.isEmpty() || email.isEmpty() || messageDetail.isEmpty()) {
            response.sendRedirect("contact.jsp?error=Missing required fields");
            return;
        }

        String emailSubject = "New Inquiry: " + (subject != null ? subject : "Contact Form");
        
        String emailBody = "<div style=\"font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; padding: 40px 0; color: #333;\">" +
                "    <div style=\"max-width: 600px; margin: 0 auto; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "        <div style=\"background-color: #003366; padding: 30px; text-align: center;\">" +
                "            <h1 style=\"color: #ffffff; margin: 0; font-size: 24px; letter-spacing: 1px;\">OCEAN VIEW RESORT</h1>" +
                "            <p style=\"color: #00aaff; margin: 5px 0 0 0; font-size: 14px; text-transform: uppercase;\">New Contact Inquiry</p>" +
                "        </div>" +
                "        <div style=\"padding: 40px;\">" +
                "            <h2 style=\"color: #003366; margin-top: 0; font-size: 20px;\">Hello Admin,</h2>" +
                "            <p style=\"font-size: 16px; line-height: 1.6; color: #666;\">You have received a new message through the website contact form. Here are the details:</p>" +
                "            " +
                "            <div style=\"background: #f9f9f9; padding: 25px; border-radius: 8px; margin: 25px 0; border-left: 4px solid #00aaff;\">" +
                "                <p style=\"margin: 0 0 10px 0;\"><strong>Customer Name:</strong> <span style=\"color: #333;\">" + name + "</span></p>" +
                "                <p style=\"margin: 0 0 10px 0;\"><strong>Email Address:</strong> <a href=\"mailto:" + email + "\" style=\"color: #00aaff; text-decoration: none;\">" + email + "</a></p>" +
                "                <p style=\"margin: 0;\"><strong>Subject:</strong> <span style=\"color: #333;\">" + (subject != null ? subject : "N/A") + "</span></p>" +
                "            </div>" +
                "            " +
                "            <h3 style=\"color: #003366; font-size: 16px; margin-bottom: 10px;\">Message Content:</h3>" +
                "            <div style=\"font-style: italic; line-height: 1.8; color: #555; padding: 20px; background: #fffcf0; border-radius: 8px; border: 1px solid #ffeeba;\">" +
                "                \"" + messageDetail.replace("\n", "<br>") + "\"" +
                "            </div>" +
                "            " +
                "            <div style=\"margin-top: 30px; text-align: center;\">" +
                "                <a href=\"mailto:" + email + "\" style=\"background-color: #003366; color: #ffffff; padding: 12px 30px; text-decoration: none; border-radius: 50px; font-weight: 600; font-size: 14px; display: inline-block;\">Reply to Customer</a>" +
                "            </div>" +
                "        </div>" +
                "        <div style=\"background-color: #f4f7f6; padding: 20px; text-align: center; border-top: 1px solid #eeeeee;\">" +
                "            <p style=\"margin: 0; font-size: 12px; color: #999;\">&copy; 2026 Ocean View Resort. This is an automated notification.</p>" +
                "        </div>" +
                "    </div>" +
                "</div>";

        // Send email to admin (simulated by sending to the same email or a fixed one)
        EmailUtil.sendEmail("admin@oceanviewresort.com", emailSubject, emailBody);

        response.sendRedirect("contact.jsp?success=Your message has been sent successfully!");
    }
}
