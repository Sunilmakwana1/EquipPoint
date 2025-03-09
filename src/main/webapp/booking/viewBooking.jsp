<%@ page import="com.equip.point.Service.BookingService" %>
<%@ page import="com.equip.point.model.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.equip.point.util.CurrentLoginUser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.14.0/Sortable.min.js"></script> <!-- For sorting -->
</head>
<body class="bg-gray-50">
<%@ include file="/users/navbar.jsp" %>

<%
    int pageSize = 10;  // Number of records per page
    int pageNumber = 1; // Default page number
    String searchTerm = request.getParameter("searchTerm");
    String pageParam = request.getParameter("page");

    if (pageParam != null) {
        pageNumber = Integer.parseInt(pageParam);
    }

    BookingService bookingService = new BookingService(DbConnection.getConnection());
    List<Booking> allBookings = new ArrayList<>();
    int totalBookingsCount = EquipPointUtil.isEqualToAdmin(userRole) ?
            bookingService.getTotalBookingsCount(searchTerm) :
            bookingService.getTotalBookingsByUserIdCount(CurrentLoginUser.getCurrentLoginUserId(), searchTerm);

    int totalPages = (int) Math.ceil(totalBookingsCount / (double) pageSize);

    if (EquipPointUtil.isEqualToAdmin(userRole)) {
        allBookings = bookingService.getAllBookings(pageNumber, pageSize, searchTerm);
    } else {
        allBookings = bookingService.getBookingsByUserId(CurrentLoginUser.getCurrentLoginUserId(), pageNumber, pageSize, searchTerm);
    }
%>

<div class="max-w-7xl mx-auto px-4 py-6">
    <h1 class="text-3xl font-semibold text-gray-800 mb-6">Bookings</h1>

    <!-- Search Bar -->
    <div class="mb-4 flex items-center">
        <form method="get" action="" class="flex items-center w-full">
            <div class="flex items-center w-full">
                <input type="text" id="searchTerm" name="searchTerm" value="<%= searchTerm != null ? searchTerm : "" %>" placeholder="Search Bookings..." class="px-4 py-2 border rounded-md w-64 mr-4">
                <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md">
                    <i class="fas fa-search"></i>
                </button>
                <button type="button" id="clearSearch" class="ml-4 px-4 py-2 bg-gray-500 text-white rounded-md">
                    Clear Search
                </button>
            </div>
        </form>
    </div>

    <!-- Table for Bookings -->
    <div class="overflow-x-hidden bg-white shadow-lg rounded-lg">
        <table id="bookingTable" class="min-w-full table-auto">
            <thead class="bg-gray-800 text-white">
            <tr>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(0)">Booking ID</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(1)">Equipment Name</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(2)">Date</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(3)">Duration</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(4)">Purpose</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(5)">Total Cost</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(6)">Status</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(7)">Approval Status</th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase">View</th>
            </tr>
            </thead>
            <tbody id="bookingTableBody" class="text-gray-700">
            <%
                int count = 0;
                for (Booking booking : allBookings) {
                    if (count >= pageSize) break;
                    String statusClass = "";
                    if ("Pending".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-yellow-200 text-yellow-800";
                    } else if ("Booked".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-green-200 text-green-800";
                    } else if ("Cancelled".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-red-200 text-red-800";
                    }
            %>
            <tr class="hover:bg-gray-50">
                <td class="py-3 px-6">#<%= booking.getBookingId() %></td>
                <td class="py-3 px-6"><%= booking.getModelName() %></td>
                <td class="py-3 px-6"><%= booking.getStartDate() %></td>
                <td class="py-3 px-6"><%= booking.getDuration() %></td>
                <td class="py-3 px-6"><%= booking.getPurposeOfBooking() %></td>
                <td class="py-3 px-6">&#8377;<%= booking.getTotalCost() %></td>
                <td class="py-3 px-6">
                    <span class="inline-block <%= statusClass %> text-xs font-semibold py-1 px-2 rounded-full">
                        <%= booking.getStatus() %>
                    </span>
                </td>
                <td class="py-3 px-6">
                    <span class="inline-block <%= statusClass %> text-xs font-semibold py-1 px-2 rounded-full">
                        Approval
                    </span>
                </td>
                <td class="py-3 px-6">
                    <a href="viewBookingDetails.jsp?id=<%= booking.getBookingId() %>" class="text-gray-500 hover:text-blue-500 focus:outline-none">
                        <i class="fas fa-eye text-xl"></i>
                    </a>
                </td>
            </tr>
            <% count++; } %>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <div class="mt-4">
        <nav aria-label="Page navigation">
            <ul class="inline-flex items-center space-x-2">
                <li>
                    <a href="?page=<%= pageNumber - 1 > 0 ? pageNumber - 1 : 1 %>&searchTerm=<%= searchTerm != null ? searchTerm : "" %>" class="px-3 py-2 bg-gray-200 rounded-md">Previous</a>
                </li>
                <% for (int i = 1; i <= totalPages; i++) { %>
                <li>
                    <a href="?page=<%= i %>&searchTerm=<%= searchTerm != null ? searchTerm : "" %>" class="px-3 py-2 <%= (i == pageNumber) ? "bg-blue-500 text-white" : "bg-gray-200" %> rounded-md">
                        <%= i %>
                    </a>
                </li>
                <% } %>
                <li>
                    <a href="?page=<%= pageNumber < totalPages ? pageNumber + 1 : totalPages %>&searchTerm=<%= searchTerm != null ? searchTerm : "" %>" class="px-3 py-2 bg-gray-200 rounded-md">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<%@ include file="/users/footer.jsp" %>

<script>
    // Clear Search Button
    document.getElementById("clearSearch").addEventListener("click", function() {
        document.getElementById("searchTerm").value = "";
        window.location.href = window.location.pathname;  // Reset search and reload the page
    });

    // Sort Table Function
    function sortTable(columnIndex) {
        let table = document.getElementById("bookingTable");
        let rows = Array.from(table.rows).slice(1);  // Get all rows except the header
        let isAscending = table.rows[0].cells[columnIndex].classList.contains("asc");

        rows.sort((rowA, rowB) => {
            let cellA = rowA.cells[columnIndex].innerText;
            let cellB = rowB.cells[columnIndex].innerText;

            if (isAscending) {
                return cellA < cellB ? -1 : cellA > cellB ? 1 : 0;
            } else {
                return cellA < cellB ? 1 : cellA > cellB ? -1 : 0;
            }
        });

        rows.forEach(row => table.appendChild(row));  // Reorder rows

        // Toggle sorting state
        table.rows[0].cells[columnIndex].classList.toggle("asc", !isAscending);
    }
</script>

</body>
</html>
