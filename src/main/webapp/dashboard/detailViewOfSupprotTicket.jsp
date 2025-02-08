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
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold mb-6 text-gray-800">Support Ticket Detail</h1>
        <%
            String id = request.getParameter("id");
            ContactUsService contactUsService = new ContactUsService(DbConnection.getConnection());
            ContactUs contactUs = contactUsService.getContactUsById(Integer.parseInt(id));
            Long userId = 0L;
            User user = (User) session.getAttribute(LOGGED_IN_USER);
            if (user != null) {
                userId = user.getId();
            }
            else {
                response.sendRedirect("../login/login.jsp");
            }
        %>
        <form>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Ticket Number:</label>
                    <p id="ticketnumber" class="text-gray-900 text-lg"><%=contactUs.getId()%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Full Name:</label>
                    <p id="fullName" class="text-gray-900 text-lg"><%=contactUs.getFullName()%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Email:</label>
                    <p id="email" class="text-gray-900 text-lg"><%=contactUs.getEmail()%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Message:</label>
                    <textarea class="w-full p-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100" rows="4" readonly><%=contactUs.getMessage()%></textarea>
                </div>
                
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-gray-700 font-semibold mb-2">Approved Status:</label>
                    <div class="flex space-x-4">
                        <a href="${pageContext.request.contextPath}/api/contact-us-approved-status?id=<%=contactUs.getId()%>&userId=<%=userId%>"
                           class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600" title="Delete User">
                            Approved
                        </a>

                        <a href="${pageContext.request.contextPath}/api/contact-us-progress-status?id=<%=contactUs.getId()%>"
                           class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600" title="Delete User">
                            Unapproved
                        </a>
                    </div>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Approved Date:</label>
                    <p id="approvedDate" class="text-gray-900 text-lg"><%=contactUs.getApprovedDate()%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Approved By:</label>
                    <p id="approvedBy" class="text-gray-900 text-lg"><%=contactUs.getApprovedBy() != null ? contactUs.getApprovedBy().getFullName() : "N/A"%></p>
                </div>
                
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-gray-700 font-semibold mb-2">Reply Message:</label>
                    <textarea id="replyMessage" class="w-full p-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" rows="4"></textarea>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Reply Date:</label>
                    <p id="replyDate" class="text-gray-900 text-lg"><%=contactUs.getReplyDate()%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Replied By:</label>
                    <p id="repliedBy" class="text-gray-900 text-lg"><%=contactUs.getRepliedBy() != null && contactUs.getRepliedBy().getFullName() != null ? contactUs.getRepliedBy().getFullName() : "N/A"%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Replied Status:</label>
                    <p id="repliedStatus" class="text-gray-900 text-lg"><%=contactUs.getRepliedStatus() != null ? "Replied" : "Not Replied"%></p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Progress Status:</label>
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
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Created Date:</label>
                    <p id="createdDate" class="text-gray-900 text-lg"><%=contactUs.getCreatedDateStr()%></p>
                </div>
            </div>
            
            <div class="flex justify-end mt-6">
                <button type="submit" id="saveButton" class="bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600">Save</button>
            </div>
        </form>
    </div>
</body>
</html>