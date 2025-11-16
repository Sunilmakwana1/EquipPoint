<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EquipPoint - Premium Heavy Equipment Rental</title>
    <link rel="stylesheet" href="src/style.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow-x: hidden;
        }
        section {
            padding-top: 4rem;
            padding-bottom: 4rem;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .gradient-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-10px);
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <!-- Navbar -->
    <nav class="bg-white shadow-lg fixed w-full z-50 border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-3">
                    <div class="gradient-bg rounded-lg p-2">
                        <i class="fas fa-hard-hat text-white text-xl"></i>
                    </div>
                    <span class="text-2xl font-bold gradient-text">EquipPoint</span>
                </div>
                <div class="hidden md:flex space-x-8">
                    <a href="#home" class="text-gray-600 hover:text-purple-600 transition font-medium">Home</a>
                    <a href="#features" class="text-gray-600 hover:text-purple-600 transition font-medium">Features</a>
                    <a href="#equipment" class="text-gray-600 hover:text-purple-600 transition font-medium">Equipment</a>
                    <a href="dashboard/contactUs.jsp" class="text-gray-600 hover:text-purple-600 transition font-medium">Contact</a>
                </div>
                <div class="flex space-x-4">
                    <button class="text-purple-600 px-6 py-2 rounded-full hover:bg-purple-50 transition font-medium" onclick="window.location.href='/users/signUp.jsp'">Sign Up</button>
                    <button class="gradient-bg text-white px-6 py-2 rounded-full hover:shadow-lg transition font-medium" onclick="window.location.href='/login/login.jsp'">
                        <i class="fas fa-sign-in-alt mr-2"></i>Login
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="pt-24 pb-12 md:pt-32 bg-gradient-to-br from-purple-50 via-white to-blue-50">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex flex-col md:flex-row items-center gap-12">
                <div class="md:w-1/2 animate__animated animate__fadeInLeft">
                    <div class="inline-block bg-purple-100 text-purple-700 px-4 py-2 rounded-full text-sm font-semibold mb-6">
                        <i class="fas fa-star mr-2"></i>Trusted by 500+ Companies
                    </div>
                    <h1 class="text-5xl md:text-7xl font-bold text-gray-900 mb-6 leading-tight">
                        Heavy Equipment Rental 
                        <span class="gradient-text">Made Simple</span>
                    </h1>
                    <p class="text-xl text-gray-600 mb-8 leading-relaxed">
                        Access premium construction equipment with our streamlined rental platform. 
                        Professional-grade machinery available 24/7 with instant booking.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <button class="gradient-bg text-white px-8 py-4 rounded-full hover:shadow-2xl transition font-semibold text-lg" onclick="window.location.href='/login/login.jsp'">
                            <i class="fas fa-rocket mr-2"></i>Get Started
                        </button>
                        <button class="bg-white text-purple-600 px-8 py-4 rounded-full hover:shadow-xl transition font-semibold text-lg border-2 border-purple-200" onclick="window.location.href='#equipment'">
                            <i class="fas fa-search mr-2"></i>Browse Equipment
                        </button>
                    </div>
                    <div class="mt-8 flex items-center gap-8">
                        <div class="flex -space-x-2">
                            <div class="w-10 h-10 rounded-full bg-purple-400 border-2 border-white"></div>
                            <div class="w-10 h-10 rounded-full bg-blue-400 border-2 border-white"></div>
                            <div class="w-10 h-10 rounded-full bg-pink-400 border-2 border-white"></div>
                            <div class="w-10 h-10 rounded-full bg-green-400 border-2 border-white flex items-center justify-center text-xs font-bold text-white">+500</div>
                        </div>
                        <div>
                            <div class="flex text-yellow-400 text-lg">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <p class="text-sm text-gray-600 mt-1">Rated 5.0 by our customers</p>
                        </div>
                    </div>
                </div>
                <div class="md:w-1/2 mt-12 md:mt-0 animate__animated animate__fadeInRight">
                    <div class="relative">
                        <div class="absolute -inset-4 bg-gradient-to-r from-purple-400 to-blue-400 rounded-2xl opacity-20 blur-2xl"></div>
                        <img src="images/EquipPoint.png" alt="Heavy Equipment" class="relative rounded-2xl shadow-2xl">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4">
            <div class="text-center mb-16 fade-in-up">
                <span class="text-purple-600 font-semibold text-sm uppercase tracking-wide">Features</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mt-3 mb-4">Why Choose EquipPoint?</h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">Discover what makes us the leading heavy equipment rental platform</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-gradient-to-br from-purple-50 to-blue-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-purple-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-warehouse text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">Wide Selection</h3>
                    <p class="text-gray-600 leading-relaxed">Access over 1,000+ pieces of premium heavy equipment from excavators to cranes, all maintained to the highest standards.</p>
                </div>
                <div class="bg-gradient-to-br from-blue-50 to-purple-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-blue-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-calendar-check text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">Instant Booking</h3>
                    <p class="text-gray-600 leading-relaxed">Book equipment in seconds with our streamlined platform. Real-time availability and immediate confirmation guaranteed.</p>
                </div>
                <div class="bg-gradient-to-br from-pink-50 to-purple-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-pink-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-headset text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">24/7 Support</h3>
                    <p class="text-gray-600 leading-relaxed">Our dedicated support team is available around the clock to assist you with any questions or concerns you may have.</p>
                </div>
                <div class="bg-gradient-to-br from-green-50 to-blue-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-green-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-shield-alt text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">Secure & Reliable</h3>
                    <p class="text-gray-600 leading-relaxed">Enterprise-grade security with BCrypt encryption and comprehensive insurance coverage on all rentals.</p>
                </div>
                <div class="bg-gradient-to-br from-yellow-50 to-orange-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-yellow-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-dollar-sign text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">Best Pricing</h3>
                    <p class="text-gray-600 leading-relaxed">Competitive rates with flexible rental periods. No hidden fees, transparent pricing from the start.</p>
                </div>
                <div class="bg-gradient-to-br from-indigo-50 to-purple-50 p-8 rounded-2xl shadow-md hover:shadow-2xl card-hover border border-indigo-100">
                    <div class="gradient-bg w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-truck text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-gray-900">Fast Delivery</h3>
                    <p class="text-gray-600 leading-relaxed">Quick equipment delivery to your site. We ensure your project stays on schedule with timely service.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Equipment Section -->
    <section id="equipment" class="py-20 bg-gradient-to-br from-gray-50 to-purple-50">
        <div class="max-w-7xl mx-auto px-4">
            <div class="text-center mb-16 fade-in-up">
                <span class="text-purple-600 font-semibold text-sm uppercase tracking-wide">Equipment</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mt-3 mb-4">Popular Equipment</h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">Professional-grade machinery for every construction need</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white rounded-2xl shadow-lg hover:shadow-2xl card-hover overflow-hidden">
                    <div class="relative">
                        <div class="absolute top-4 right-4 bg-green-500 text-white px-4 py-2 rounded-full text-sm font-bold">
                            <i class="fas fa-check-circle mr-1"></i>Available
                        </div>
                        <div class="h-56 bg-gradient-to-br from-purple-100 to-blue-100 flex items-center justify-center">
                            <i class="fas fa-tractor text-purple-600 text-6xl"></i>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="text-2xl font-bold text-gray-900">Excavator</h3>
                            <span class="text-purple-600 font-bold text-xl">$250/day</span>
                        </div>
                        <p class="text-gray-600 mb-4 leading-relaxed">Heavy-duty construction equipment perfect for digging, earthmoving, and demolition projects.</p>
                        <div class="flex items-center gap-4 mb-4 text-sm text-gray-500">
                            <span><i class="fas fa-weight-hanging mr-1"></i>20 tons</span>
                            <span><i class="fas fa-gas-pump mr-1"></i>Diesel</span>
                            <span><i class="fas fa-calendar mr-1"></i>2023</span>
                        </div>
                        <button class="w-full gradient-bg text-white px-6 py-3 rounded-xl hover:shadow-xl transition font-semibold" onclick="window.location.href='/login/login.jsp'">
                            <i class="fas fa-shopping-cart mr-2"></i>Rent Now
                        </button>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-lg hover:shadow-2xl card-hover overflow-hidden">
                    <div class="relative">
                        <div class="absolute top-4 right-4 bg-green-500 text-white px-4 py-2 rounded-full text-sm font-bold">
                            <i class="fas fa-check-circle mr-1"></i>Available
                        </div>
                        <div class="h-56 bg-gradient-to-br from-blue-100 to-purple-100 flex items-center justify-center">
                            <i class="fas fa-truck-monster text-blue-600 text-6xl"></i>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="text-2xl font-bold text-gray-900">Bulldozer</h3>
                            <span class="text-purple-600 font-bold text-xl">$300/day</span>
                        </div>
                        <p class="text-gray-600 mb-4 leading-relaxed">Powerful heavy equipment for pushing, moving materials, and grading terrain with precision.</p>
                        <div class="flex items-center gap-4 mb-4 text-sm text-gray-500">
                            <span><i class="fas fa-weight-hanging mr-1"></i>25 tons</span>
                            <span><i class="fas fa-gas-pump mr-1"></i>Diesel</span>
                            <span><i class="fas fa-calendar mr-1"></i>2023</span>
                        </div>
                        <button class="w-full gradient-bg text-white px-6 py-3 rounded-xl hover:shadow-xl transition font-semibold" onclick="window.location.href='/login/login.jsp'">
                            <i class="fas fa-shopping-cart mr-2"></i>Rent Now
                        </button>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-lg hover:shadow-2xl card-hover overflow-hidden">
                    <div class="relative">
                        <div class="absolute top-4 right-4 bg-yellow-500 text-white px-4 py-2 rounded-full text-sm font-bold">
                            <i class="fas fa-fire mr-1"></i>Popular
                        </div>
                        <div class="h-56 bg-gradient-to-br from-pink-100 to-purple-100 flex items-center justify-center">
                            <i class="fas fa-crane text-pink-600 text-6xl"></i>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="text-2xl font-bold text-gray-900">Crane</h3>
                            <span class="text-purple-600 font-bold text-xl">$400/day</span>
                        </div>
                        <p class="text-gray-600 mb-4 leading-relaxed">Versatile heavy machinery for lifting and moving heavy loads with maximum safety and efficiency.</p>
                        <div class="flex items-center gap-4 mb-4 text-sm text-gray-500">
                            <span><i class="fas fa-weight-hanging mr-1"></i>50 tons</span>
                            <span><i class="fas fa-gas-pump mr-1"></i>Diesel</span>
                            <span><i class="fas fa-calendar mr-1"></i>2024</span>
                        </div>
                        <button class="w-full gradient-bg text-white px-6 py-3 rounded-xl hover:shadow-xl transition font-semibold" onclick="window.location.href='/login/login.jsp'">
                            <i class="fas fa-shopping-cart mr-2"></i>Rent Now
                        </button>
                    </div>
                </div>
            </div>
            <div class="text-center mt-12">
                <button class="bg-white text-purple-600 px-8 py-4 rounded-full hover:shadow-xl transition font-semibold text-lg border-2 border-purple-200" onclick="window.location.href='/login/login.jsp'">
                    View All Equipment <i class="fas fa-arrow-right ml-2"></i>
                </button>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-20 bg-gradient-to-br from-purple-50 to-blue-50">
        <div class="max-w-7xl mx-auto px-4">
            <div class="text-center mb-16 fade-in-up">
                <span class="text-purple-600 font-semibold text-sm uppercase tracking-wide">Testimonials</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mt-3 mb-4">What Our Customers Say</h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">Trusted by industry leaders across the nation</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-2xl card-hover border border-gray-100">
                    <div class="flex text-yellow-400 text-lg mb-4">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="text-gray-600 leading-relaxed mb-6 italic">"EquipPoint has been a game-changer for our construction projects. The equipment is always in pristine condition and their service is outstanding. Highly recommended!"</p>
                    <div class="flex items-center mt-6">
                        <div class="w-14 h-14 rounded-full gradient-bg flex items-center justify-center text-white font-bold text-xl">
                            JD
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-gray-900">John Doe</h4>
                            <p class="text-gray-500 text-sm">Construction Manager</p>
                            <p class="text-purple-600 text-sm font-semibold">BuildCo Inc.</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-2xl card-hover border border-gray-100">
                    <div class="flex text-yellow-400 text-lg mb-4">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="text-gray-600 leading-relaxed mb-6 italic">"The booking process is incredibly smooth and intuitive. Great selection of equipment at competitive prices. EquipPoint is now our go-to rental platform!"</p>
                    <div class="flex items-center mt-6">
                        <div class="w-14 h-14 rounded-full gradient-bg flex items-center justify-center text-white font-bold text-xl">
                            JS
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-gray-900">Jane Smith</h4>
                            <p class="text-gray-500 text-sm">Project Manager</p>
                            <p class="text-purple-600 text-sm font-semibold">Mega Projects Ltd.</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-2xl card-hover border border-gray-100">
                    <div class="flex text-yellow-400 text-lg mb-4">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="text-gray-600 leading-relaxed mb-6 italic">"Outstanding customer service! The EquipPoint team is always ready to help, no matter the time. Their 24/7 support has been invaluable to our operations."</p>
                    <div class="flex items-center mt-6">
                        <div class="w-14 h-14 rounded-full gradient-bg flex items-center justify-center text-white font-bold text-xl">
                            DW
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-gray-900">David Wilson</h4>
                            <p class="text-gray-500 text-sm">Site Supervisor</p>
                            <p class="text-purple-600 text-sm font-semibold">Prime Construction</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div class="text-center stat-card p-8 rounded-2xl shadow-lg card-hover">
                    <i class="fas fa-users text-white text-4xl mb-4"></i>
                    <h3 class="text-5xl font-bold text-white mb-2">100+</h3>
                    <p class="text-purple-100 font-medium">Trusted Vendors</p>
                </div>
                <div class="text-center stat-card p-8 rounded-2xl shadow-lg card-hover">
                    <i class="fas fa-smile text-white text-4xl mb-4"></i>
                    <h3 class="text-5xl font-bold text-white mb-2">500+</h3>
                    <p class="text-purple-100 font-medium">Happy Customers</p>
                </div>
                <div class="text-center stat-card p-8 rounded-2xl shadow-lg card-hover">
                    <i class="fas fa-tools text-white text-4xl mb-4"></i>
                    <h3 class="text-5xl font-bold text-white mb-2">1000+</h3>
                    <p class="text-purple-100 font-medium">Equipment Available</p>
                </div>
                <div class="text-center stat-card p-8 rounded-2xl shadow-lg card-hover">
                    <i class="fas fa-clock text-white text-4xl mb-4"></i>
                    <h3 class="text-5xl font-bold text-white mb-2">24/7</h3>
                    <p class="text-purple-100 font-medium">Customer Support</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-16">
        <div class="max-w-7xl mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
                <div>
                    <div class="flex items-center space-x-3 mb-4">
                        <div class="gradient-bg rounded-lg p-2">
                            <i class="fas fa-hard-hat text-white text-xl"></i>
                        </div>
                        <span class="text-2xl font-bold">EquipPoint</span>
                    </div>
                    <p class="text-gray-400 leading-relaxed mb-4">Your trusted partner in premium heavy equipment rental solutions. Building the future, one rental at a time.</p>
                    <div class="flex space-x-3">
                        <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-purple-600 rounded-full flex items-center justify-center transition">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-purple-600 rounded-full flex items-center justify-center transition">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-purple-600 rounded-full flex items-center justify-center transition">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-purple-600 rounded-full flex items-center justify-center transition">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </div>
                </div>
                <div>
                    <h4 class="text-lg font-bold mb-6">Quick Links</h4>
                    <ul class="space-y-3">
                        <li><a href="#home" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Home</a></li>
                        <li><a href="#features" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Features</a></li>
                        <li><a href="#equipment" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Equipment</a></li>
                        <li><a href="dashboard/contactUs.jsp" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Contact Us</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-lg font-bold mb-6">Services</h4>
                    <ul class="space-y-3">
                        <li><a href="#" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Equipment Rental</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Delivery Service</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>Maintenance</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-purple-400 transition flex items-center"><i class="fas fa-chevron-right text-xs mr-2"></i>24/7 Support</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-lg font-bold mb-6">Contact Info</h4>
                    <ul class="space-y-4">
                        <li class="flex items-start text-gray-400">
                            <i class="fas fa-envelope mt-1 mr-3 text-purple-400"></i>
                            <div>
                                <p class="text-sm text-gray-500">Email</p>
                                <a href="mailto:info@equippoint.com" class="hover:text-purple-400 transition">info@equippoint.com</a>
                            </div>
                        </li>
                        <li class="flex items-start text-gray-400">
                            <i class="fas fa-phone mt-1 mr-3 text-purple-400"></i>
                            <div>
                                <p class="text-sm text-gray-500">Phone</p>
                                <a href="tel:+15551234567" class="hover:text-purple-400 transition">+1 (555) 123-4567</a>
                            </div>
                        </li>
                        <li class="flex items-start text-gray-400">
                            <i class="fas fa-map-marker-alt mt-1 mr-3 text-purple-400"></i>
                            <div>
                                <p class="text-sm text-gray-500">Address</p>
                                <p>123 Equipment Street<br>New York, NY 10001</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="pt-8 border-t border-gray-800">
                <div class="flex flex-col md:flex-row justify-between items-center">
                    <p class="text-gray-400 text-sm mb-4 md:mb-0">
                        &copy; 2024 EquipPoint. All rights reserved. | 
                        <a href="#" class="hover:text-purple-400 transition">Privacy Policy</a> | 
                        <a href="#" class="hover:text-purple-400 transition">Terms of Service</a>
                    </p>
                    <p class="text-gray-400 text-sm">
                        <i class="fas fa-shield-alt text-purple-400 mr-2"></i>Secured with BCrypt Encryption
                    </p>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>