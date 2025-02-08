<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Ticket Detail</title>
    <link rel="stylesheet" href="../src/style.css">
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold mb-6 text-gray-800">Support Ticket Detail</h1>
        
        <form>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Ticket Number:</label>
                    <p id="ticketnumber" class="text-gray-900 text-lg">123456</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Full Name:</label>
                    <p id="fullName" class="text-gray-900 text-lg">John Doe</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Email:</label>
                    <p id="email" class="text-gray-900 text-lg">john.doe@example.com</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Message:</label>
                    <p id="message" class="text-gray-900 text-lg">This is a sample support ticket message.</p>
                </div>
                
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-gray-700 font-semibold mb-2">Approved Status:</label>
                    <div class="flex space-x-4">
                        <button type="button" id="approvedStatus" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Approve</button>
                        <button type="button" id="unapprovedStatus" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Unapprove</button>
                    </div>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Approved Date:</label>
                    <p id="approvedDate" class="text-gray-900 text-lg">N/A</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Approved By:</label>
                    <p id="approvedBy" class="text-gray-900 text-lg">N/A</p>
                </div>
                
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-gray-700 font-semibold mb-2">Reply Message:</label>
                    <textarea id="replyMessage" class="w-full p-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" rows="4"></textarea>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Reply Date:</label>
                    <p id="replyDate" class="text-gray-900 text-lg">N/A</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Replied By:</label>
                    <p id="repliedBy" class="text-gray-900 text-lg">N/A</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Replied Status:</label>
                    <p id="repliedStatus" class="text-gray-900 text-lg">N/A</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Progress Status:</label>
                    <button type="button" id="progressStatus" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">In Progress</button>
                </div>
                
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Created Date:</label>
                    <p id="createdDate" class="text-gray-900 text-lg">2023-10-01</p>
                </div>
            </div>
            
            <div class="flex justify-end mt-6">
                <button type="submit" id="saveButton" class="bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600">Save</button>
            </div>
        </form>
    </div>
</body>
</html>