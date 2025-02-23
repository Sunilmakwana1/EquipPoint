<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
    <link href="../src/style.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp" %>
    <div class="min-h-screen flex items-center justify-center">
        <div class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="md:w-1/2 p-8">
                <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Add User</h2>
<%--                <!-- <div class=" <%= request.getAttribute(VENDOR_ADDED_SUCCESSFULLY) != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"--%>
<%--                     role="alert">--%>
<%--                    <strong class="font-bold"><%= request.getAttribute(VENDOR_ADDED_SUCCESSFULLY) %></strong>--%>
<%--                </div> -->--%>
                <form action="#" method="POST" class="space-y-2">
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-700">Full Name</label>
                            <input type="text" name="full_name" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                        </div>
                        <div>
                            <label class="block text-gray-700">Email</label>
                            <input type="email" name="email" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-700">Role</label>
                            <select name="role" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                                <option value="">Select Role</option>
                                <option value="admin">Admin</option>
                                <option value="user">User</option>
                                <option value="guest">Guest</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-gray-700">Phone</label>
                            <input type="text" name="phone" pattern="\d{10}" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-700">Country</label>
                            <input type="text" name="country" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                        </div>
                        <div>
                            <label class="block text-gray-700">City</label>
                            <input type="text" name="city" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                        </div>
                    </div>
                    <div>
                        <label class="block text-gray-700">Address</label>
                        <textarea name="address" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" rows="3" required></textarea>
                    </div>
                    <div>
                        <label class="block text-gray-700">Postal Code</label>
                        <input type="text" name="postal_code" pattern="\d{6}" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600">Add User</button>
                    </div>
                </form>
            </div>
            <div class="md:w-1/2 hidden md:block">
                <img src="../images/EquipPoint.png" alt="Sign Up" class="w-full h-full ">
            </div>
        </div>
    </div>
    </body>
<%@include file="/users/footer.jsp" %>
</html>
