<%@ page import="com.equip.point.Service.EquipmentCategoriesService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.EquipmentCategories" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.equip.point.util.AppConstant.CATEGORY_DELETED_SUCCESSFULLY" %>
<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
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
    <h1 class="text-3xl font-bold mb-4 items-center">Equipment Categories</h1>
    <div id="deleteAlert" class=" <%= request.getAttribute(CATEGORY_DELETED_SUCCESSFULLY) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
         role="alert">
        <strong class="font-bold"><%= request.getAttribute(CATEGORY_DELETED_SUCCESSFULLY) %>
        </strong>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(DbConnection.getConnection());
            List<EquipmentCategories> categories = equipmentCategoriesService.getEquipmentCategories();
            for (EquipmentCategories category : categories) {
        %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <img class="w-full h-48 object-cover" src='/images/<%=category.getImage()%>' alt="Category Image" onerror="this.src='/images/EquipPoint.png';">
            <div class="p-4">
                <h2 class="text-xl font-bold mb-2"><%=category.getName()%>
                </h2>
                <p class="text-gray-700 mb-4 line-clamp-3"><%=category.getDescription()%>
                </p>
                <%
                    UserService userService = new UserService(DbConnection.getConnection());
                    String roleNameByEmail = userService.getRoleNameByEmail(user.getEmail());
                    if (EquipPointUtil.isEqualToAdmin(roleNameByEmail)) {
                %>
                <div class="flex justify-between items-center">
                    <a href="/api/equipment-categories-edit?id=<%=category.getId()%>"
                       class="bg-blue-500 text-white px-4 py-2 rounded">Edit</a>
                    <a href="/api/equipment-categories-deleted?id=<%=category.getId()%>"
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
</script>
</body>
</html>