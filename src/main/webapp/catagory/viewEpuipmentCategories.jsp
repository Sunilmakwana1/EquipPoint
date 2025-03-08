<%@ page import="com.equip.point.Service.EquipmentCategoriesService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.Categories" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.equip.point.util.AppConstant.CATEGORY_DELETED_SUCCESSFULLY" %>
<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
<%@ page import="com.equip.point.model.Categories" %>
<%@ page import="com.equip.point.Service.VendorService" %>
<%@ page import="static com.equip.point.util.AppConstant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipment Categories</title>
    <link href="../src/style.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp" %>
<div class="container mx-auto p-4">
    <div class="flex justify-between items-center mb-4">
        <h1 class="text-3xl font-bold">Equipment</h1>
        <%
            UserService userService = new UserService(DbConnection.getConnection());
            String roleNameByEmail = userService.getRoleNameByEmail(user.getEmail());
            if (EquipPointUtil.isEqualToAdmin(roleNameByEmail)) {
        %>

        <a href="${pageContext.request.contextPath}/catagory/addEquipmentCategories.jsp" id="addSpecialistButton"
           class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
            Add Equipment
        </a>
        <% } %>
    </div>
    <div id="deleteAlert" class="<%= request.getAttribute(VENDOR_DELETED_SUCCESSFULLY) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 mx-auto w-1/2 text-center animate-bounce"
         role="alert">
        <strong class="font-bold"><%= request.getAttribute(VENDOR_DELETED_SUCCESSFULLY) %></strong>
    </div>
    <div id="vendor" class="<%= request.getAttribute(VENDOR_EDITED_SUCCESSFULLY) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 mx-auto w-1/2 text-center animate-bounce"
         role="alert">
        <strong class="font-bold"><%= request.getAttribute(VENDOR_EDITED_SUCCESSFULLY) %></strong>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(DbConnection.getConnection());
            List<Categories> equipmentCategories = equipmentCategoriesService.getEquipmentCategories();
            for (Categories category : equipmentCategories) {
        %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <img class="w-full h-48 object-cover" src='/images/<%=category.getImage()%>' alt="Category Image" onerror="this.src='/images/EquipPoint.png';">
            <div class="p-4">
                <h2 class="text-xl font-bold mb-2"><%=category.getName()%>
                </h2>
                <p class="text-gray-700 mb-4 line-clamp-3"><%=category.getDescription()%>
                </p>
                <%
                    if (EquipPointUtil.isEqualToAdmin(roleNameByEmail)) {
                %>
                <div class="flex justify-between items-center">
                    <a href="/catagory/editVendor.jsp?id=<%=category.getId()%>"
                       class="bg-blue-500 text-white px-4 py-2 rounded">Edit</a>
                    <a href="/api/delete-vendor?id=<%=category.getId()%>"
                       class="bg-red-500 text-white px-4 py-2 rounded">Delete</a>
                </div>
                <% } %>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%@include file="/users/footer.jsp"%>
<script>
    // Hide the alert after 5 seconds (5000 milliseconds)
    setTimeout(function() {
        document.getElementById('deleteAlert').classList.add('hidden');
    }, 5000);
    // Hide the alert after 5 seconds (5000 milliseconds)
    setTimeout(function() {
        document.getElementById('vendor').classList.add('hidden');
    }, 5000);
</script>
</body>
</html>