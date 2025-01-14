<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="static com.equip.point.util.AppConstant.USER_DELETED_SUCCESSFULLY" %>
<%@ page import="com.equip.point.util.EquipPointUtil" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../src/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>View Users</title>
</head>

<body>
<%@include file="/users/navbar.jsp" %>
<div class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-4">
        <div class="flex-1"></div>
        <button id="addUserButton" class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
            <i class="fas fa-user-plus"></i> Add User
        </button>
    </div>
</div>
<div id="deleteAlert"
     class=" <%= request.getAttribute(USER_DELETED_SUCCESSFULLY) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
     role="alert">
    <strong class="font-bold"><%= request.getAttribute(USER_DELETED_SUCCESSFULLY) %>
    </strong>
</div>
<div class="overflow-x-auto">
    <table class="min-w-full bg-white border border-gray-200 rounded-lg overflow-hidden">
        <thead class="bg-gray-100">
        <tr>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Name</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Email</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Role</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Active</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Phone Number
            </th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Country</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">City</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
        </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">

        <%
            UserService userService = new UserService(DbConnection.getConnection());
            List<User> users = userService.getAllUsers();
            for (User userList : users) {
        %>
        <tr class="hover:bg-gray-50">
            <td class="py-3 px-4"><%=userList.getFullName()%>
            </td>
            <td class="py-3 px-4"><%=userList.getEmail()%>
            </td>
            <td class="py-3 px-4"><%=userList.getRole()%>
            </td>
            <td class="py-3 px-4">
                    <span class="inline-flex items-center rounded-md <%=userList.getStatus().equals(true) ? "bg-green-50" : "bg-red-50"%> px-2 py-1 text-xs font-medium text-<%=userList.getStatus().equals(true) ? "green-700" : "red-700"%> ring-1 ring-inset ring-<%=userList.getStatus().equals(true) ? "green-600/20" : "red-600/10"%>">
                            <%=userList.getStatus().equals(true) ? "Active" : "In Active"%>
            </td>
            <td class="py-3 px-4"><%=userList.getPhone()%>
            </td>
            <td class="py-3 px-4"><%=userList.getCountry()%>
            </td>
            <td class="py-3 px-4"><%=userList.getCity()%>
            </td>
            <td class="py-3 px-4">
                <% if (EquipPointUtil.isEqualToUser(userList.getRole())) { %>
                <a href="" class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600" title="Edit User">
                    <i class="fas fa-user-edit"></i>
                </a>
                &nbsp;
                <a href="${pageContext.request.contextPath}/api/user-deleted?id=<%=userList.getId()%>"
                   class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600" title="Delete User">
                    <i class="fas fa-trash"></i>
                </a>
                <% } %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<%@include file="/users/footer.jsp" %>
<script>
    // Hide the alert after 5 seconds (5000 milliseconds)
    setTimeout(function() {
        document.getElementById('deleteAlert').classList.add('hidden');
    }, 5000);
</script>
</body>

</html>