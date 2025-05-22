<img src="https://github.com/user-attachments/assets/50b438b9-f926-462e-843f-6946bee7f095" width="300"/>

# EquipPoint
Equipment Rental System - Heavy Vehicle  A robust, production-ready web application designed for managing the rental of heavy vehicles and equipment. Built using Java, JSP, and Servlets with Tailwind CSS, this system streamlines the equipment rental process, ensuring efficiency, security, and reliability for both customers and administrators.

---

## Features:

*The application now features a modern, responsive UI and advanced security measures for a safe and seamless user experience.*

- **Enhanced Security**: Robust authentication system with password reset functionality and security questions. All sensitive data is encrypted in transit and at rest. Strict session management, CSRF protection, and input validation are enforced throughout the application. User roles and permissions are strictly managed to prevent unauthorized access.
- **Equipment Catalog**: Comprehensive listing of heavy vehicles with details like specifications, availability, and rental rates.
- **Real-Time Availability**: Check equipment availability and book instantly.
- **Booking Management**: Customers can book, view, and cancel rentals.
- **Admin Dashboard**: Manage inventory, bookings, and customer details.
- **Search and Filters**: Advanced search options for users to find specific equipment based on requirements.
- **Payment Integration**: Secure online payment gateway for hassle-free transactions.
- **Contact Us System**: Support ticket system for user inquiries with status tracking.
- **Vendor Management**: Add, edit, and manage equipment vendors.
- **User Management**: Comprehensive user profile management.
- **Comprehensive Error Handling**: Robust error handling for improved reliability.

---

## Technologies Used:

- **Backend**: Java, JSP, Servlets
- **Frontend**: HTML, CSS, JavaScript, Tailwind CSS
- **Database**: MySQL
- **Server**: Apache Tomcat
- **CI/CD**: GitHub Actions for automated build, test, and deployment
- **Build Tool**: Gradle

---

## Setup Instructions:

1. Clone the repository:
   ```bash
   https://github.com/Sunilmakwana1/EquipPoint.git
2. The steps are split into more detailed instructions, specific to both **Eclipse** and **IntelliJ IDEA**.
3. Database configuration assumes you have a running MySQL server, and details need to be updated in the `dbconfig` file.
4. The deployment steps for **Eclipse** and **IntelliJ IDEA** are clearly outlined, making it easier for users to follow along.
5. Make sure your local Apache Tomcat server is installed before proceeding.
6. Open the application in your browser at `http://localhost:8080/equip-point`.

---

## Recent Improvements

### Enhanced Security
- Implemented secure authentication with password hashing and salted credentials
- Added password reset functionality with security questions and email verification
- Secured all endpoints against unauthorized access using role-based access control
- Implemented input validation and output encoding to prevent injection and XSS attacks
- Enforced HTTPS for all communications
- Regular security audits and dependency updates

### UI/UX Refinements
- Migrated from Bootstrap to Tailwind CSS for a more modern, visually appealing interface
- Improved responsive design for seamless experience on all devices
- Enhanced navigation with clear menus, breadcrumbs, and feedback messages
- Consistent color scheme and typography for better readability
- Added loading indicators, modals, and tooltips for improved interactivity
- Streamlined booking and management workflows for faster user actions

### Error Handling
- Comprehensive error handling throughout the application
- User-friendly error messages
- Logging system for better debugging and monitoring
- Graceful degradation in case of failures

### CI/CD Pipeline
- Automated build process using GitHub Actions
- Integrated testing in the CI pipeline
- Automated deployment process
- Code quality checks and testing before deployment

The application is now production-ready with improved reliability, security, and user experience.
