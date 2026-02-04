<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Dilini Ocean View Resort</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-blue-900 flex items-center justify-center min-h-screen">
    <div class="bg-white p-10 rounded-2xl shadow-2xl w-full max-w-md text-center">
        <h1 class="text-3xl font-bold text-blue-900 mb-4">Forgot Password?</h1>
        <p class="text-gray-600 mb-8">Enter your email and we'll send you a link to reset your password.</p>
        <form action="forgot-password" method="post">
            <div class="mb-8 text-left">
                <label class="block text-gray-700 font-semibold mb-2">Email Address</label>
                <input type="email" name="email" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="your@email.com" required>
            </div>
            <button type="submit" class="w-full bg-blue-600 text-white font-bold py-3 rounded-lg hover:bg-blue-700 transition duration-300">Reset Password</button>
            <div class="mt-6">
                <a href="login.jsp" class="text-blue-600 hover:underline text-sm font-medium italic">Back to Login</a>
            </div>
        </form>
    </div>
</body>
</html>
