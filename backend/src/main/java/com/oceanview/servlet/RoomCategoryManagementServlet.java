package com.oceanview.servlet;

import com.oceanview.dao.RoomCategoryDAO;
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

@WebServlet("/admin/categories")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15   // 15MB
)
public class RoomCategoryManagementServlet extends HttpServlet {
    private RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
    private static final String UPLOAD_DIR = "assets/uploads/categories";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            RoomCategory category = categoryDAO.findById(id);
            request.setAttribute("categoryToEdit", category);
            request.getRequestDispatcher("/admin/room-category-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            categoryDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else if ("new".equals(action)) {
            request.getRequestDispatcher("/admin/room-category-form.jsp").forward(request, response);
        } else {
            List<RoomCategory> categories = categoryDAO.findAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/room-categories.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        // Handle Image Upload
        String imagePath = request.getParameter("existingImage");
        Part filePart = request.getPart("image");
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(uploadFilePath + File.separator + fileName);
            imagePath = UPLOAD_DIR + "/" + fileName;
        }

        RoomCategory category;
        if (id != null && !id.isEmpty()) {
            category = categoryDAO.findById(id);
        } else {
            category = new RoomCategory();
            category.setCreatedAt(new Date());
        }

        category.setName(name);
        category.setDescription(description);
        category.setImage(imagePath);
        category.setUpdatedAt(new Date());

        categoryDAO.save(category);
        response.sendRedirect(request.getContextPath() + "/admin/categories");
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
