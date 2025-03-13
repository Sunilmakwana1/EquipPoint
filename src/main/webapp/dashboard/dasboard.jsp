<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../src/style.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Dashboard</title>
</head>

<body class="bg-gray-100">
<%@include file="/users/navbar.jsp"%>
<div class="container mx-auto px-4 py-8">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <%
            UserService userService = new UserService(DbConnection.getConnection());
            String roleNameByEmail = userService.getRoleNameByEmail(user.getEmail());
            if (EquipPointUtil.isEqualToAdmin(roleNameByEmail))
            {
        %>
        <a href="${pageContext.request.contextPath}/booking/viewBooking.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="far fa-calendar-check fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Total Booking</p>
        </a>

        <a href="${pageContext.request.contextPath}/catagory/addEquipment.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-truck fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Add Equipments</p>
        </a>

        <a href="${pageContext.request.contextPath}/catagory/addVendor.jsp" id="addSpecialistButton"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-wrench fa-4x text-yellow-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Vendor</p>
        </a>

        <a href="${pageContext.request.contextPath}/users/viewUsers.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fas fa-user-circle fa-4x text-blue-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Users</p>
        </a>

        <a href="${pageContext.request.contextPath}/catagory/ConstructionEquipmentList.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-truck fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Equipments</p>
        </a>
        <%
            }
        %>

        <%
            if (EquipPointUtil.isEqualToUser(roleNameByEmail))
            {
        %>
        <a href="${pageContext.request.contextPath}/booking/viewBooking.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="far fa-calendar-check fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">My Booking</p>
        </a>

        <a href="${pageContext.request.contextPath}/catagory/ConstructionEquipmentList.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-truck fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Equipments</p>
        </a>
        <%
            }
        %>

        <a href="${pageContext.request.contextPath}/catagory/viewCategories.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-list fa-4x text-blue-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Equipments Category</p>
        </a>

        <a href="${pageContext.request.contextPath}/catagory/viewVendor.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fa-solid fa-list fa-4x text-blue-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Vendor Category</p>
        </a>

        <a href="#"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fas fa-cog fa-4x text-green-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Settings</p>
        </a>

        <a href="#"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fas fa-chart-line fa-4x text-red-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Analytics</p>
        </a>

        <a href="${pageContext.request.contextPath}/dashboard/messageInbox.jsp"
           class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center justify-center hover:bg-blue-50 transform transition duration-300 ease-in-out hover:scale-105 hover:shadow-2xl">
            <i class="fas fa-envelope fa-4x text-yellow-500"></i>
            <p class="mt-4 text-gray-700 font-semibold">Support Ticket</p>
        </a>
    </div>
</div>
<%@include file="/users/footer.jsp"%>
</body>

</html>
