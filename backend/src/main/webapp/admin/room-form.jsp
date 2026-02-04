<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${roomToEdit != null ? 'Edit' : 'Add'} Room | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <style>
        .image-upload-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-top: 0.5rem;
        }
        .upload-box {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            position: relative;
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        .upload-box:hover { border-color: var(--secondary-color); background: #f8fbff; }
        .upload-box img { width: 100%; height: 100px; object-fit: cover; border-radius: 4px; display: block; margin-bottom: 0.5rem; }
        .upload-box i { font-size: 1.5rem; color: #ccc; margin-bottom: 0.5rem; }
        .upload-box p { font-size: 0.75rem; color: #888; margin: 0; }
        .upload-box input { position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; cursor: pointer; }
    </style>
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header">
            <h2 style="font-weight: 700; color: #333;">${roomToEdit != null ? 'Update Room Information' : 'Register New Room'}</h2>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="btn" style="background: #eee; color: #333;">Back to List</a>
        </header>

        <div class="dashboard-container">
            <div style="background: white; padding: 2.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); max-width: 1000px;">
                <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${roomToEdit.id}">
                    
                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 1.5rem;">
                        <div class="form-group">
                            <label>Room Number</label>
                            <input type="text" name="roomNumber" class="form-control" value="${roomToEdit.roomNumber}" placeholder="e.g. 101" required>
                        </div>
                        <div class="form-group">
                            <label>Room Name (Internal)</label>
                            <input type="text" name="roomName" class="form-control" value="${roomToEdit.roomName}" placeholder="e.g. Ocean View Deluxe A" required>
                        </div>
                        <div class="form-group">
                            <label>Category</label>
                            <select name="categoryId" class="form-control" required>
                                <option value="">Select Category</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${roomToEdit.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 1.5rem;">
                        <div class="form-group">
                            <label>Price Per Night (LKR)</label>
                            <input type="number" step="0.01" name="pricePerNight" class="form-control" value="${roomToEdit != null ? roomToEdit.pricePerNight : ''}" required>
                        </div>
                        <div class="form-group">
                            <label>Capacity (Persons)</label>
                            <input type="number" name="capacity" class="form-control" value="${roomToEdit != null ? roomToEdit.capacity : ''}" required>
                        </div>
                        <div class="form-group">
                            <label>Status</label>
                            <select name="status" class="form-control" required>
                                <option value="available" ${roomToEdit.status == 'available' ? 'selected' : ''}>Available</option>
                                <option value="booked" ${roomToEdit.status == 'booked' ? 'selected' : ''}>Booked</option>
                                <option value="maintenance" ${roomToEdit.status == 'maintenance' ? 'selected' : ''}>Maintenance</option>
                                <option value="unavailable" ${roomToEdit.status == 'unavailable' ? 'selected' : ''}>Unavailable</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Amenities (Comma separated)</label>
                        <input type="text" name="amenities" class="form-control" value="${roomToEdit.amenities}" placeholder="AC, Wi-Fi, Mini Bar, King Bed, Ocean View...">
                    </div>

                    <div class="form-group">
                        <label>Room Description</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Detailed description for the website..." required>${roomToEdit.description}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Room Gallery (Up to 3 Photos)</label>
                        <div class="image-upload-grid">
                            <div class="upload-box" id="box1">
                                <c:if test="${not empty roomToEdit.image1}">
                                    <img src="${pageContext.request.contextPath}/${roomToEdit.image1}" id="prev1">
                                </c:if>
                                <div class="prompt" id="prompt1" style="${not empty roomToEdit.image1 ? 'display:none' : ''}">
                                    <i class="fas fa-image"></i>
                                    <p>Primary Image</p>
                                </div>
                                <input type="file" name="image1" onchange="preview(this, 'box1', 'prev1', 'prompt1')">
                            </div>
                            <div class="upload-box" id="box2">
                                <c:if test="${not empty roomToEdit.image2}">
                                    <img src="${pageContext.request.contextPath}/${roomToEdit.image2}" id="prev2">
                                </c:if>
                                <div class="prompt" id="prompt2" style="${not empty roomToEdit.image2 ? 'display:none' : ''}">
                                    <i class="fas fa-image"></i>
                                    <p>Gallery Image 2</p>
                                </div>
                                <input type="file" name="image2" onchange="preview(this, 'box2', 'prev2', 'prompt2')">
                            </div>
                            <div class="upload-box" id="box3">
                                <c:if test="${not empty roomToEdit.image3}">
                                    <img src="${pageContext.request.contextPath}/${roomToEdit.image3}" id="prev3">
                                </c:if>
                                <div class="prompt" id="prompt3" style="${not empty roomToEdit.image3 ? 'display:none' : ''}">
                                    <i class="fas fa-image"></i>
                                    <p>Gallery Image 3</p>
                                </div>
                                <input type="file" name="image3" onchange="preview(this, 'box3', 'prev3', 'prompt3')">
                            </div>
                        </div>
                    </div>

                    <div style="margin-top: 3rem; display: flex; gap: 1rem;">
                        <button type="submit" class="btn btn-primary" style="flex: 1; padding: 1rem;">
                            ${roomToEdit != null ? 'Update Room Details' : 'Save New Room'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function preview(input, boxId, prevId, promptId) {
            const prompt = document.getElementById(promptId);
            const box = document.getElementById(boxId);
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    let img = document.getElementById(prevId);
                    if (!img) {
                        img = document.createElement('img');
                        img.id = prevId;
                        box.insertBefore(img, prompt);
                    }
                    img.src = e.target.result;
                    img.style.display = 'block';
                    prompt.style.display = 'none';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
