<%@ page import="com.equip.point.Service.EquipmentService" %>
<%@ page import="com.equip.point.model.Equipments" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipment Catalog</title>
    <link rel="stylesheet" href="../src/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp" %>
<div class="container mx-auto px-4 py-8">
    <h1 class="text-4xl font-bold text-gray-900 mb-8">Equipment</h1>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
        <%
            EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
            List<Equipments> allEquipment = equipmentService.getAllEquipment();
            for (Equipments equipment : allEquipment) {
        %>
        <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
            <img src='/images/equipment<%=equipment.getImage()%>' alt="Equipment Image" class="w-full h-56 object-cover"
                 onerror="this.src='/images/EquipPoint.png';">
            <div class="p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-2"><%=equipment.getModel()%>
                </h2>
                <p class="text-gray-600 text-sm mb-4"><%=equipment.getDescription()%>
                </p>
                <div class="flex flex-col sm:flex-row justify-between items-center space-y-4 sm:space-y-0 sm:space-x-4">
                    <span class="text-xl font-bold text-blue-600">&#8377;<%=equipment.getRentalRate()%> / day</span>

                    <% if (EquipPointUtil.isEqualToAdmin(userRole)) { %>
                    <div class="space-y-4 sm:space-y-0 sm:flex sm:flex-col sm:space-x-0 sm:space-y-4 flex items-center">
                        <!-- Edit Button -->
                        <a href="/catagory/editEquipment.jsp?id=<%=equipment.getId()%>"
                           class="bg-blue-500 text-white p-4 rounded-full hover:bg-blue-600 transition-colors duration-200 flex items-center justify-center text-3xl">
                            <i class="fas fa-edit"></i> <!-- Edit icon -->
                        </a>
                        <!-- Delete Button -->
                        <a href="/catagory/deleteEquipment.jsp?id=<%=equipment.getId()%>"
                           class="bg-red-500 text-white p-4 rounded-full hover:bg-red-600 transition-colors duration-200 flex items-center justify-center text-3xl">
                            <i class="fas fa-trash-alt"></i> <!-- Delete icon -->
                        </a>
                        <!-- Maintenance Button -->
                        <a href="/catagory/equpmentMaintenance.html?id=<%=equipment.getId()%>"
                           class="bg-orange-500 text-white p-4 rounded-full hover:bg-orange-600 transition-colors duration-200 flex items-center justify-center text-3xl">
                            <i class="fas fa-tools"></i> <!-- Maintenance icon -->
                        </a>
                    </div>
                    <% } %>

                    <div class="space-x-2 flex flex-wrap justify-center">
                        <!-- View Button -->
                        <a href="/catagory/viewDetailConstructionEquipment.jsp?id=<%=equipment.getId()%>"
                           class="bg-green-500 text-white p-4 rounded-full hover:bg-green-600 transition-colors duration-200 flex items-center justify-center text-3xl">
                            <i class="fas fa-eye"></i> <!-- View icon -->
                        </a>
                        <!-- Rent Now Button -->
                        <a href="../booking/bookingEqument.jsp?id=<%=equipment.getId()%>"
                           class="bg-yellow-500 text-white p-4 rounded-full hover:bg-yellow-600 transition-colors duration-200 flex items-center justify-center text-3xl">
                            <i class="fas fa-cart-plus"></i> <!-- Rent icon -->
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%@include file="/users/footer.jsp" %>
</body>
</html>
