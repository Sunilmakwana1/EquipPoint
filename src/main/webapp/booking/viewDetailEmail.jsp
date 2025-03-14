<%@ page import="com.equip.point.Service.EmailLogService" %>
<%@ page import="com.equip.point.model.EmailLog" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Detail View</title>
    <link rel="stylesheet" href="../src/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="bg-white shadow-lg rounded-lg w-full max-w-2xl p-6">
        <%
            // Assuming you have a method to fetch email details by ID
            int emailId = Integer.parseInt(request.getParameter("id"));
            EmailLogService emailLogService = new EmailLogService(DbConnection.getConnection());
            emailLogService.isReadEmailLog(emailId);
            EmailLog emailLog = emailLogService.getEmailLogById(emailId);
        %>
        <h1 class="text-2xl font-bold text-gray-800 mb-4">Email Details</h1>
        <div class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-600">From:</label>
                <p class="text-gray-800 bg-gray-100 rounded-md p-2">
                    <%= emailLog.getFromEmail() %>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-600">To:</label>
                <p class="text-gray-800 bg-gray-100 rounded-md p-2">
                    <%= emailLog.getRecipientEmail() %>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-600">Subject:</label>
                <p class="text-gray-800 bg-gray-100 rounded-md p-2">
                    <%= emailLog.getSubject() %>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-600">Body:</label>
                <div class="text-gray-800 bg-gray-100 rounded-md p-4 h-40 overflow-y-auto">
                    <p>
                        <%= emailLog.getMessage() %>
                    </p>
                </div>
            </div>
        </div>
        <div class="mt-6 text-right">
            <button class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 transition" onclick="window.location.href='${pageContext.request.contextPath}/booking/email.jsp'">
                Close
            </button>
        </div>
    </div>

</body>

</html>