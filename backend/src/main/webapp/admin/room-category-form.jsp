<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${categoryToEdit != null ? 'Edit' : 'Add'} Category | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">${categoryToEdit != null ? 'Edit Category' : 'Create Category'}</h2>
            <a href="${pageContext.request.contextPath}/admin/categories" class="btn" style="background: #eee; color: #333;">Back to List</a>
        </header>

        <div class="dashboard-container">
            <div style="background: white; padding: 2.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); max-width: 700px;">
                <form action="${pageContext.request.contextPath}/admin/categories" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${categoryToEdit.id}">
                    <input type="hidden" name="existingImage" value="${categoryToEdit.image}">

                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" name="name" class="form-control" value="${categoryToEdit.name}" placeholder="e.g. Deluxe Ocean View" required>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Brief details about this category..." required>${categoryToEdit.description}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Category Image</label>
                        <div style="border: 2px dashed #ddd; padding: 2rem; border-radius: 10px; text-align: center; position: relative; margin-top: 0.5rem; transition: border-color 0.3s;" 
                             id="drop-zone" 
                             onmouseover="this.style.borderColor='var(--secondary-color)'" 
                             onmouseout="this.style.borderColor='#ddd'">
                            
                            <c:if test="${categoryToEdit.image != null}">
                                <img src="${pageContext.request.contextPath}/${categoryToEdit.image}" 
                                     id="preview" 
                                     style="width: 100%; max-height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem;">
                            </c:if>
                            <img src="" id="new-preview" style="width: 100%; max-height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem; display: none;">
                            
                            <div id="upload-prompt">
                                <i class="fas fa-cloud-upload-alt" style="font-size: 2.5rem; color: #ccc; display: block; margin-bottom: 1rem;"></i>
                                <p style="color: #888;">Drop image here or click to browse</p>
                                <input type="file" name="image" id="file-input" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; cursor: pointer;" 
                                       onchange="previewImage(this)">
                            </div>
                        </div>
                    </div>

                    <div style="margin-top: 2.5rem; display: flex; gap: 1rem;">
                        <button type="submit" class="btn btn-primary" style="flex: 1;">
                            ${categoryToEdit != null ? 'Update Category' : 'Create Category'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('new-preview');
            const oldPreview = document.getElementById('preview');
            const prompt = document.getElementById('upload-prompt');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    if (oldPreview) oldPreview.style.display = 'none';
                    prompt.querySelector('i').style.color = 'var(--secondary-color)';
                    prompt.querySelector('p').innerText = input.files[0].name;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
