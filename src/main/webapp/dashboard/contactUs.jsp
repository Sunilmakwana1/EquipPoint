<%@ page import="com.equip.point.Service.UserService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="static com.equip.point.controller.ContactUsController.CONTACT_US_SUCCESS" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<%@include file="/users/navbar.jsp"%>
<%
    UserService userService = new UserService(DbConnection.getConnection());
    User userById = userService.getUserById(id);

%>
<body class="bg-gray-100">
    <div class="flex items-center justify-center min-h-screen">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <h2 class="text-2xl font-bold mb-6 text-gray-800">Contact Us</h2>
            <div class=" <%= request.getAttribute(CONTACT_US_SUCCESS) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
                 role="alert">
                <strong class="font-bold"><%= request.getAttribute(CONTACT_US_SUCCESS) %></strong>
            </div>
            <form action="${pageContext.request.contextPath}/api/contact-us" method="post">
                <div class="mb-4">
                    <label for="name" class="block text-gray-700">Name</label>
                    <input type="text" id="name" name="name" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100"
                           <%if (id != 0) {%> value="<%=userById.getFullName()%>" readonly <%}%>>
                </div>
                <div class="mb-4">
                    <label for="email" class="block text-gray-700">Email</label>
                    <input type="email" id="email" name="email" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100"
                           <%if (id != 0) {%> value="<%=userById.getEmail()%>" readonly <%}%>>
                </div>
                <div class="mb-4">
                    <label for="message" class="block text-gray-700">Message</label>
                    <textarea id="message" name="message" rows="4" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>
                <div class="mb-4">
                    <button type="submit" class="w-full bg-blue-500 text-white px-3 py-2 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">Submit</button>
                </div>
            </form>
        </div>
    </div>
</body>
<%@include file="/users/footer.jsp"%>
</html>