package com.oceanview.servlet;

import com.oceanview.dao.RoomCategoryDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import com.oceanview.model.RoomCategory;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/rooms")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15   // 15MB
)
public class RoomManagementServlet extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();
    private RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
    private static final String UPLOAD_DIR = "assets/uploads/rooms";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            Room room = roomDAO.findById(id);
            request.setAttribute("roomToEdit", room);
            request.setAttribute("categories", categoryDAO.findAll());
            request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            String id = request.getParameter("id");
            Room room = roomDAO.findById(id);
            RoomCategory category = categoryDAO.findById(room.getCategoryId());
            request.setAttribute("room", room);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/room-view.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            roomDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        } else if ("new".equals(action)) {
            request.setAttribute("categories", categoryDAO.findAll());
            request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
        } else {
            List<Room> rooms = roomDAO.findAll();
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/admin/rooms.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String roomNumber = request.getParameter("roomNumber");
        String roomName = request.getParameter("roomName");
        String categoryId = request.getParameter("categoryId");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String amenities = request.getParameter("amenities");
        double pricePerNight = Double.parseDouble(request.getParameter("pricePerNight"));
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        Room room;
        if (id != null && !id.isEmpty()) {
            room = roomDAO.findById(id);
        } else {
            room = new Room();
            room.setCreatedAt(new Date());
        }

        // Handle Image Uploads
        room.setImage1(handleFileUpload(request, "image1", room.getImage1()));
        room.setImage2(handleFileUpload(request, "image2", room.getImage2()));
        room.setImage3(handleFileUpload(request, "image3", room.getImage3()));

        room.setRoomNumber(roomNumber);
        room.setRoomName(roomName);
        room.setCategoryId(categoryId);
        room.setStatus(status);
        room.setDescription(description);
        room.setAmenities(amenities);
        room.setPricePerNight(pricePerNight);
        room.setCapacity(capacity);
        room.setUpdatedAt(new Date());

        roomDAO.save(room);
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private String handleFileUpload(HttpServletRequest request, String partName, String existingPath) throws IOException, ServletException {
        Part filePart = request.getPart(partName);
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(uploadFilePath + File.separator + fileName);
            return UPLOAD_DIR + "/" + fileName;
        }
        return existingPath;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
