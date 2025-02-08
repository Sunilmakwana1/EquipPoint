<%@ page import="com.equip.point.Service.ContactUsService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.ContactUs" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Ticket Dashboard</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<%@include file="/users/navbar.jsp"%>
<body class="bg-gray-100">
    <div class="container mx-auto p-4">
        <h1 class="text-2xl font-bold mb-4">Support Ticket Dashboard</h1>
        <div class="bg-white shadow-md rounded-lg overflow-x-auto">
            <table class="min-w-full bg-white">
                <a href="dashboard/detailViewOfSupportTicket.jsp"> detail</a>
                <thead class="bg-gray-800 text-white">
                    <tr>
                        <th class="w-1/12 py-2">Ticket #</th>
                        <th class="w-2/12 py-2">Full Name</th>
                        <th class="w-2/12 py-2">Email</th>
                        <th class="w-3/12 py-2">Message</th>
                        <th class="w-1/12 py-2">Approved Status</th>
                        <th class="w-1/12 py-2">Approved Date</th>
                        <th class="w-1/12 py-2">Approved By</th>
                        <th class="w-3/12 py-2">Reply Message</th>
                        <th class="w-1/12 py-2">Reply Date</th>
                        <th class="w-1/12 py-2">Replied By</th>
                        <th class="w-1/12 py-2">Replied Status</th>
                        <th class="w-1/12 py-2">Progress Status</th>
                        <th class="w-1/12 py-2">Created Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ContactUsService contactUsService = new ContactUsService(DbConnection.getConnection());
                        List<ContactUs> contactUsList = contactUsService.getAllContactUs();
                        for (ContactUs contactUs : contactUsList) {
                    %>
                    <tr class="border-b">
                        <td class="py-2 px-4"><%=contactUs.getId()%></td>
                        <td class="py-2 px-4"><%=contactUs.getFullName()%></td>
                        <td class="py-2 px-4"><%=contactUs.getEmail()%></td>
                        <td class="py-2 px-4"><%=contactUs.getMessage()%></td>
                        <td class="py-2 px-4">
                            <div class="flex space-x-2">
                                <button class="bg-green-500 text-white px-2 py-1 rounded">Approve</button>
                                <button class="bg-red-500 text-white px-2 py-1 rounded">Unapprove</button>
                            </div>
                        </td>
                        <td class="py-2 px-4"><%=contactUs.getApprovedDate()%></td>
                        <td class="py-2 px-4"><%=contactUs.getApprovedBy() != null ? contactUs.getApprovedBy().getFullName() : "N/A"%></td>
                        <td class="py-2 px-4"><%=contactUs.getReplyMessage()%></td>
                        <td class="py-2 px-4"><%=contactUs.getReplyDate()%></td>
                        <td class="py-2 px-4"><%=contactUs.getRepliedBy() != null && contactUs.getRepliedBy().getFullName() != null ? contactUs.getRepliedBy().getFullName() : "N/A"%></td>
                        <td class="py-2 px-4">
                            <button class="bg-blue-500 text-white px-2 py-1 rounded">Replied</button>
                        </td>
                        <td class="py-2 px-4">
                            <button class="bg-blue-500 text-white px-2 py-1 rounded">In Progress</button>
                        </td>
                        <td class="py-2 px-4"><%=contactUs.getCreatedDate()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
<%@include file="/users/footer.jsp"%>
</html>