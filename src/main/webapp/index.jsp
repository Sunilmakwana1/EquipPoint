<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EquipPoint - Heavy Equipment Rental</title>
    <!-- Security Meta Tags -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src 'self' data: https:; script-src 'self' https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com;">
    <meta http-equiv="X-Frame-Options" content="DENY">
    <meta http-equiv="X-Content-Type-Options" content="nosniff">
    <meta name="referrer" content="no-referrer">
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/style.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow-x: hidden; /* Prevent horizontal scrolling */
        }
        section {
            padding-top: 4rem; /* Adjust padding as needed */
            padding-bottom: 4rem; /* Adjust padding as needed */
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
</head>
<body class="bg-gray-50">
    <!-- Navbar -->
    <nav class="bg-white shadow-lg fixed w-full z-50">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center">
                    <img src="images/EquipPoint.png" alt="EquipPoint" class="h-8 w-auto">
                    <span class="ml-2 text-xl font-bold text-gray-800">EquipPoint</span>
                </div>
                <div class="hidden md:flex space-x-8">
                    <a href="#" class="text-gray-600 hover:text-blue-600 transition">Home</a>
                    <a href="#" class="text-gray-600 hover:text-blue-600 transition">Equipment</a>
                    <a href="#" class="text-gray-600 hover:text-blue-600 transition">About</a>
                    <a href="#" class="text-gray-600 hover:text-blue-600 transition">Contact</a>
                </div>
                <div>
                    <button class="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition" onclick="window.location.href='/login/login.jsp'">Login</button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="pt-24 pb-12 md:pt-32">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex flex-col md:flex-row items-center">
                <div class="md:w-1/2 animate__animated animate__fadeInLeft">
                    <h1 class="text-4xl md:text-6xl font-bold text-gray-800 mb-6">
                        Heavy Equipment Rental Made Simple
                    </h1>
                    <p class="text-lg text-gray-600 mb-8">
                        Streamlined equipment rental process for construction and industrial needs.
                        Access top-quality heavy machinery when you need it.
                    </p>
                    <button class="bg-blue-600 text-white px-8 py-3 rounded-full hover:bg-blue-700 transition">
                        Browse Equipment
                    </button>
                </div>
                <div class="md:w-1/2 mt-12 md:mt-0 animate__animated animate__fadeInRight">
                    <img src="images/EquipPoint.png" alt="Heavy Equipment" class="rounded-lg ">
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-16 bg-gray-100">
        <div class="max-w-7xl mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12">Why Choose EquipPoint?</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-xl font-semibold mb-4">Wide Selection</h3>
                    <p class="text-gray-600">Access to a diverse range of heavy equipment and vehicles.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-xl font-semibold mb-4">Easy Booking</h3>
                    <p class="text-gray-600">Simple and efficient online rental process.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-xl font-semibold mb-4">24/7 Support</h3>
                    <p class="text-gray-600">Round-the-clock customer service and technical support.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Equipment Section -->
    <section class="py-16">
        <div class="max-w-7xl mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12">Popular Equipment</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition">
                    <img src="images/excavator.jpg" alt="Excavator" class="w-full h-48 object-cover rounded-t-lg">
                    <div class="p-6">
                        <h3 class="text-xl font-semibold mb-4">Excavator</h3>
                        <p class="text-gray-600">Heavy-duty construction equipment for digging and earthmoving.</p>
                        <button class="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition mt-4">
                            Rent Now
                        </button>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition">
                    <img src="images/bulldozer.jpg" alt="Bulldozer" class="w-full h-48 object-cover rounded-t-lg">
                    <div class="p-6">
                        <h3 class="text-xl font-semibold mb-4">Bulldozer</h3>
                        <p class="text-gray-600">Powerful heavy equipment for pushing and moving materials.</p>
                        <button class="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition mt-4">
                            Rent Now
                        </button>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition">
                    <img src="images/crane.jpg" alt="Crane" class="w-full h-48 object-cover rounded-t-lg">
                    <div class="p-6">
                        <h3 class="text-xl font-semibold mb-4">Crane</h3>
                        <p class="text-gray-600">Versatile heavy machinery for lifting and moving heavy loads.</p>
                        <button class="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition mt-4">
                            Rent Now
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-16 bg-gray-100">
        <div class="max-w-7xl mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12">What Our Customers Say</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <p class="text-gray-600">"EquipPoint has been a reliable partner for our construction projects. The equipment is always in top condition and the service is excellent."</p>
                    <div class="flex items-center mt-4">
                        <img src="images/avatar1.jpg" alt="Customer 1" class="h-10 w-10 object-cover rounded-full">
                        <div class="ml-4">
                            <h4 class="font-semibold">John Doe</h4>
                            <p class="text-gray-500">Construction Manager</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <p class="text-gray-600">"The booking process is quick and easy. EquipPoint has a great selection of equipment and the prices are very competitive."</p>
                    <div class="flex items-center mt-4">
                        <img src="images/avatar2.jpg" alt="Customer 2" class="h-10 w-10 object-cover rounded-full">
                        <div class="ml-4">
                            <h4 class="font-semibold">Jane Smith</h4>
                            <p class="text-gray-500">Project Manager</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <p class="text-gray-600">"EquipPoint's customer service is top-notch. They are always available to assist us with any issues or concerns."</p>
                    <div class="flex items-center mt-4">
                        <img src="images/avatar3.jpg" alt="Customer 3" class="h-10 w-10 object-cover rounded-full">
                        <div class="ml-4">
                            <h4 class="font-semibold">David Wilson</h4>
                            <p class="text-gray-500">Site Supervisor</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Count Vender and Customer and equipment -->
    <section class="py-16">
        <div class="max-w-7xl mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-2xl font-semibold mb-4">100+</h3>
                    <p class="text-gray-600">Trusted Vendors</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-2xl font-semibold mb-4">500+</h3>
                    <p class="text-gray-600">Satisfied Customers</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition">
                    <h3 class="text-2xl font-semibold mb-4">1000+</h3>
                    <p class="text-gray-600">Equipment Available</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-12">
        <div class="max-w-7xl mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <h4 class="text-lg font-semibold mb-4">EquipPoint</h4>
                    <p class="text-gray-400">Your trusted partner in heavy equipment rental solutions.</p>
                </div>
                <div>
                    <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-white transition">About Us</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition">Equipment</a></li>
                        <li><a href="dashboard/contactUs.jsp" class="text-gray-400 hover:text-white transition">Contact</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-lg font-semibold mb-4">Contact Us</h4>
                    <ul class="space-y-2 text-gray-400">
                        <li>Email: info@equippoint.com</li>
                        <li>Phone: (555) 123-4567</li>
                        <li>Address: 123 Equipment Street</li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-lg font-semibold mb-4">Follow Us</h4>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white transition">Facebook</a>
                        <a href="#" class="text-gray-400 hover:text-white transition">Twitter</a>
                        <a href="#" class="text-gray-400 hover:text-white transition">LinkedIn</a>
                    </div>
                </div>
            </div>
            <div class="mt-8 pt-8 border-t border-gray-700 text-center text-gray-400">
                <p>&copy; 2024 EquipPoint. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>