<%@ page import="static com.equip.point.util.AppConstant.LOGIN_ERROR" %>
<%@ page import="static com.equip.point.util.AppConstant.LOGOUT_ERROR" %>
<%@ page import="static com.equip.point.util.AppConstant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EquipPoint Login</title>
    <link rel="stylesheet" href="../src/style.css">
    <style>
        .animate-fade-in {
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="bg-gray-100 h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-96 animate-fade-in">
        <div class="flex justify-center mb-8">
            <!-- Replace with your logo -->
            <img src="../images/EquipPoint.png" alt="EquipPoint Logo" class="h-20 w-auto">
        </div>

        <div class=" <%= request.getAttribute(REGISTER_SUCCESS) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute(REGISTER_SUCCESS) %></strong>
        </div>
        <div class=" <%= request.getAttribute(LOGIN_ERROR) != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute(LOGIN_ERROR) %></strong>
        </div>
        <div class=" <%= request.getAttribute(LOGOUT_ERROR) != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute(LOGOUT_ERROR) %></strong>
        </div>
        <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/auth">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" 
                       id="email"
                       name="email"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                       required
                       title="Enter your email"
                       placeholder="Enter your email">
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" 
                       id="password"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                       required
                       name="password"
                       title="Enter your password"
                       placeholder="Enter your password">
            </div>
            
            <div class="flex items-center justify-between">
                <div class="flex items-center">
                </div>
                <a href="../login/forgetPassword.jsp" class="text-sm text-indigo-600 hover:text-indigo-500">Forgot password?</a>
            </div>
            
            <button type="submit" 
                    class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-150">
                Sign in
            </button>
        </form>
        
        <p class="mt-4 text-center text-sm text-gray-600">
            Don't have an account? 
            <a href="${pageContext.request.contextPath}/users/signUp.jsp" class="font-medium text-indigo-600 hover:text-indigo-500">Sign up</a>
        </p>
    </div>
</body>
</html>