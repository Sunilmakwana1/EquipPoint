<%@ page import="static com.equip.point.util.AppConstant.CATEGORY_ADDED_SUCCESSFULLY" %>
<%@ page import="static com.equip.point.util.AppConstant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Equipment</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp"%>
<div class="min-h-screen flex items-center justify-center">
    <div class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
        <div class="md:w-1/2 p-8">
            <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Add Equipment</h2>

            <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/add-equipment" enctype="multipart/form-data">
                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="vendorName">
                        Equipment Name
                    </label>
                    <input class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           id="vendorName"
                           type="text"
                           name="modelName"
                           placeholder="Enter model name">
                </div>
                <div class="sm:col-span-4">
                    <div class="<%= request.getAttribute(DUPLICATE_EQUIPMENT) != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                        <strong class="font-bold"><%= request.getAttribute(DUPLICATE_EQUIPMENT) %> </strong>
                    </div>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="description">
                        Description
                    </label>
                    <textarea class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                              id="description"
                              rows="4"
                              name="description"
                              placeholder="Enter category description"></textarea>
                </div>

                <div>
                    <label class="block text-gray-700 mb-2" for="CategoriesSelect">Categories</label>
                    <select id="CategoriesSelect" name="CategoriesSelect" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                        <option value="" disabled selected>Select Categories</option>
                    </select>
                </div>

                <div>
                    <label class="block text-gray-700 mb-2" for="vendorSelect">Vendor</label>
                    <select id="vendorSelect" name="vendorSelect" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                        <option value="" disabled selected>Select Vendor</option>
                    </select>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-semibold mb-2" for="vendorImage">
                        Image
                    </label>
                    <input class="shadow-sm appearance-none border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           id="vendorImage"
                           name="equipmentImage"
                           type="file">
                </div>

                <div class="flex items-center justify-end">
                    <button class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
                            type="submit">
                        Add
                    </button>
                </div>
            </form>
        </div>
        <div class="md:w-1/2 hidden md:block">
            <img src="../images/EquipPoint.png" alt="Sign Up" class="w-full h-full ">
        </div>
    </div>
</div>
<%@include file="/users/footer.jsp"%>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        fetch('/api/equipment-categories-dropdown')
            .then(response => response.json())
            .then(data => {
                const select = document.getElementById('CategoriesSelect');
                data.forEach(question => {
                    const option = document.createElement('option');
                    option.value = question;
                    option.textContent = question;
                    select.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching security questions:', error));
    });

    document.addEventListener('DOMContentLoaded', function() {
        fetch('/api/equipment-categories-dropdown?vendor=true')
            .then(response => response.json())
            .then(data => {
                const select = document.getElementById('vendorSelect');
                data.forEach(question => {
                    const option = document.createElement('option');
                    option.value = question;
                    option.textContent = question;
                    select.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching security questions:', error));
    });
</script>
</body>
</html>
