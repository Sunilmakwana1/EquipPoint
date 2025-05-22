<%@ page import="com.equip.point.model.Equipments" %>
<%@ page import="com.equip.point.Service.EquipmentService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Detail Construction Equipment</title>
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
<%@ include file="/users/navbar.jsp" %>
<div class="container mx-auto px-4 py-8">
    <!-- Equipment Header -->
    <%
        Long equipmentId = Long.valueOf(request.getParameter("id"));
        EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
        Equipments equipment = equipmentService.getEquipmentById(equipmentId);
    %>
    <div class="bg-white rounded-lg shadow-lg p-6 mb-6">
        <h1 class="text-3xl font-bold text-gray-800 mb-4">
            <%= equipment.getModel() %>
        </h1>
        <div class="flex flex-wrap gap-4">
            <div class="flex flex-wrap gap-4">
                <!-- Equipment Category -->
                <span class="
        <%= equipment.getEquipmentsCategories().equalsIgnoreCase("Heavy") ? "bg-red-100 text-red-800" :
            equipment.getEquipmentsCategories().equalsIgnoreCase("Light") ? "bg-yellow-100 text-yellow-800" :
            equipment.getEquipmentsCategories().equalsIgnoreCase("Medium") ? "bg-blue-100 text-blue-800" :
            "bg-gray-100 text-gray-800"
        %>
        px-3 py-1 rounded-full text-sm">
        <%= equipment.getEquipmentsCategories() %>
    </span>
            </div>

            <!-- Availability Status -->
            <span class="<%=
                    equipment.getAvailabilityStatus().equalsIgnoreCase("Available") ? "bg-green-100 text-green-800" :
                    equipment.getAvailabilityStatus().equalsIgnoreCase("Unavailable") ? "bg-red-100 text-red-800" :
                    "bg-yellow-100 text-yellow-800"
                %> px-3 py-1 rounded-full text-sm">
                    <%= equipment.getAvailabilityStatus() %>
                </span>
        </div>
    </div>

    <!-- Equipment Details Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Image Section -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <img src='/images/<%=equipment.getImage()%>' alt="equipment Image" onerror="this.src='/images/EquipPoint.png';" class="w-full h-96 object-cover">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                        <span class="text-2xl font-bold text-gray-800">
                            &#8377;<%= equipment.getRentalRate() %> / day
                        </span>
                    <a href="../booking/bookingEqument.jsp?id=<%=equipment.getId()%>" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition">Rent Now</a>
                </div>
            </div>
        </div>

        <!-- Specifications Section -->
        <div class="bg-white rounded-lg shadow-lg p-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Specifications</h2>
            <div class="space-y-4">
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-600">Model</span>
                    <span class="font-medium"><%= equipment.getModel() %></span>
                </div>
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-600">Manufacturing Year</span>
                    <span class="font-medium"><%= equipment.getManufacturingYear() %></span>
                </div>
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-600">Operating Weight</span>
                    <span class="font-medium"><%= equipment.getOperatingWeight() %>/ kg</span>
                </div>
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-600">Engine Power</span>
                    <span class="font-medium"><%= equipment.getEnginePower() %> HP</span>
                </div>
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-600">Fuel Type</span>
                    <span class="font-medium"><%= equipment.getFuelType() %></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Description Section -->
    <div class="bg-white rounded-lg shadow-lg p-6 mt-6">
        <h2 class="text-xl font-bold text-gray-800 mb-4">Description</h2>
        <p class="text-gray-600 leading-relaxed">
            <%= equipment.getDescription() %>
        </p>
    </div>

    <!-- Contact Section -->
    <div class="bg-white rounded-lg shadow-lg p-6 mt-6">
        <h2 class="text-xl font-bold text-gray-800 mb-4">Contact Information</h2>
        <div class="flex items-center gap-4">
            <button class="flex-1 bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition">
                <i class="fas fa-phone mr-2"></i> Call Owner
            </button>
            <button class="flex-1 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition">
                <i class="fas fa-envelope mr-2"></i> Send Message
            </button>
        </div>
    </div>
</div>
<%@ include file="/users/footer.jsp" %>
</body>
</html>
