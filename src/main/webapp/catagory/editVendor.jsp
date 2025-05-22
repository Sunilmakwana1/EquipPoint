<%@ page import="static com.equip.point.util.AppConstant.CATEGORY_ADDED_SUCCESSFULLY" %>
<%@ page import="static com.equip.point.util.AppConstant.*" %>
<%@ page import="com.equip.point.Service.VendorService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.Categories" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vendor</title>
    <!-- Security Meta Tags -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src 'self' data: https:; script-src 'self' https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com;">
    <meta http-equiv="X-Frame-Options" content="DENY">
    <meta http-equiv="X-Content-Type-Options" content="nosniff">
    <meta name="referrer" content="no-referrer">
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp" %>
<div class="min-h-screen flex items-center justify-center">
    <div class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
        <div class="md:w-1/2 p-8">
            <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Edit Vendor</h2>
            <%
                VendorService vendorService = new VendorService(DbConnection.getConnection());
                Long id = Long.valueOf(request.getParameter("id"));
                Categories category = vendorService.getVendorById(id);
            %>
            <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/vendor-edit?id=<%=category.getId()%>"
                  enctype="multipart/form-data">
                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="vendorName">
                        Vendor Name
                    </label>
                    <input class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           id="vendorName"
                           type="text"
                           name="vendorName"
                           value="<%=category.getName()%>">
                </div>
                <div class="sm:col-span-4">
                    <div class="<%= request.getAttribute(DUPLICATE_VENDOR) != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
                         role="alert">
                        <strong class="font-bold"><%= request.getAttribute(DUPLICATE_VENDOR) %>
                        </strong>
                    </div>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="description">
                        Description
                    </label>
                    <textarea
                            class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            id="description"
                            rows="4"
                            name="description"
                            placeholder="Enter category description"><%=category.getDescription()%></textarea>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="vendorImage">
                        Image
                    </label>
                    <img src="<%=category.getImageUri()%>" alt="Vendor Image" class="w-full h-48 object-cover mb-4" onerror="this.src='/images/EquipPoint.png';">
                    <input class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           id="vendorImage"
                           name="vendorImage"
                           type="file">

                </div>

                <div class="flex items-center justify-end">
                    <button class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
                            type="submit">
                        Edit
                    </button>
                </div>
            </form>
        </div>
        <div class="md:w-1/2 hidden md:block">
            <img src="../images/EquipPoint.png" alt="Sign Up" class="w-full h-full ">
        </div>
    </div>
</div>
<%@include file="/users/footer.jsp" %>
</body>
</html>
