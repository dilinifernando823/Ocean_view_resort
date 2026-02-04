<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dilini Ocean View Resort</title>
    <!-- Tailwind CSS Output (assumed to be built into static/css) -->
    <link href="${pageContext.request.contextPath}/static/css/output.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script> <!-- Fallback for demo -->
</head>
<body class="bg-blue-50">
    <header class="bg-blue-900 text-white p-6 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-3xl font-bold">Dilini Ocean View Resort</h1>
            <nav>
                <ul class="flex space-x-6">
                    <li><a href="#" class="hover:text-blue-300">Home</a></li>
                    <li><a href="#" class="hover:text-blue-300">Rooms</a></li>
                    <li><a href="#" class="hover:text-blue-300">Services</a></li>
                    <li><a href="#" class="hover:text-blue-300">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container mx-auto mt-10 p-6">
        <section class="bg-white rounded-xl shadow-2xl p-8 text-center">
            <h2 class="text-4xl font-extrabold text-blue-900 mb-4">Welcome to Paradise</h2>
            <p class="text-gray-600 text-lg mb-6">Experience the ultimate luxury at Dilini Ocean View Resort.</p>
            
            <div id="db-status" class="inline-block px-6 py-3 rounded-full font-semibold bg-gray-200 text-gray-700">
                Checking Database Connection...
            </div>
            
            <div class="mt-10 grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="p-6 bg-blue-100 rounded-lg">
                    <h3 class="font-bold text-xl mb-2 text-blue-800">Oceanfront Views</h3>
                    <p class="text-gray-700">Wake up to the sound of waves and stunning ocean views.</p>
                </div>
                <div class="p-6 bg-blue-100 rounded-lg">
                    <h3 class="font-bold text-xl mb-2 text-blue-800">Luxury Suites</h3>
                    <p class="text-gray-700">Modern rooms designed for your comfort and relaxation.</p>
                </div>
                <div class="p-6 bg-blue-100 rounded-lg">
                    <h3 class="font-bold text-xl mb-2 text-blue-800">Fine Dining</h3>
                    <p class="text-gray-700">Exquisite local and international cuisine prepared by top chefs.</p>
                </div>
            </div>
        </section>
    </main>

    <script>
        // Check DB Connection status via API
        fetch('${pageContext.request.contextPath}/api/db-check')
            .then(response => response.json())
            .then(data => {
                const statusDiv = document.getElementById('db-status');
                if (data.status === 'success') {
                    statusDiv.innerText = 'Database Connected Successfully';
                    statusDiv.className = 'inline-block px-6 py-3 rounded-full font-semibold bg-green-500 text-white';
                } else {
                    statusDiv.innerText = 'Database Connection Failed';
                    statusDiv.className = 'inline-block px-6 py-3 rounded-full font-semibold bg-red-500 text-white';
                }
            })
            .catch(error => {
                const statusDiv = document.getElementById('db-status');
                statusDiv.innerText = 'Status: ' + error.message;
                statusDiv.className = 'inline-block px-6 py-3 rounded-full font-semibold bg-yellow-500 text-white';
            });
    </script>
</body>
</html>
