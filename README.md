# SkyLand - Real Estate Management System
A real estate rental and sales website — supporting property search, listing management, and administration of buildings, apartments, and offices. Developed on the Spring Boot &amp; MySQL platform, featuring user role management, account control, and deposit transactions.

SkyLand is a real estate management system built with Spring Boot + Spring MVC + Spring Data JPA + Spring Security + JSP. The project supports managing buildings, customers, staff, orders, customer service (CSKH) history, and news, while also providing a public website for client access.
1. Main Features
- Login & Role Management
• Multi-role access control (Manager > Staff > User).
• Redirect based on role (via CustomSuccessHandler).
- Building Management
• Add / edit / delete buildings.
• Detailed information: name, address, area, price, description, etc.
• Filter/search by: name, city, district, type (TypeCode), status.
• Assign buildings to staff for management.
- Customer Management
• Add / edit / delete customers.
• Search customers by contact information.
• Link customers with orders and CSKH history.
• Assign customers to responsible staff.
- Order Management
• Manage deposit or purchase orders.
• Link orders to customers and buildings.
• Update order status (StatusOrder).
• Assign orders to responsible staff.
• Edit / delete orders.
- Account & Assignment Management
• View system user list.
• Add / edit / delete user accounts.
• Assign roles (MANAGER / STAFF / USER).
• Assign staff to manage customers, buildings, or orders.
- Transaction / Customer Care (CSKH)
• Record customer interaction history.
• Log activity details, updates, and responsible staff.
- News / Blog Management
- Security & Authorization
• Authentication using Spring Security.
• Role-based access control.
• Auto-redirect by user role upon login.

2. Technologies Used
• Backend: Java, Spring Boot, Spring MVC, JPA, Spring Data JPA, Spring Security, ModelMapper, Spring Profiles, Design Patterns
• Frontend: JSP, Bootstrap, CSS, JavaScript, jQuery, AJAX
• Database: MySQL (estateadvance)
• Other: Maven (build automation)

3. Project Structure (MVC Architecture)
src/
 ├── main/
 │   ├── java/com/ngimnee/
 │   │   ├── api/               # REST APIs for admin
 │   │   ├── controller/        # Controllers for web & admin
 │   │   ├── entity/            # Entities (Building, Customer, Order, User,…)
 │   │   ├── model/             # DTO, Request, Response
 │   │   ├── repository/        # Repository & RepositoryCustom
 │   │   ├── service/           # Service & Implementation
 │   │   ├── config/            # Security, JPA Auditing, ModelMapper, etc.
 │   │   └── security/          # Spring Security custom handlers
 │   ├── resources/
 │   │   ├── application.properties
 │   │   └── displaytag.properties
 │   └── webapp/
 │       ├── WEB-INF/views/
 │       │    ├── views/
 │       │    │ 	 ├── web/           # Web pages (home, list, contact,…)
 │       │    │	 ├── admin/         # Admin pages (building, customer,…)
 │       │    │	 └── login.jsp      # Login page
 │       │    ├── decorators.xml
 │       │    └── web.xml
 │       ├── common/
 │       └── decorators/
 └── test/

4. Setup & Run
4.1. System Requirements
• JDK: 17
• Maven: 3.6+
• MySQL: 5.7 or 8.0
• Apache Tomcat: 9.0+ (for WAR deployment)
• Recommended IDE: IntelliJ IDEA / Eclipse (enable Annotation Processing)
4.2. Database Configuration
      File: src/main/resources/application.properties
4.3. Run the Project
Option 1: Run with Maven
      mvn clean spring-boot:run
Option 2: Build WAR for Tomcat Deployment
      mvn clean package
Then deploy the generated WAR file:
      target/SkyLand.war → TOMCAT_HOME/webapps/
Option 3: Run in IntelliJ IDEA
• Configure Tomcat Server → Deployment → SkyLand:war exploded
• Set Context Path: /
• Run and open: http://localhost:8080/

5. Sample Accounts (Demo)
RoleUsernamePasswordMANAGERmanagertestmanagertestSTAFFadmintestadmintestUSERusertestusertest
6. Notes
• Ensure your database (estateadvance) is created before running.
• Enable Annotation Processing in your IDE for Lombok.
• If needed, you can allow JPA to generate the schema automatically:
• spring.jpa.hibernate.ddl-auto=update
• Layout management is handled using Sitemesh templates.

7. Author: ngimnee
