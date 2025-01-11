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
            <div class=" <%= request.getAttribute("forgetPasswordSuccess") != null ? "" : "hidden" %> bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
                 role="alert">
                <strong class="font-bold"><%= request.getAttribute("forgetPasswordSuccess") %></strong>
            </div>
            <div class=" <%= request.getAttribute("forgetPasswordError") != null ? "" : "hidden" %> bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
                 role="alert">
                <strong class="font-bold"><%= request.getAttribute("forgetPasswordError") %></strong>
            </div>
            <form class="space-y-6" action="/forget-password" method="post">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                    <input type="email" id="email" name="email" 
                           class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md 
                                  focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           required>
                </div>

                <div>
                    <label for="securityQuestion" class="block text-sm font-medium text-gray-700">Security Question</label>
                    <select id="securityQuestion" name="securityQuestion"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md
                                   focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required>
                        <option value="" disabled selected>Select a security question</option>
                    </select>
                </div>

                <div>
                    <label for="securityAnswer" class="block text-sm font-medium text-gray-700">Security Answer</label>
                    <input type="text" id="securityAnswer" name="securityAnswer"
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


    <script>

        document.addEventListener('DOMContentLoaded', function() {
            fetch('/api/security-questions')
                .then(response => response.json())
                .then(data => {
                    const select = document.getElementById('securityQuestion');
                    data.forEach(question => {
                        const option = document.createElement('option');
                        option.value = question;
                        option.textContent = question;
                        select.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching security questions:', error));
        });
    </script>
</body>
</html></div></body>