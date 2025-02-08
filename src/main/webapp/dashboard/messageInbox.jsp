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
    <!-- Scrollable table container -->
    <div class="bg-white shadow-md rounded-lg overflow-x-auto">
        <table class="table-auto w-full bg-white">
            <thead class="bg-gray-800 text-white">
            <tr>
                <th class="w-1/12 py-2 px-4 text-left">Ticket #</th>
                <th class="w-2/12 py-2 px-4 text-left">Full Name</th>
                <th class="w-2/12 py-2 px-4 text-left">Email</th>
                <th class="w-1/12 py-2 px-4 text-left">Approved Status</th>
                <th class="w-1/12 py-2 px-4 text-left">Approved Date</th>
                <th class="w-1/12 py-2 px-4 text-left">Approved By</th>
                <th class="w-1/12 py-2 px-4 text-left">Reply Date</th>
                <th class="w-1/12 py-2 px-4 text-left">Replied By</th>
                <th class="w-1/12 py-2 px-4 text-left">Replied Status</th>
                <th class="w-1/12 py-2 px-4 text-left">Progress Status</th>
                <th class="w-1/12 py-2 px-4 text-left">Created Date</th>
            </tr>
            </thead>
            <tbody class="text-gray-700">
            <%
                // Fetch and loop through the tickets
                ContactUsService contactUsService = new ContactUsService(DbConnection.getConnection());
                List<ContactUs> contactUsList = contactUsService.getAllContactUs();
                for (ContactUs contactUs : contactUsList) {
            %>
            <tr class="border-b">
                <td class="py-2 px-4"><%=contactUs.getId()%></td>
                <td class="py-2 px-4"><%=contactUs.getFullName()%></td>
                <td class="py-2 px-4"><%=contactUs.getEmail()%></td>
                <td class="py-2 px-4">
                    <span class="inline-flex items-center rounded-md <%=contactUs.getApprovedStatus().equals(true) ? "bg-green-50" : "bg-red-50"%> px-2 py-1 text-xs font-medium text-<%=contactUs.getApprovedStatus().equals(true) ? "green-700" : "red-700"%> ring-1 ring-inset ring-<%=contactUs.getApprovedStatus().equals(true) ? "green-600/20" : "red-600/10"%>">
                            <%=contactUs.getApprovedStatus().equals(true) ? "Approve" : "Unapproved"%>
                </td>
                <td class="py-2 px-4"><%=contactUs.getApprovedDate() != null ? contactUs.getApprovedDate() : "N/A"%></td>
                <td class="py-2 px-4">
                    <%=contactUs.getApprovedBy() != null ? contactUs.getApprovedBy().getFullName() : "N/A"%>
                </td>
                <td class="py-2 px-4"><%=contactUs.getReplyDate() != null ? contactUs.getReplyDate() : "N/A"%></td>
                <td class="py-2 px-4">
                    <%=contactUs.getRepliedBy() != null && contactUs.getRepliedBy().getFullName() != null ? contactUs.getRepliedBy().getFullName() : "N/A"%>
                </td>
                <td class="py-2 px-4">
                    <a href="${pageContext.request.contextPath}/dashboard/detailViewOfSupprotTicket.jsp?id=<%=contactUs.getId()%>"
                       class="bg-red-500 hover:bg-red-600 text-white px-2 py-1 rounded" title="Replied">Replied</a>
                </td>
                <td class="py-2 px-4">
                    <%if (contactUs.getProgressStatus().equals(false)) {%>
                    <a href="${pageContext.request.contextPath}/api/contact-us-progress-status?id=<%=contactUs.getId()%>"
                       class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600" title="Delete User">
                        In Progress
                    </a>
                    <%} else {%>
                    <span class="inline-flex items-center rounded-md <%=contactUs.getProgressStatus().equals(true) ? "bg-green-50" : "bg-red-50"%> px-2 py-1 text-xs font-medium text-<%=contactUs.getProgressStatus().equals(true) ? "green-700" : "red-700"%> ring-1 ring-inset ring-<%=contactUs.getProgressStatus().equals(true) ? "green-600/20" : "red-600/10"%>">
                            <%=contactUs.getProgressStatus().equals(true) ? "Progress" : "Not Progress"%>
                    </span>
                    <%}%>

                </td>
                <td class="py-2 px-4"><%=contactUs.getCreatedDateStr() != null ? contactUs.getCreatedDateStr() : "N/A"%></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
<%@include file="/users/footer.jsp"%>
</html>