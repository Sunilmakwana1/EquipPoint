<%@ page import="com.equip.point.Service.EquipmentCategoriesService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.Categories" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.equip.point.util.AppConstant.CATEGORY_DELETED_SUCCESSFULLY" %>
<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
<%@ page import="com.equip.point.model.Categories" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipment Categories</title>
    <link href="../src/style.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<%@ include file="/users/navbar.jsp" %>
<div class="container mx-auto p-6">
    <!-- Header Section -->
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-4xl font-extrabold text-gray-800">Equipment Categories</h1>
        <%
            UserService userService = new UserService(DbConnection.getConnection());
            String roleNameByEmail = userService.getRoleNameByEmail(user.getEmail());
            if (EquipPointUtil.isEqualToAdmin(roleNameByEmail)) {
        %>
        <a href="${pageContext.request.contextPath}/catagory/addEquipmentCategories.jsp"
           class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all duration-300">
            Add Equipment
        </a>
        <% } %>
    </div>

    <!-- Success Alert for Category Deletion -->


    <!-- Categories Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <%
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(DbConnection.getConnection());
            List<Categories> categories = equipmentCategoriesService.getEquipmentCategories();
            for (Categories category : categories) {
        %>
        <div class="bg-white shadow-lg rounded-lg overflow-hidden group transition-all duration-300 transform hover:scale-105">
            <!-- Category Image -->
            <img class="w-full h-64 object-cover group-hover:opacity-75 transition-all duration-300" src='/images/<%=category.getImage()%>' alt="Category Image" onerror="this.src='/images/EquipPoint.png';">
            <div class="p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-3"><%=category.getName()%></h2>
                <p class="text-gray-600 mb-4 line-clamp-3"><%=category.getDescription()%></p>

                <!-- Buttons -->
                <div class="flex justify-between items-center mt-4">
                    <a href="/catagory/ConstructionEquipmentListByCategory.jsp?id=<%=category.getId()%>"
                       class="bg-green-500 text-white px-6 py-2 rounded-lg hover:bg-green-600 transition-all duration-300">View</a>
                    <%
                        if (EquipPointUtil.isEqualToAdmin(roleNameByEmail)) {
                    %>
                    <a href="/catagory/editEquipment.jsp?id=<%=category.getId()%>"
                       class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition-all duration-300">Edit</a>
                    <a href="/api/equipment-categories-deleted?id=<%=category.getId()%>"
                       class="bg-red-500 text-white px-6 py-2 rounded-lg hover:bg-red-600 transition-all duration-300">Delete</a>
                    <% } %>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%@ include file="/users/footer.jsp" %>

<script>
    // Hide the alert after 5 seconds (5000 milliseconds)
    setTimeout(function() {
        document.getElementById('deleteAlert').classList.add('hidden');
    }, 5000);
</script>
</body>
</html>
