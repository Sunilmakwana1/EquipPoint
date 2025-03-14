<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Total Equipment Booking Graph</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="w-full max-w-4xl p-6 bg-white rounded-lg shadow-lg">
    <h2 class="text-2xl font-bold mb-4">Total Equipment Booking</h2>
    <canvas id="bookingChart"></canvas>
</div>

<script>
    // Fetch the booking data from the servlet
    fetch('/api/booking-chart') // This matches the @WebServlet mapping
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('bookingChart').getContext('2d');
            const bookingChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    datasets: [{
                        label: 'Total Bookings',
                        data: data,  // Data comes from the servlet
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => console.error('Error fetching data:', error));
</script>
</body>
</html>
