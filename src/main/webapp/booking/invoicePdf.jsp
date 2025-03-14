<%@ page import="com.equip.point.model.Booking" %>
<%@ page import="com.equip.point.Service.*" %>
<%@ page import="com.equip.point.model.Equipments" %>
<%@ page import="com.equip.point.model.Invoice" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice PDF</title>
    <link rel="stylesheet" href="../src/style.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-10">

    <%
        // Assuming you have a BookingService to fetch booking details
        BookingService bookingService = new BookingService(DbConnection.getConnection());
        Long bookingId = Long.valueOf(request.getParameter("id"));
        Booking booking = bookingService.getBookingById(bookingId);
        InvoiceService  invoiceService = new InvoiceService(DbConnection.getConnection());
        Long inVoiceIdByBookingId = invoiceService.getInVoiceIdByBookingId(bookingId);
        EquipmentService equipmentService = new EquipmentService(DbConnection.getConnection());
        Equipments equipment = equipmentService.getEquipmentById(booking.getEquipmentId());
        Invoice invoice = invoiceService.getInvoiceByBookingId(bookingId);
    %>
    <div class="max-w-3xl mx-auto bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-2xl font-bold mb-4">Invoice</h1>
        <div class="mb-6">
            <p><strong>Invoice Number:</strong> # <%= booking.getBookingId() %></p>
            <p><strong>Transaction ID:</strong> # <%= inVoiceIdByBookingId %></p>
        </div>
        <div class="mb-6">
            <h2 class="text-xl font-semibold mb-2">Vehicle Details</h2>
            <p><strong>Model:</strong> <%= booking.getModelName() %></p>
            <p><strong>Manufacturing Year:</strong> <%= equipment.getManufacturingYear() %></p>
            <p><strong>Operating Weight:</strong> <%= equipment.getOperatingWeight() %> kg</p>
            <p><strong>Engine Power:</strong> <%= equipment.getEnginePower() %> HP</p>
            <p><strong>Fuel Type:</strong> <%= equipment.getFuelType() %></p>
        </div>
        <div class="mb-6">
            <h2 class="text-xl font-semibold mb-2">Payment Details</h2>
            <p><strong>Total Amount Paid:</strong> &#8377;<%= booking.getTotalCost() %></p>
            <p><strong>Payment Date:</strong> <%= invoice.getPaymentDate() %></p>
        </div>
    </div>
    <div class="text-center mt-8">
        <button onclick="window.print()" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Print Invoice</button>
    </div>
    <div class="text-center mt-8">
        <a href="../booking/viewBookingDetails.jsp?id=<%= booking.getBookingId() %>" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Back to Booking Details</a>
    </div>


</body>
</html>