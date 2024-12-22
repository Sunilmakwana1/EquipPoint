
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.equip.point.Service.UserService" %>
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
<%@include file="/users/navbar.jsp"%>
<div class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-4">
        <div class="flex-1"></div>
        <button id="addUserButton" class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
            <i class="fas fa-user-plus"></i> Add User
        </button>
    </div>
</div>
<div class="overflow-x-auto">
    <table class="min-w-full bg-white border border-gray-200 rounded-lg overflow-hidden">
        <thead class="bg-gray-100">
        <tr>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Name</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Email</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Role</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Active</th>
            <th class="py-3 px-4 text-left text-sm font-semibold text-gray-600 uppercase tracking-wider">Phone Number</th>
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
                <td class="py-3 px-4"><%=userList.getFullName()%></td>
                <td class="py-3 px-4"><%=userList.getEmail()%></td>
                <td class="py-3 px-4"><%=userList.getRole()%></td>
                <td class="py-3 px-4">
                    <span class="inline-flex items-center rounded-md <%=userList.getStatus().equals(true) ? "bg-green-50" : "bg-red-50"%> px-2 py-1 text-xs font-medium text-<%=userList.getStatus().equals(true) ? "green-700" : "red-700"%> ring-1 ring-inset ring-<%=userList.getStatus().equals(true) ? "green-600/20" : "red-600/10"%>">
                        <%=userList.getStatus().equals(true) ? "Active" : "In Active"%>
                </td>
                <td class="py-3 px-4"><%=userList.getPassword()%></td>
                <td class="py-3 px-4"><%=userList.getCountry()%></td>
                <td class="py-3 px-4"><%=userList.getCity()%></td>
                <td class="py-3 px-4">
                    <button class="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600" title="Edit User">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 ml-2" title="Delete User">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<%@include file="/users/footer.jsp"%>
</body>

</html>