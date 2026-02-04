<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Dilini Ocean View Resort</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-blue-900 flex items-center justify-center min-h-screen">
    <div class="bg-white p-10 rounded-2xl shadow-2xl w-full max-w-md text-center">
        <h1 class="text-3xl font-bold text-blue-900 mb-4">Reset Password</h1>
        <form action="reset-password" method="post">
            <div class="mb-6 text-left">
                <label class="block text-gray-700 font-semibold mb-2">New Password</label>
                <input type="password" name="password" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="••••••••" required>
            </div>
            <div class="mb-8 text-left">
                <label class="block text-gray-700 font-semibold mb-2">Confirm Password</label>
                <input type="password" name="confirm-password" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="••••••••" required>
            </div>
            <button type="submit" class="w-full bg-blue-600 text-white font-bold py-3 rounded-lg hover:bg-blue-700 transition duration-300">Update Password</button>
        </form>
    </div>
</body>
</html>
