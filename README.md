# 🌊 Ocean View Resort – Hotel Management System

<div align="center">



**A full-stack web application for managing an Ocean View Resort, offering room browsing, booking, and administrative features.**


</div>

## 📖 Overview

The Ocean View Resort Application is a comprehensive web platform designed to streamline the operations of a modern resort. It provides a user-friendly interface for guests to browse various room types, view detailed amenities, and make reservations. On the administrative side, the application enables staff to efficiently manage room availability, handle bookings, and maintain guest information. Built with a robust backend and a dynamic frontend, this application aims to enhance both the guest experience and resort management efficiency.

## ✨ Features

🔐 User Authentication & Authorization
Secure login system requiring username and password with role-based access control (Admin, Staff, Customer). Session management ensures protected routes and secure dashboard access.

➕ Add New Reservation
Guests can create bookings by providing essential details including reservation number, guest information, selected room, check-in and check-out dates. All data is securely stored in MongoDB.

🔍 Display Reservation Details
Retrieve and display complete booking information for a specific reservation. Admin and staff users can view and manage reservation records efficiently.

💳 Automatic Bill Calculation
The system calculates total stay cost dynamically based on the number of nights and room category pricing. Billing logic ensures accurate cost computation.

🛏️ Room Management
Admin users can add, update, delete, and manage room availability, pricing, capacity, and amenities through a centralized dashboard.

📊 Admin Dashboard & Reports
Interactive dashboard with real-time statistics, including total bookings, available rooms, and revenue insights powered by Chart.js.

🔎 Search & Filtering System
Guests can search and filter rooms based on category, availability, pricing, and capacity to simplify booking decisions.

👤 Guest Information Management
Secure storage and retrieval of guest data for efficient reservation tracking and personalized service.

📖 Help & Guidance Section
Provides system usage guidelines to assist new staff members in navigating the reservation management workflow.

🚪 Secure Logout (Exit System)
Allows users to safely terminate sessions and exit the system securely, preventing unauthorized access.


## 🛠️ Tech Stack
### Frontend

