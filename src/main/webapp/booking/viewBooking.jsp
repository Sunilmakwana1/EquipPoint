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
    <script>
        // Sorting Function
        function sortTable(n) {
            const table = document.getElementById("bookingTable");
            const rows = table.rows;
            let switching = true;
            let shouldSwitch, dir, switchcount = 0;
            dir = "asc"; // Set the sorting direction to ascending
            while (switching) {
                switching = false;
                let i;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    const x = rows[i].getElementsByTagName("TD")[n];
                    const y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir === "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount === 0 && dir === "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }

            // Update the sorting icons
            const headerCells = table.getElementsByTagName("th");
            for (let i = 0; i < headerCells.length; i++) {
                let icon = headerCells[i].getElementsByClassName("sort-icon")[0];
                if (i === n) {
                    if (dir === "asc") {
                        icon.classList.add("fa-arrow-up");
                        icon.classList.remove("fa-arrow-down");
                    } else {
                        icon.classList.add("fa-arrow-down");
                        icon.classList.remove("fa-arrow-up");
                    }
                } else {
                    icon.classList.remove("fa-arrow-up", "fa-arrow-down");
                }
            }
        }

        // Search Functionality
        function searchTable() {
            const input = document.getElementById("searchInput");
            const filter = input.value.toLowerCase();
            const table = document.getElementById("bookingTable");
            const rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName("td");
                let showRow = false;
                for (let j = 0; j < cells.length; j++) {
                    const cell = cells[j];
                    if (cell) {
                        if (cell.innerHTML.toLowerCase().indexOf(filter) > -1) {
                            showRow = true;
                            break;
                        }
                    }
                }
                if (showRow) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    </script>
    <style>
        /* Add vertical scroll after 5 records */
        .scrollable-table-body {
            max-height: 250px; /* Adjust this value to limit after 5 rows */
            overflow-y: auto;
        }
    </style>
</head>
<body class="bg-gray-50">
<%@ include file="/users/navbar.jsp" %>

<div class="max-w-7xl mx-auto px-4 py-6">
    <h1 class="text-3xl font-semibold text-gray-800 mb-6">Bookings</h1>

    <!-- Search Input -->
    <div class="mb-4">
        <input id="searchInput" type="text" onkeyup="searchTable()" class="px-4 py-2 border rounded-md w-full max-w-sm" placeholder="Search Bookings...">
    </div>

    <div class="overflow-x-hidden bg-white shadow-lg rounded-lg">
        <table id="bookingTable" class="min-w-full table-auto">
            <thead class="bg-gray-800 text-white">
            <tr>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(0)">
                    Booking ID <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(1)">
                    Equipment Name <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(2)">
                    Date <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(3)">
                    Duration (days) <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(4)">
                    Purpose <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(5)">
                    Total Cost <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(6)">
                    Status <i class="fa sort-icon"></i>
                </th>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase cursor-pointer" onclick="sortTable(7)">
                    Approval Status <i class="fa sort-icon"></i>
                </th>
                <% if (EquipPointUtil.isEqualToAdmin(userRole)) { %>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase">Actions</th>
                <% } %>
                <th class="py-3 px-6 text-left text-sm font-semibold uppercase">View</th>
            </tr>
            </thead>
            <tbody id="bookingTableBody" class="text-gray-700 scrollable-table-body">
            <%
                BookingService bookingService = new BookingService(DbConnection.getConnection());
                List<Booking> allBookings = new ArrayList<>();
                if (EquipPointUtil.isEqualToAdmin(userRole)) {
                    allBookings = bookingService.getAllBookings();
                } else {
                    allBookings = bookingService.getBookingsByUserId(CurrentLoginUser.getCurrentLoginUserId());
                }
                int count = 0;
                for (Booking booking : allBookings) {
                    if (count >= 10) break;  // Display only first 10 records
                    String statusClass = "";
                    String approvalClass = "";

                    // Determine status color classes
                    if ("Pending".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-yellow-200 text-yellow-800";
                    } else if ("Booked".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-green-200 text-green-800";
                    } else if ("Cancelled".equalsIgnoreCase(booking.getStatus())) {
                        statusClass = "bg-red-200 text-red-800";
                    }

                    // Determine approval status class
                    if ("Pending".equalsIgnoreCase("Pending")) {
                        approvalClass = "bg-yellow-200 text-yellow-800";
                    } else if ("Approved".equalsIgnoreCase("Pending")) {
                        approvalClass = "bg-blue-200 text-blue-800";
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
                        <span class="inline-block <%= approvalClass %> text-xs font-semibold py-1 px-2 rounded-full">
                            Approval
                        </span>
                </td>
                <% if (EquipPointUtil.isEqualToAdmin(userRole)) { %>
                <td class="py-3 px-6">
                    <a href="/api/delete-booking?id=<%= booking.getBookingId() %>" class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 focus:outline-none">
                        Approve
                    </a>
                </td>
                <% } %>
                <!-- Eye icon to view booking details -->
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
</div>

<%@ include file="/users/footer.jsp" %>

</body>
</html>
