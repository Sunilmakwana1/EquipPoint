
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
</head>
<body class="bg-gray-100">
    <%@include file="/users/navbar.jsp"%>
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Equipment</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <%
                EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
                List<Equipments> allEquipment = equipmentService.getAllEquipment();
                for (Equipments equipment : allEquipment) {
            %>
            <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                <img src='/images/<%=equipment.getImage()%>' alt="Equiment Image" class="w-full h-48 object-cover" onerror="this.src='/images/EquipPoint.png';" >
                <div class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2"><%=equipment.getModel()%></h2>
                    <p class="text-gray-600 mb-4"><%=equipment.getDescription()%></p>
                    <div class="flex justify-between items-center">
                        <span class="text-2xl font-bold text-blue-600">&#8377;<%=equipment.getRentalRate()%> / day</span>
                        <% if (EquipPointUtil.isEqualToAdmin(userRole)) { %>
                        <div>
                            <a href="/catagory/editEquipment.jsp?id=<%=equipment.getId()%>" class="bg-blue-500 text-white px-4 py-2 rounded">Edit</a>
                            <a href="/catagory/deleteEquipment.jsp?id=<%=equipment.getId()%>" class="bg-red-500 text-white px-4 py-2 rounded">Delete</a>
                        </div>
                        <% } %>
                        <a href="../booking/bookingEqument.jsp?id=<%=equipment.getId()%>" class="bg-green-500 text-white px-4 py-2 rounded">Rent Now</a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <%@include file="/users/footer.jsp"%>
</body>
</html>