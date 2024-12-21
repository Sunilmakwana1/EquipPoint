<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forget Password - EquipPoint</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-md w-96">
            <div class="text-center mb-8">
                <h2 class="text-3xl font-bold text-blue-600">Forgot Password?</h2>
                <p class="text-gray-600 mt-2">Enter your email to reset password</p>
            </div>

            <form class="space-y-6">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                    <input type="email" id="email" name="email" 
                           class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md 
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           required>
                </div>

                <button type="submit" 
                        class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 
                               transition duration-300 font-medium">
                    Reset Password
                </button>

                <div class="text-center">
                    <a href="login.jsp" class="text-blue-600 hover:text-blue-800 text-sm">
                        Back to Login
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html></div></body>