<%@ page import="static com.equip.point.util.AppConstant.FORGET_EMAIL" %>
<%@ page import="static com.equip.point.util.AppConstant.PHONE_NUMBER_NOT_FOUND" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forget Password - EquipPoint</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-md w-96">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-blue-600">Forget Email</h2>
            <p class="text-gray-600 mt-2">Enter your phone number</p>
        </div>
         <div class=" <%= request.getAttribute(FORGET_EMAIL) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute(FORGET_EMAIL) %></strong>
        </div>
        <div class=" <%= request.getAttribute(PHONE_NUMBER_NOT_FOUND) != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute(PHONE_NUMBER_NOT_FOUND) %></strong>
        </div>
        <form class="space-y-6" action="${pageContext.request.contextPath}/api/forget-email" method="post" >
            <div>
                <label for="phoneNumber" class="block text-sm font-medium text-gray-700">Phone Number</label>
                <input type="number" id="phoneNumber" name="phoneNumber"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                       required>
            </div>

            <button type="submit"
                    class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700
                               transition duration-300 font-medium">
                Forget Email
            </button>

            <div class="text-center">
                <a href="../login/login.jsp" class="text-blue-600 hover:text-blue-800 text-sm">
                    Back to Login
                </a>
            </div>
        </form>
    </div>
</div>