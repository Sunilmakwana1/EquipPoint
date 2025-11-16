<%@ page import="static com.equip.point.util.AppConstant.LOGIN_ERROR" %>
<%@ page import="static com.equip.point.util.AppConstant.LOGOUT_ERROR" %>
<%@ page import="static com.equip.point.util.AppConstant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EquipPoint</title>
    <link rel="stylesheet" href="../src/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .animate-fade-in {
            animation: fadeIn 0.8s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
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
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .floating {
            animation: floating 3s ease-in-out infinite;
        }
        @keyframes floating {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-6xl flex bg-white rounded-3xl shadow-2xl overflow-hidden animate-fade-in">
        <!-- Left Side - Branding -->
        <div class="hidden lg:flex lg:w-1/2 gradient-bg p-12 flex-col justify-center items-center text-white relative overflow-hidden">
            <div class="absolute inset-0 opacity-10">
                <div class="absolute top-20 left-20 w-32 h-32 border-2 border-white rounded-full"></div>
                <div class="absolute bottom-20 right-20 w-48 h-48 border-2 border-white rounded-full"></div>
                <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-64 h-64 border-2 border-white rounded-full"></div>
            </div>
            <div class="relative z-10 text-center">
                <div class="floating mb-8">
                    <div class="bg-white bg-opacity-20 backdrop-blur-lg rounded-3xl p-8 inline-block">
                        <i class="fas fa-hard-hat text-8xl"></i>
                    </div>
                </div>
                <h2 class="text-4xl font-bold mb-4">Welcome Back!</h2>
                <p class="text-lg text-purple-100 mb-8">Access your EquipPoint dashboard and manage your equipment rentals</p>
                <div class="flex items-center justify-center space-x-4">
                    <div class="text-center">
                        <p class="text-3xl font-bold">1000+</p>
                        <p class="text-sm text-purple-200">Equipment</p>
                    </div>
                    <div class="w-px h-12 bg-white bg-opacity-30"></div>
                    <div class="text-center">
                        <p class="text-3xl font-bold">24/7</p>
                        <p class="text-sm text-purple-200">Support</p>
                    </div>
                    <div class="w-px h-12 bg-white bg-opacity-30"></div>
                    <div class="text-center">
                        <p class="text-3xl font-bold">500+</p>
                        <p class="text-sm text-purple-200">Customers</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="w-full lg:w-1/2 p-12 flex flex-col justify-center">
            <div class="max-w-md mx-auto w-full">
                <!-- Logo and Title -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center space-x-3 mb-4">
                        <div class="gradient-bg rounded-lg p-3">
                            <i class="fas fa-hard-hat text-white text-2xl"></i>
                        </div>
                        <span class="text-3xl font-bold gradient-text">EquipPoint</span>
                    </div>
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">Sign In</h1>
                    <p class="text-gray-600">Enter your credentials to access your account</p>
                </div>

                <!-- Alert Messages -->
                <% if (request.getAttribute(REGISTER_SUCCESS) != null) { %>
                <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded-lg mb-6">
                    <div class="flex items-center">
                        <i class="fas fa-check-circle text-green-500 mr-3"></i>
                        <p class="text-green-700 font-medium"><%= request.getAttribute(REGISTER_SUCCESS) %></p>
                    </div>
                </div>
                <% } %>
                
                <% if (request.getAttribute(LOGIN_ERROR) != null) { %>
                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg mb-6">
                    <div class="flex items-center">
                        <i class="fas fa-exclamation-circle text-red-500 mr-3"></i>
                        <p class="text-red-700 font-medium"><%= request.getAttribute(LOGIN_ERROR) %></p>
                    </div>
                </div>
                <% } %>
                
                <% if (request.getAttribute(LOGOUT_ERROR) != null) { %>
                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg mb-6">
                    <div class="flex items-center">
                        <i class="fas fa-exclamation-circle text-red-500 mr-3"></i>
                        <p class="text-red-700 font-medium"><%= request.getAttribute(LOGOUT_ERROR) %></p>
                    </div>
                </div>
                <% } %>

                <!-- Login Form -->
                <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/auth">
                    <div>
                        <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-2 text-purple-600"></i>Email Address
                        </label>
                        <input type="email" 
                               id="email"
                               name="email"
                               class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-purple-500 transition"
                               required
                               title="Enter your email"
                               placeholder="your.email@example.com">
                    </div>
                    
                    <div>
                        <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-lock mr-2 text-purple-600"></i>Password
                        </label>
                        <input type="password" 
                               id="password"
                               name="password"
                               class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-purple-500 transition"
                               required
                               title="Enter your password"
                               placeholder="Enter your password">
                        <p class="mt-2 text-xs text-gray-500">
                            <i class="fas fa-info-circle mr-1"></i>Password must be at least 8 characters with uppercase, lowercase, number, and special character
                        </p>
                    </div>
                    
                    <div class="flex items-center justify-between text-sm">
                        <a href="${pageContext.request.contextPath}/login/forgetEmail.jsp" class="text-purple-600 hover:text-purple-700 font-medium">
                            <i class="fas fa-question-circle mr-1"></i>Forgot email?
                        </a>
                        <a href="../login/forgetPassword.jsp" class="text-purple-600 hover:text-purple-700 font-medium">
                            <i class="fas fa-key mr-1"></i>Forgot password?
                        </a>
                    </div>
                    
                    <button type="submit" 
                            class="w-full gradient-bg text-white py-4 rounded-xl font-bold text-lg hover:shadow-2xl transition transform hover:scale-105">
                        <i class="fas fa-sign-in-alt mr-2"></i>Sign In
                    </button>
                </form>
                
                <!-- Sign Up Link -->
                <div class="mt-8 text-center">
                    <p class="text-gray-600">
                        Don't have an account? 
                        <a href="${pageContext.request.contextPath}/users/signUp.jsp" class="text-purple-600 hover:text-purple-700 font-bold">
                            Sign up <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </p>
                </div>

                <!-- Security Badge -->
                <div class="mt-6 text-center">
                    <p class="text-xs text-gray-500">
                        <i class="fas fa-shield-alt text-green-500 mr-1"></i>
                        Secured with BCrypt Encryption
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>