<%@ page import="com.equip.point.Service.EquipmentCategoriesService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.model.Categories" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipment Categories</title>
    <link href="../src/style.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-4">Equipment Categories</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(DbConnection.getConnection());
            List<Categories> categories = equipmentCategoriesService.getEquipmentCategories();
            for (Categories  category : categories) {
        %>
            <div class="bg-white shadow-md rounded-lg overflow-hidden">
                <img class="w-full h-48 object-cover" src=../images/<%=category.getImage()%> alt="Category Image">
                <div class="p-4">
                    <h2 class="text-xl font-bold mb-2"><%=category.getName()%></h2>
                    <p class="text-gray-700 mb-4 line-clamp-3"><%=category.getDescription()%></p>
                    <div class="flex justify-between items-center">
                        <button class="bg-blue-500 text-white px-4 py-2 rounded" onclick="openEditModal(<%=category.getId()%>)">Edit</button>
                        <button class="bg-red-500 text-white px-4 py-2 rounded" onclick="confirmDelete(<%=category.getId()%>)">Delete</button>
                    </div>
                </div>
            </div>
        <%
            }
        %>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">Edit Category</h2>
        <form>
            <div class="mb-4">
                <label class="block text-gray-700">Category Name</label>
                <input type="text" class="w-full px-4 py-2 border rounded-lg" placeholder="Enter category name">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Category Image URL</label>
                <input type="text" class="w-full px-4 py-2 border rounded-lg" placeholder="Enter image URL">
            </div>
            <div class="flex justify-end">
                <button type="button" class="bg-gray-500 text-white px-4 py-2 rounded mr-2" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Save</button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">Confirm Delete</h2>
        <p>Are you sure you want to delete this category?</p>
        <div class="flex justify-end mt-4">
            <button class="bg-gray-500 text-white px-4 py-2 rounded mr-2" onclick="closeDeleteModal()">No</button>
            <button class="bg-red-500 text-white px-4 py-2 rounded">Yes</button>
        </div>
    </div>
</div>

<script>
    function openEditModal(id) {
        document.getElementById('editModal').classList.remove('hidden');
        // Populate the modal with the category details using the id
    }

    function closeEditModal() {
        document.getElementById('editModal').classList.add('hidden');
    }

    function confirmDelete(id) {
        document.getElementById('deleteModal').classList.remove('hidden');
        // Handle the delete confirmation using the id
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>
</body>
</html>