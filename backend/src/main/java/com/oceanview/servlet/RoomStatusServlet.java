package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/staff/update-room-status")
public class RoomStatusServlet extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String roomId = request.getParameter("id");
        String status = request.getParameter("status");

        if (roomId != null && status != null) {
            Room room = roomDAO.findById(roomId);
            if (room != null) {
                room.setStatus(status);
                room.setUpdatedAt(new java.util.Date());
                roomDAO.save(room);
            }
        }

        response.sendRedirect(request.getContextPath() + "/staff/cleaning-schedule");
    }
}
