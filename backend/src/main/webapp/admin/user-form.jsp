<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${userToEdit != null ? 'Edit' : 'Add'} User | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">${userToEdit != null ? 'Update User Details' : 'Create New User Account'}</h2>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn" style="background: #eee; color: #333;">Back to List</a>
        </header>

        <div class="dashboard-container">
            <div style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.02); max-width: 900px;">
                <form action="${pageContext.request.contextPath}/admin/users" method="POST">
                    <input type="hidden" name="id" value="${userToEdit.id}">
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" class="form-control" value="${userToEdit.username}" required>
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" class="form-control" value="${userToEdit.email}" required>
                        </div>
                        
                        <c:if test="${userToEdit == null}">
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label>User Role</label>
                            <select name="role" class="form-control" required>
                                <option value="customer" ${userToEdit.role == 'customer' ? 'selected' : ''}>Customer</option>
                                <option value="staff" ${userToEdit.role == 'staff' ? 'selected' : ''}>Staff Member</option>
                                <option value="admin" ${userToEdit.role == 'admin' ? 'selected' : ''}>Administrator</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="${userToEdit.fullName}">
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="${userToEdit.phone}">
                        </div>
                        <div class="form-group">
                            <label>NIC / Passport</label>
                            <input type="text" name="nic" class="form-control" value="${userToEdit.nic}">
                        </div>
                        <div class="form-group" style="grid-column: span 2;">
                            <label>Home Address</label>
                            <textarea name="address" class="form-control" rows="3">${userToEdit.address}</textarea>
                        </div>
                    </div>

                    <div style="margin-top: 2rem;">
                        <button type="submit" class="btn btn-primary" style="width: 200px;">
                            ${userToEdit != null ? 'Update User' : 'Register User'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
