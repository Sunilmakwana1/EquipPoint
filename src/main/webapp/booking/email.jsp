<%@ page import="com.equip.point.Service.EmailLogService" %>
<%@ page import="com.equip.point.model.EmailLog" %>
<%@ page import="java.util.List" %>
<%@ page import="com.equip.point.util.CurrentLoginUser" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Optional" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emails</title>
    <link href="../src/style.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 font-sans">
<%@ include file="/users/navbar.jsp" %>
<div class="container mx-auto p-6">
    <div class="bg-white shadow-md rounded-lg p-6">
        <h1 class="text-2xl font-bold text-gray-800 mb-4">Emails</h1>

        <!-- Search Bar -->
        <div class="mb-4">
            <form method="GET" action="email.jsp">
                <input type="text" name="search" value="<%= Optional.ofNullable(request.getParameter("search")).orElse("") %>" class="p-2 border rounded w-full" placeholder="Search by Subject" />
            </form>
        </div>

        <div class="space-y-4">
            <%
                String searchKeyword = request.getParameter("search") == null ? "" : request.getParameter("search");
                int pageSize = 10;
                int defaultPage = 1;
                if (request.getParameter("defaultPage") != null) {
                    defaultPage = Integer.parseInt(request.getParameter("defaultPage"));
                }
                int offset = (defaultPage - 1) * pageSize;

                EmailLogService emailLogService = new EmailLogService(DbConnection.getConnection());
                List<EmailLog> emailLogs;

                if (EquipPointUtil.isEqualToAdmin(userRole)) {
                    emailLogs = emailLogService.getAllEmailLogs(searchKeyword, offset, pageSize);
                } else {
                    emailLogs = emailLogService.getEmailLogsByUserEmail(CurrentLoginUser.getCurrentLoginUser(), searchKeyword, offset, pageSize);
                }

                int totalEmails = emailLogs.size(); // Get total count of emails for pagination

                for (EmailLog emailLog : emailLogs) {
            %>
            <div class="p-4 rounded-lg shadow-sm flex justify-between items-center <%= emailLog.isRead() ? "bg-gray-50" : "bg-yellow-100" %>">
                <div>
                    <p class="text-sm text-gray-500">Subject:</p>
                    <p class="text-lg font-semibold text-gray-800">
                        <%= emailLog.getSubject() %>
                    </p>
                    <p class="text-sm text-gray-500 mt-2">From: <span class="text-gray-700"><%= emailLog.getFromEmail() %></span></p>
                </div>
                <button
                        class="px-4 py-2 bg-blue-500 text-white text-sm font-medium rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400"
                        onclick="window.location.href='/booking/viewDetailEmail.jsp?id=<%= emailLog.getId() %>'">
                    View Details
                </button>
            </div>
            <% } %>

            <!-- Pagination -->
            <div class="flex justify-between items-center mt-6">
                <div>
                    <%= defaultPage > 1 ? "<a href='email.jsp?defaultPage=" + (defaultPage - 1) + "&search=" + searchKeyword + "' class='px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600'>Previous</a>" : "" %>
                </div>
                <div class="text-center">
                    Page <%= defaultPage %>
                </div>
                <div>
                    <%= totalEmails == pageSize ? "<a href='email.jsp?defaultPage=" + (defaultPage + 1) + "&search=" + searchKeyword + "' class='px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600'>Next</a>" : "" %>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/users/footer.jsp" %>
</body>

</html>
