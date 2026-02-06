# Ocean View Resort - Management System

Ocean View Resort is a premium web-based hospitality management system designed for seamless room bookings, reservation management, and administrative oversight. The application features a stunning modern UI with glassmorphism aesthetics and a robust Java-based backend.

---

## 🚀 Technologies Used

### Frontend
- **JSP (JavaServer Pages):** Dynamic content rendering.
- **JSTL (JSP Standard Tag Library):** Logic handling within JSPs.
- **Vanilla CSS3:** Custom design system featuring:
  - Glassmorphism (Blurred glass effects).
  - Flexible Grid & Flexbox layouts.
  - Responsive Media Queries for all device sizes.
- **JavaScript (ES6+):** Interactive carousels, dynamic gallery switching, and validation.
- **Chart.js:** Real-time data visualization on the Admin Dashboard.
- **Font Awesome 6.4.0:** High-quality vector icons.
- **Google Fonts (Inter):** Clean, modern typography.

### Backend
- **Java 11:** Core programming language.
- **Java Servlets 4.0.1:** Handling HTTP requests and business logic.
- **Maven:** Project management and dependency handling.
- **Jakarta Mail (JavaMail):** Automated email notifications for reservations.
- **Gson:** JSON serialization and deserialization for API responses.
- **JUnit 5:** Unit testing framework.

### Database
- **MongoDB:** NoSQL database for flexible data storage for Rooms, Users, and Reservations.
- **MongoDB Java Driver Sync 4.11.1:** Secure database communication.

### Tools & Server
- **Apache Tomcat:** Web server for hosting the application.
- **Maven Tomcat Plugin:** Direct deployment from the terminal.

---

## 🛠️ Setup & Installation

Follow these steps to set up the project on your local machine.

### 1. Prerequisites
Ensure you have the following installed:
- **Java Development Kit (JDK) 11** or higher.
- **Apache Maven** (for dependency management).
- **MongoDB** (Local instance or Atlas connection string).
- **An IDE** (IntelliJ IDEA, Eclipse, or VS Code).

### 2. Database Configuration
1. Start your MongoDB server.
2. The application expects a connection string. Locate the database configuration (usually in a DAO utility class or properties file) and update it with your credentials:
   - Default: `mongodb://localhost:27017`
   - Database Name: `oceanview_db`

### 3. Clone the Project
```bash
git clone https://github.com/dilinifernando823/Ocean_view_resort.git
cd Ocean_view_resort/backend
```

### 4. Build the Project
Use Maven to download dependencies and compile the source code:
```bash
mvn clean install
```

### 5. Running the Application
You can run the application directly using the Maven Tomcat plugin:
```bash
mvn tomcat7:run
```
The server will start on port **8085**.

### 6. Accessing the UI
Open your browser and navigate to:
- **Home Page:** `http://localhost:8085/home`
- **Admin Dashboard:** `http://localhost:8085/admin/dashboard` (Requires admin login)
- **Staff Dashboard:** `http://localhost:8085/staff/dashboard` (Requires staff login)

---

## 📁 Project Structure

The project follows a standard Maven web application structure. Below is a detailed breakdown of the key directories and their contents:

```text
Ocean_view_resort/
├── backend/                        # Root of the Java Backend project
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/oceanview/ # Java source code
│   │   │   │   ├── dao/             # Data Access Objects (MongoDB interactions)
│   │   │   │   ├── model/           # POJO classes (Room, User, Reservation, etc.)
│   │   │   │   ├── servlet/         # Controller layer (Handling HTTP requests)
│   │   │   │   └── util/            # Utility classes (DB connection, Email helper)
│   │   │   └── webapp/              # Web application resources
│   │   │       ├── WEB-INF/         # Web configuration
│   │   │       ├── assets/          # Shared images, CSS (main.css), and JS
│   │   │       ├── components/      # Reusable JSP components (Header, Footer, Sidebar)
│   │   │       ├── admin/           # Admin-specific JSP views (Dashboards, Management)
│   │   │       ├── staff/           # Staff-specific JSP views (Operational tasks)
│   │   │       ├── index.jsp        # Main Landing Page template
│   │   │       ├── rooms.jsp        # Room listing page
│   │   │       ├── room-details.jsp # Individual room view with gallery
│   │   │       └── ...              # Other customer-facing pages (Login, Profile, etc.)
│   │   └── test/                    # Unit and integration tests
│   └── pom.xml                      # Maven project configuration
├── frontend/                       # Optional: Static HTML/Tailwind version (if applicable)
└── README.md                        # Project documentation
```

### Key Folder Explanations:
- **`dao/`**: Contains classes that use the MongoDB driver to perform CRUD operations on collections.
- **`servlet/`**: Acts as the controller. It receives requests, calls the appropriate DAO methods, and forwards data to the JSPs.
- **`webapp/admin/`**: Secured area for administrators to manage rooms, users, and view reports.
- **`webapp/components/`**: Modularized parts of the UI, such as the **Blurred Glass Header** and project-wide footer.
- **`assets/`**: Contains the project design system, including `main.css` which defines the glassmorphism aesthetic.

---

Developed with ❤️ for the Ocean View Resort Experience.
