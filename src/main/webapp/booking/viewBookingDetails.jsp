<%@ page import="com.equip.point.model.Booking" %>
<%@ page import="com.equip.point.Service.BookingService" %>
<%@ page import="com.equip.point.util.DbConnection" %>
<%@ page import="com.equip.point.Service.UserService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <link href="../src/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css"></script>
    <style>
        /* Keyframe animation for gradient background */
        @keyframes gradientBackground {
            0% {
                background: linear-gradient(to right, #6EE7B7, #3B82F6);
            }
            50% {
                background: linear-gradient(to right, #9333EA, #F472B6);
            }
            100% {
                background: linear-gradient(to right, #3B82F6, #9333EA);
            }
        }

        /* Apply the gradient animation to the body */
        body {
            animation: gradientBackground 10s ease infinite;
            background-size: 400% 400%;
        }

        /* Add a fade-in effect for the container */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Add fade-in animation to the main container */
        .animate-fade-in {
            animation: fadeIn 1s ease-out;
        }
    </style>
</head>
<%
    // Assuming you have a BookingService to fetch booking details
    BookingService bookingService = new BookingService(DbConnection.getConnection());
    Long bookingId = Long.valueOf(request.getParameter("id"));
    Booking booking = bookingService.getBookingById(bookingId);
    UserService userService = new UserService(DbConnection.getConnection());
    userService.getUserById(booking.getUserId());
%>
<body class="min-h-screen flex items-center justify-center font-sans">
<div class="bg-white shadow-xl rounded-lg p-8 max-w-lg w-full space-y-6 animate-fade-in">
    <h2 class="text-4xl font-bold text-gray-800 mb-6 text-center">Booking Details</h2>

    <div class="space-y-4">
        <div class="animate__animated animate__fadeInUp">
            <label class="block text-gray-700 text-sm font-medium">Booking ID:</label>
            <p class="text-gray-800 text-lg mt-1">#<%= booking.getBookingId() %></p>
        </div>

        <div class="animate__animated animate__fadeInUp animate__delay-1s">
            <label class="block text-gray-700 text-sm font-medium">Customer Name:</label>
            <p class="text-gray-800 text-lg mt-1"><%= userService.getUserById(booking.getUserId()).getFullName() %></p>
        </div>

        <div class="animate__animated animate__fadeInUp animate__delay-2s">
            <label class="block text-gray-700 text-sm font-medium">Equipment:</label>
            <p class="text-gray-800 text-lg mt-1"><%= booking.getModelName() %></p>
        </div>

        <div class="animate__animated animate__fadeInUp animate__delay-3s">
            <label class="block text-gray-700 text-sm font-medium">Booking Date:</label>
            <p class="text-gray-800 text-lg mt-1"><%= booking.getStartDate() %></p>
        </div>

        <div class="animate__animated animate__fadeInUp animate__delay-4s">
            <label class="block text-gray-700 text-sm font-medium">Return Date:</label>
            <p class="text-gray-800 text-lg mt-1"><%= booking.getEndDate() %></p>
        </div>

        <div class="animate__animated animate__fadeInUp animate__delay-5s">
            <label class="block text-gray-700 text-sm font-medium">Status:</label>
            <p class="text-gray-800 text-lg mt-1"><%= booking.getStatus() %></p>
        </div>
        <div class="animate__animated animate__fadeInUp animate__delay-6s">
            <label class="block text-gray-700 text-sm font-medium">Invoice </label>
            <p class="text-gray-800 text-lg mt-1"><a href="/invoice/viewInvoice.jsp?id=<%= booking.getBookingId() %>" class="text-blue-500 hover:underline">View Invoice</a></p>
    </div>

    <div class="mt-6">
        <a href="/booking/viewBooking.jsp" class="w-full inline-block text-center bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-3 rounded-lg transition duration-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50 transform hover:scale-105">
            Back to Booking List
        </a>
    </div>
</div>
</body>
</html>
