<%@ page import="com.equip.point.Service.ContactUsService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.ContactUs" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Ticket Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<%@include file="/users/navbar.jsp"%>
<body class="bg-gray-50 font-sans antialiased">
<div class="container mx-auto p-8">
    <h1 class="text-4xl font-extrabold text-gray-900 mb-6">Support Ticket Dashboard</h1>

    <!-- Scrollable table container -->
    <div class="overflow-x-auto bg-white shadow-lg rounded-lg border border-gray-200">
        <table class="min-w-full table-auto">
            <thead class="bg-gray-800 text-white">
            <tr>
                <th class="py-3 px-4 text-left text-sm font-medium">Ticket #</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Full Name</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Email</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Approved Status</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Approved Date</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Approved By</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Reply Date</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Replied By</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Replied Status</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Progress Status</th>
                <th class="py-3 px-4 text-left text-sm font-medium">Created Date</th>
            </tr>
            </thead>
            <tbody class="text-gray-700">
            <%
                // Initialize the contactUsService before use
                ContactUsService contactUsService = new ContactUsService(DbConnection.getConnection());
                List<ContactUs> contactUsList = new ArrayList<>();
                if(EquipPointUtil.isEqualToAdmin(userRole)) {
                    contactUsList = contactUsService.getAllContactUs();
                }else {
                    contactUsList = contactUsService.getAllContactUsByEmail(userEmail);
                }
                for (ContactUs contactUs : contactUsList) {
            %>
            <tr class="border-t border-gray-200 hover:bg-gray-100">
                <td class="py-4 px-4 text-sm"><%= contactUs.getId() %></td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getFullName() %></td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getEmail() %></td>
                <td class="py-4 px-4 text-sm">
                        <span class="inline-flex items-center rounded-md <%= contactUs.getApprovedStatus().equals(true) ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %> px-2 py-1 text-xs font-medium">
                            <%= contactUs.getApprovedStatus().equals(true) ? "Approved" : "Unapproved" %>
                        </span>
                </td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getApprovedDate() != null ? contactUs.getApprovedDate() : "N/A" %></td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getApprovedBy() != null ? contactUs.getApprovedBy().getFullName() : "N/A" %></td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getReplyDate() != null ? contactUs.getReplyDate() : "N/A" %></td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getRepliedBy() != null && contactUs.getRepliedBy().getFullName() != null ? contactUs.getRepliedBy().getFullName() : "N/A" %></td>
                <td class="py-4 px-4 text-sm">
                    <a href="${pageContext.request.contextPath}/dashboard/detailViewOfSupprotTicket.jsp?id=<%= contactUs.getId() %>"
                       class="bg-red-500 hover:bg-red-600 text-white px-2 py-1 rounded-md text-xs font-medium" title="View Details">
                        Replied
                    </a>
                </td>
                <td class="py-4 px-4 text-sm">
                    <% if (contactUs.getProgressStatus().equals(false)) { %>
                    <a href="${pageContext.request.contextPath}/api/contact-us-progress-status?id=<%= contactUs.getId() %>"
                       class="bg-blue-500 hover:bg-blue-600 text-white px-2 py-1 rounded-md text-xs font-medium" title="Mark as In Progress">
                        In Progress
                    </a>
                    <% } else { %>
                    <span class="inline-flex items-center rounded-md bg-green-100 text-green-700 px-2 py-1 text-xs font-medium">
                            Progress
                        </span>
                    <% } %>
                </td>
                <td class="py-4 px-4 text-sm"><%= contactUs.getCreatedDateStr() != null ? contactUs.getCreatedDateStr() : "N/A" %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
<%@include file="/users/footer.jsp"%>
</html>
