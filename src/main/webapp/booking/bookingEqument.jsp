<%@ page import="com.equip.point.Service.EquipmentService" %>
<%@ page import="com.equip.point.model.Equipments" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipment Booking</title>
    <link rel="stylesheet" href="../src/style.css">
    <script>
        function calculateTotalCost() {
            const duration = document.getElementById('duration').value;
            const rentalRate = document.getElementById('rentalRate').value;
            const totalCost = duration * rentalRate;
            document.getElementById('totalCost').value = totalCost.toFixed(2);
        }
    </script>
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp"%>
<div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-800">Equipment Booking</h1>
        <p class="text-gray-600">Select equipment and schedule your booking</p>
    </div>
    <%
        EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
        Long equipmentId = Long.valueOf(request.getParameter("id"));
        Equipments equipment = equipmentService.getEquipmentById(equipmentId);
    %>
    <!-- Booking Form -->
    <div class="bg-white rounded-lg shadow-lg p-6">
        <form class="space-y-6" action="${pageContext.request.contextPath}/api/booking" method="POST">
            <!-- Equipment Name not editable -->
            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="equipmentName">
                    Equipment Name
                </label>
                <input type="text" id="equipmentName" name="equipmentName" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="<%= equipment.getModel() %>" readonly >
            </div>

            <!-- Date -->
            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="date">
                    Date
                </label>
                <input type="date" id="date" name="date" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"  required>
            </div>

            <!-- Duration to days -->
            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="duration">
                    Duration (in days)
                </label>
                <input type="number" id="duration" name="duration" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" oninput="calculateTotalCost()"  required>
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="rentalRate">
                    Rental Rate (per day)
                </label>
                <input type="text" id="rentalRate" name="rentalRate" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="<%= equipment.getRentalRate() %>" readonly >
            </div>

            <!-- Purpose -->
            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="purpose">
                    Purpose of Booking
                </label>
                <textarea id="purpose" rows="3" name="purpose" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"  required></textarea>
            </div>

            <!-- total cost on left side -->
            <div>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="totalCost">
                    Total Cost
                </label>
                <input type="text" id="totalCost" name="totalCost" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"  readonly>
            </div>

            <!-- Submit Button -->
            <div>
                <button type="submit" class="w-full bg-blue-500 text-white font-bold py-2 px-4 rounded-md hover:bg-blue-600 transition duration-300">
                    Book Equipment
                </button>
            </div>
        </form>
    </div>
</div>
<%@include file="/users/footer.jsp"%>
</body>
</html>