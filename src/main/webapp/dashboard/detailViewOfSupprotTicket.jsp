<%@ page import="com.equip.point.model.ContactUs" %>
<%@ page import="com.equip.point.Service.ContactUsService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.User" %>
<%@ page import="static com.equip.point.util.AppConstant.LOGGED_IN_USER" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Ticket Detail</title>
    <link rel="stylesheet" href="../src/style.css">
    <style>
        /* To avoid overflow/scroll */
        body {
            font-family: 'Arial', sans-serif;
            overflow-x: hidden;
        }
    </style>
</head>
<body class="bg-gray-50 font-sans antialiased">
<div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-lg mt-10">
    <h1 class="text-3xl font-semibold text-gray-800 mb-6 text-center">Support Ticket Details</h1>

    <%
        String id = request.getParameter("id");
        ContactUsService contactUsService = new ContactUsService(DbConnection.getConnection());
        ContactUs contactUs = contactUsService.getContactUsById(Long.valueOf(id));
        Long userId = 0L;
        User user = (User) session.getAttribute(LOGGED_IN_USER);
        if (user != null) {
            userId = user.getId();
        }
        else {
            response.sendRedirect("../login/login.jsp");
        }
    %>

    <form action="${pageContext.request.contextPath}/api/contact-us-reply" method="post">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <!-- Hidden Fields -->
            <input type="hidden" name="id" value="<%=contactUs.getId()%>">

            <!-- Ticket Number -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Ticket Number:</label>
                <p class="text-xl text-gray-900 font-medium">#<%=contactUs.getId()%></p>
            </div>

            <!-- Full Name -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Full Name:</label>
                <p class="text-xl text-gray-900 font-medium"><%=contactUs.getFullName()%></p>
            </div>

            <!-- Email -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Email:</label>
                <p class="text-xl text-gray-900 font-medium"><%=contactUs.getEmail()%></p>
            </div>

            <!-- Message -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Message:</label>
                <textarea class="w-full p-4 border rounded-lg bg-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500" rows="4" readonly><%=contactUs.getMessage()%></textarea>
            </div>

            <!-- Approved Status -->
            <div class="col-span-1 sm:col-span-2">
                <label class="block text-lg font-semibold text-gray-700">Approved Status:</label>
                <% if (contactUs.getApprovedStatus() != null && contactUs.getApprovedStatus()) { %>
                <span class="inline-flex items-center px-4 py-2 rounded-full text-xs font-medium text-green-700 bg-green-50 ring-1 ring-inset ring-green-600/10">
                            Approved
                        </span>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/api/contact-us-approved-status?id=<%=contactUs.getId()%>&userId=<%=userId%>"
                   class="bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 transition duration-300 ease-in-out shadow-md" title="Approve Ticket">
                    Approve Ticket
                </a>
                <% } %>
            </div>

            <!-- Approved Date -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Approved Date:</label>
                <p class="text-xl text-gray-900 font-medium"><%=contactUs.getApprovedDate() != null ? contactUs.getApprovedDate() : "N/A"%></p>
            </div>

            <!-- Approved By -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Approved By:</label>
                <p class="text-xl text-gray-900 font-medium"><%=contactUs.getApprovedBy() != null ? contactUs.getApprovedBy().getFullName() : "N/A"%></p>
            </div>

            <!-- Reply Message -->
            <div class="col-span-1 sm:col-span-2">
                <label class="block text-lg font-semibold text-gray-700">Reply Message:</label>
                <textarea id="replyMessage" class="w-full p-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500" rows="4" placeholder="Add a reply..." name="replyMessage" required></textarea>
            </div>

            <!-- Created Date -->
            <div>
                <label class="block text-lg font-semibold text-gray-700">Created Date:</label>
                <p class="text-xl text-gray-900 font-medium"><%=contactUs.getCreatedDateStr()%></p>
            </div>
        </div>

        <!-- Save Button -->
        <div class="flex justify-end mt-6">
            <button type="submit" id="saveButton" class="bg-indigo-600 text-white py-3 px-6 rounded-lg hover:bg-indigo-700 transition duration-300 ease-in-out shadow-md">Save Changes</button>
        </div>
    </form>
</div>
</body>
</html>
