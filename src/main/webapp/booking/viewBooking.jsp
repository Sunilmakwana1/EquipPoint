<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100">
<%@include file="/users/navbar.jsp"%>
    <div class="container mx-auto p-4">
        <h1 class="text-3xl font-bold mb-4">Bookings</h1>
        <%--<div class="flex justify-end items-center mb-4">
            <a href="bookingEqument.jsp" id="addUserButton" class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
                Book Equipment
            </a>
        </div>--%>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
                <thead class="bg-gray-800 text-white">
                    <tr>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Equipment Name</th>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Date</th>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Duration (in days)</th>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Purpose of Booking</th>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Total Cost</th>
                        <th class="w-1/6 py-3 px-4 uppercase font-semibold text-sm">Status</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <!-- Example row -->
                    <tr>
                        <td class="w-1/6 py-3 px-4">Camera</td>
                        <td class="w-1/6 py-3 px-4">2023-10-01</td>
                        <td class="w-1/6 py-3 px-4">3</td>
                        <td class="w-1/6 py-3 px-4">Photography</td>
                        <td class="w-1/6 py-3 px-4">$150</td>
                        <td class="w-1/6 py-3 px-4">Booked</td>
                    </tr>
                    <!-- Add more rows as needed -->
                </tbody>
            </table>
        </div>
    </div>
<%@include file="/users/footer.jsp"%>
</body>
</html>