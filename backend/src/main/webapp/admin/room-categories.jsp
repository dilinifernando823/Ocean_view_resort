<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Categories | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">Room Categories</h2>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/categories?action=new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Create Category
                </a>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Category Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/${cat.image != null ? cat.image : 'assets/images/placeholder-cat.jpg'}" 
                                         alt="${cat.name}" 
                                         style="width: 80px; height: 50px; object-fit: cover; border-radius: 5px; border: 1px solid #eee;">
                                </td>
                                <td style="font-weight: 600;">${cat.name}</td>
                                <td style="max-width: 300px; font-size: 0.85rem; color: #666;">
                                    ${cat.description}
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.8rem;">
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${cat.id}" title="Edit" style="color: #3498db;">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${cat.id}" title="Delete" style="color: #e74c3c;" onclick="return confirm('Are you sure you want to delete this category?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
