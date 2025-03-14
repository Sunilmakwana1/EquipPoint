<%@ page import="com.equip.point.model.Booking" %>
<%@ page import="com.equip.point.Service.BookingService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Payment</title>
    <link href="../src/style.css" rel="stylesheet">
</head>

<body class="bg-gray-100">
    <%@include file="/users/navbar.jsp"%>
    <%
        // Assuming you have a BookingService to fetch booking details
        BookingService bookingService = new BookingService(DbConnection.getConnection());
        Long bookingId = Long.valueOf(request.getParameter("id"));
        Booking booking = bookingService.getBookingById(bookingId);
        UserService userService = new UserService(DbConnection.getConnection());
        userService.getUserById(booking.getUserId());
    %>
    <div class="container mx-auto p-4">
        <div class="max-w-md mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl">
            <div class="md:flex">
                <div class="p-8">
                    <div class="uppercase tracking-wide text-sm text-indigo-500 font-semibold">Bill Payment</div>
                    <h1 class="block mt-1 text-lg leading-tight font-medium text-black">Model: <%= booking.getModelName() %></h1>
                    <p class="mt-2 text-gray-500">Total Cost: &#8377;<%= booking.getTotalCost() %></p>
                    <form class= "space-y-6" action="${pageContext.request.contextPath}/api/bill-payment " method="POST">
                        <input type="hidden" name="equipmentId" value="<%= booking.getEquipmentId() %>">
                        <input type="hidden" name="paymentAmount" value="<%= booking.getTotalCost() %>">
                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                        <div class="flex items-center justify-between"></div>
                            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="submit">
                                Pay Now
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/users/footer.jsp"%>
</body>
</html>
