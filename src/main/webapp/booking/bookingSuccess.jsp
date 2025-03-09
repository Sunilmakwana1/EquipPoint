<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Success</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/aos@2.3.1/dist/aos.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/aos@2.3.1/dist/aos.css">
</head>
<body class="bg-gray-100">

  <!-- Main Container -->
  <div class="flex justify-center items-center min-h-screen">
    <div class="bg-white shadow-xl rounded-lg p-8 max-w-sm w-full" data-aos="fade-up">
      <div class="text-center mb-4">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-24 h-24 text-green-500 mx-auto mb-4 animate-bounce" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
        </svg>
        <h2 class="text-2xl font-semibold text-gray-800 mb-2">Booking Successful!</h2>
        <p class="text-gray-600">Your booking has been confirmed. Your booking ID is:</p>
      </div>
      
      <!-- Booking ID Display -->
      <div class="bg-gray-100 p-4 rounded-lg mb-6 text-center">
        <p class="font-mono text-xl text-blue-600"><%=request.getAttribute("bookingSuccess")%></p>
      </div>

      <!-- Success Message -->
      <p class="text-gray-700 text-center mb-6">We have sent a confirmation email to your inbox. Thank you for booking with us!</p>

      <!-- Button to go home or make another booking -->
      <div class="flex justify-center">
        <a href="/" class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition duration-300 ease-in-out transform hover:scale-105">
          Go to Home
        </a>
      </div>
    </div>
  </div>

  <!-- AOS Initialization -->
  <script>
    AOS.init({
      duration: 1000,
      easing: 'ease-out-back',
    });
  </script>

</body>
</html>
