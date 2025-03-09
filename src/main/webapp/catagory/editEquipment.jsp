<%@ page import="com.equip.point.model.Equipments" %>
<%@ page import="com.equip.point.Service.EquipmentService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Equipment</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <%@include file="/users/navbar.jsp"%>
    <div class="container mx-auto p-6">
        <div class="bg-white p-6 rounded-lg shadow-lg">
            <h2 class="text-2xl font-bold mb-4">Edit Equipment</h2>
            <%
                // Assuming you have a method to get equipment details by ID
                Long equipmentId = Long.valueOf(request.getParameter("id"));
                EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
                Equipments equipment = equipmentService.getEquipmentById(equipmentId);
            %>
            <form action="${pageContext.request.contextPath}/api/update-equipment" method="POST" class="space-y-4">
                <input type="hidden" name="id" value="<%= equipment.getId() %>">
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="modelName">Model Name</label>
                    <input name="modelName" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="modelName" type="text" value="<%= equipment.getModel() %>" readonly >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="category">Category</label>
                    <select name="category" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="category" value="<%= equipment.getEquipmentsCategories() %>">
                        <option value="heavy">Heavy Equipment</option>
                        <option value="light">Light Equipment</option>
                        <option value="medium">Medium Equipment</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="availability">Availability</label>
                    <select name="available" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="availability" value="<%= equipment.getAvailabilityStatus() %>">
                        <option value="Available">Available</option>
                        <option value="Unavailable">Unavailable</option>
                        <option value="Maintenance">Maintenance</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="price">Price per Day</label>
                    <input name="price" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="price" type="text" value="<%= equipment.getRentalRate() %>" >
                </div>
                <h3 class="text-xl font-bold mb-2">Specifications</h3>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="year">Manufacturing Year</label>
                    <input name="manufacturing" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="year" type="text" value="<%= equipment.getManufacturingYear() %>" >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="weight">Operating Weight</label>
                    <input name="Weight" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="weight" type="text" value="<%= equipment.getOperatingWeight() %>" >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="power">Engine Power</label>
                    <input name="Power" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="power" type="text" value="<%= equipment.getEnginePower() %>" >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="fuel">Fuel Type</label>
                    <select name="Fuel" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="fuel" value="<%= equipment.getFuelType() %>">
                        <option value="diesel">Diesel</option>
                        <option value="petrol">Petrol</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="description">Description</label>
                    <textarea name="Description" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="description" rows="4" value="<%= equipment.getDescription() %>"></textarea>
                </div>
                <div class="flex items-center justify-between">
                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="submit">
                        Save
                    </button>
                    <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
    <%@include file="/users/footer.jsp"%>
</body>
</html>