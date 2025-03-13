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
            <h2 class="text-3xl font-bold text-blue-600">Reset Password?</h2>
            <p class="text-gray-600 mt-2">Enter your new password</p>
        </div>
        <div class=" <%= request.getAttribute("forgetPasswordSuccess") != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute("forgetPasswordSuccess") %></strong>
        </div>
        <div class=" <%= request.getAttribute("forgetPasswordError") != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
             role="alert">
            <strong class="font-bold"><%= request.getAttribute("forgetPasswordError") %></strong>
        </div>
        <form class="space-y-6" action="${pageContext.request.contextPath}/api/reset-password-user" method="POST" id="resetPassword" onsubmit="return validateForm(event)">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" id="email" name="email"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                          value="<%= request.getParameter("email") %>" readonly>
                <label for="password" class="block text-sm font-medium text-gray-700">New Password</label>
                <input type="password" id="password" name="password"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                       required>
                <p id="passwordError" class="text-red-500 text-sm mt-1 hidden">Password must be at least 8 characters long</p>
            </div>

            <div>
                <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm  Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                       required>
                <p id="confirmPasswordError" class="text-red-500 text-sm mt-1 hidden">Passwords do not match</p>
            </div>

            <button type="submit"
                    class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700
                               transition duration-300 font-medium">
                Reset Password
            </button>

            <div class="text-center">
                <a href="login/login.jsp" class="text-blue-600 hover:text-blue-800 text-sm">
                    Back to Login
                </a>
            </div>
        </form>
    </div>
</div>


<script>
    function validateForm(event) {
        event.preventDefault();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        let isValid = true;
        // Password validation
        if (password.length < 8) {
            document.getElementById('passwordError').classList.remove('hidden');
            isValid = false;
        } else {
            document.getElementById('passwordError').classList.add('hidden');
        }

        if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').classList.remove('hidden');
            isValid = false;
        } else {
            document.getElementById('confirmPasswordError').classList.add('hidden');
        }

        // If all validations pass, form can be submitted
        if (isValid) {
            document.getElementById('resetPassword').submit();
        }
    }
</script>
</body>
</html></div></body>