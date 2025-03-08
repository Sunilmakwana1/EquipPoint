<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../src/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Dashboard</title>
</head>

<body>
<%@include file="/users/navbar.jsp"%>
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">

            <%
                UserService userService = new UserService(DbConnection.getConnection());
                String roleNameByEmail = userService.getRoleNameByEmail(user.getEmail());
                if (EquipPointUtil.isEqualToAdmin(roleNameByEmail))
                {
            %>
            <a href="${pageContext.request.contextPath}/booking/viewBooking.jsp"
                class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="far fa-calendar-check  fa-3x text-red-500"></i>
                <p class="mt-4 text-gray-700">Total Booking</p>
            </a>

            <a href="${pageContext.request.contextPath}/catagory/viewEpuipmentCategories.jsp"
               class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-truck fa-3x text-red-500"></i>
                <p class="mt-4 text-gray-700">Equipments</p>
            </a>

            <a href="${pageContext.request.contextPath}/catagory/addVendor.jsp" id="addSpecialistButton"
               class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-wrench fa-3x text-yellow-500"></i>
                <p class="mt-4 text-gray-700">Vendor</p>
            </a>

            <a href="${pageContext.request.contextPath}/users/viewUsers.jsp"
               class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fas fa-user-circle fa-3x text-blue-500"></i>
                <p class="mt-4 text-gray-700">Users</p>
            </a>
            <%
                }
            %>


            <%
                if (EquipPointUtil.isEqualToUser(roleNameByEmail))
                {
            %>
            <a href="${pageContext.request.contextPath}/booking/viewBooking.jsp"
               class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="far fa-calendar-check  fa-3x text-red-500"></i>
                <p class="mt-4 text-gray-700">My Booking</p>
            </a>
            <%
                }
            %>

            <a href="${pageContext.request.contextPath}/catagory/viewCategories.jsp"
                class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-list fa-3x text-blue-500"></i>
                <p class="mt-4 text-gray-700">Category</p>
            </a>

            <a href="${pageContext.request.contextPath}/catagory/viewVendor.jsp"
               class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-list fa-3x text-blue-500"></i>
                <p class="mt-4 text-gray-700">Vendor Category</p>
            </a>

            <a href="#"
                class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fas fa-cog fa-3x text-green-500"></i>
                <p class="mt-4 text-gray-700">Settings</p>
            </a>
            <a href="#"
                class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fas fa-chart-line fa-3x text-red-500"></i>
                <p class="mt-4 text-gray-700">Analytics</p>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/messageInbox.jsp"
                class="bg-white p-6 rounded-lg shadow-lg flex flex-col items-center justify-center hover:bg-gray-100">
                <i class="fas fa-envelope fa-3x text-yellow-500"></i>
                <p class="mt-4 text-gray-700">Support Ticket</p>
            </a>
        </div>
    </div>
<%@include file="/users/footer.jsp"%>
</body>

</html>