![JSP](https://img.shields.io/badge/JSP-JavaServer%20Pages-red?style=for-the-badge)

![JSTL](https://img.shields.io/badge/JSTL-JSP%20Standard%20Tag%20Library-blue?style=for-the-badge)

![Vanilla CSS](https://img.shields.io/badge/Vanilla-CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

![Glassmorphism](https://img.shields.io/badge/Design-Glassmorphism-7FDBFF?style=for-the-badge)

![Flexbox & Grid](https://img.shields.io/badge/Layout-Flexbox%20%26%20Grid-FF6F61?style=for-the-badge)

![Responsive](https://img.shields.io/badge/Responsive-Media%20Queries-6A5ACD?style=for-the-badge)

![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

![Chart.js](https://img.shields.io/badge/Chart.js-Analytics-FF6384?style=for-the-badge&logo=chartdotjs&logoColor=white)

![Font Awesome](https://img.shields.io/badge/Font%20Awesome-6.4.0-339AF0?style=for-the-badge&logo=fontawesome&logoColor=white)

![Google Fonts](https://img.shields.io/badge/Google%20Fonts-Inter-4285F4?style=for-the-badge&logo=google&logoColor=white)

### Backend

![Java](https://img.shields.io/badge/Java-11-orange?style=for-the-badge&logo=java&logoColor=white )

![Servlet](https://img.shields.io/badge/Servlet-4.0.1-blue?style=for-the-badge)

![Maven](https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

![Jakarta Mail](https://img.shields.io/badge/Jakarta%20Mail-Email%20Service-007396?style=for-the-badge)

![Gson](https://img.shields.io/badge/Gson-JSON%20Library-4CAF50?style=for-the-badge)

![JUnit](https://img.shields.io/badge/JUnit-5-25A162?style=for-the-badge&logo=junit5&logoColor=white)

### Database

![MongoDB](https://img.shields.io/badge/MongoDB-4.x-47A248?style=for-the-badge&logo=mongodb&logoColor=white)

![MongoDB Java Driver](https://img.shields.io/badge/MongoDB%20Java%20Driver-4.11.1-4DB33D?style=for-the-badge&logo=mongodb&logoColor=white)

### Tools & Server

![Maven](https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-9.x-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)


## 🛠️ Setup & Installation

Follow these steps to set up the project on your local machine.

### 1. Prerequisites
Ensure you have the following installed:

Java Development Kit (JDK) 11 or higher.
Apache Maven (for dependency management).
MongoDB (Local instance or Atlas connection string).
An IDE (IntelliJ IDEA, Eclipse, or VS Code).

### 2. Database Configuration
Start your MongoDB server.
The application expects a connection string. Locate the database configuration (usually in a DAO utility class or properties file) and update it with your credentials:
Default: mongodb://localhost:27017
Database Name: dilini_ocean_view_resort

### 3. Clone the Project
git clone https://github.com/dilinifernando823/Ocean_view_resort.git
```
bash
cd Ocean_view_resort/backend
```
### 4. Build the Project
Use Maven to download dependencies and compile the source code:
```
bash
mvn clean install
```
### 5. Running the Application
You can run the application directly using the Maven Tomcat plugin:
```
bash
mvn tomcat7:run
```
The server will start on `localhost:8085`.

## 📁 Project Structure

```
Ocean_view_resort/
├── backend/                        # Java backend (Maven web project)
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/oceanview/ # Java source packages
│   │   │   │   ├── dao/            # Data Access Objects (MongoDB operations)
│   │   │   │   ├── model/          # POJOs (Room, User, Reservation, etc.)
│   │   │   │   ├── servlet/        # Servlets handling HTTP requests
│   │   │   │   └── util/           # Utility classes (DB connection, helpers)
│   │   │   └── webapp/             # Web resources
│   │   │       ├── WEB-INF/        # Deployment descriptors & config
│   │   │       ├── assets/         # CSS, JS, images
│   │   │       ├── components/     # Reusable JSP UI parts
│   │   │       ├── admin/          # Admin-specific JSP views
│   │   │       ├── staff/          # Staff-specific JSP pages
│   │   │       ├── index.jsp       # Landing page
│   │   │       ├── rooms.jsp       # List of rooms
│   │   │       ├── room-details.jsp# Room detail view
│   │   │       └── …               # Other frontend JSP pages
│   │   └── test/                   # Unit & integration tests
│   └── pom.xml                     # Maven project config
├── frontend/                       # [Optional] Static frontend (if used)
└── README.md                      # Project documentation

```


### Endpoints


#### User Management
-   `POST /api/users/register` - Register a new user.
-   `POST /api/users/login` - Log in a user and receive authentication token.
-   `GET /api/users/{id}` - Get user profile by ID (Admin/Self).
-   `PUT /api/users/{id}` - Update user profile by ID (Admin/Self).

#### Room Management
-   `GET /api/rooms` - Get all available rooms.
-   `GET /api/rooms/{id}` - Get details for a specific room.
-   `POST /api/rooms` - Add a new room (Admin only).
-   `PUT /api/rooms/{id}` - Update room details (Admin only).
-   `DELETE /api/rooms/{id}` - Delete a room (Admin only).

#### Booking Management
-   `GET /api/bookings` - Get all bookings (Admin) or user-specific bookings.
-   `POST /api/bookings` - Create a new booking.
-   `GET /api/bookings/{id}` - Get details for a specific booking.
-   `PUT /api/bookings/{id}` - Update booking status (Admin only).
-   `DELETE /api/bookings/{id}` - Cancel a booking.
## 🏗️ Architecture – MVC 3‑Tier
#### PRESENTATION LAYER
- JSP, JSTL, CSS, JS
- Input validation + sessions

#### CONTROLLER LAYER
- Servlets
- Routing + business logic orchestration

#### BUSINESS LOGIC LAYER
- Services, rules, validations
- Email notifications (Jakarta Mail)

#### DATA ACCESS LAYER
- MongoDB DAO classes
- MongoDB Driver Sync 4.11.1

## 🎨 Engineering Principles
### MVC Pattern

Model: POJO
View: JSP
Controller: Servlets

### SOLID Applied

- SRP: DAO only handles DB
- OCP: Add room categories without core changes
- LSP: Interchangeable DAO implementations
- ISP: Separate interfaces for entities
- DIP: Servlets depend on abstractions


## 📸 System Screenshots
### 🏠 Home Page – Glassmorphism UI
backend\src\main\webapp\assets\uploads\screenshots\home.png
### 📊 Admin Dashboard – Real-Time Analytics
backend\src\main\webapp\assets\uploads\screenshots\dashboard.png
### 🛏️ Room Details – Dynamic Rendering
backend\src\main\webapp\assets\uploads\screenshots\room-details.png
### Development Setup for Contributors
-   Ensure you have all [Prerequisites](#prerequisites) installed.
-   Follow the [Installation](#installation) and [Running](#running-the-backend) steps for both frontend and backend.



## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.





## 📞 Support & Contact

-   🐛 Issues: [GitHub Issues](https://github.com/dilinifernando823/Ocean_view_resort/issues)

📧 Email: [dilinifernando0823gmail.com] 

---

<div align="center">

**⭐ Star this repo if you find it helpful!**

Made with ❤️ by [dilinifernando823]

</div>