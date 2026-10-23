# 🛍️ FashionProject — Full-Stack E-Commerce Web Application

A full-stack, dynamic e-commerce platform developed using **Java Servlets, JSP, JDBC, and MySQL**. The application features robust customer shopping capabilities alongside a comprehensive administrative dashboard for inventory and order management.

---

## ✨ Key Features

### 🛍️ User Capabilities
- **User Authentication:** Secure registration, login, and session management.
- **Product Catalog:** Interactive browsing of products with search, category filtering, and price range filters.
- **Shopping Cart & Wishlist:** Dynamic item addition/removal, size selection, quantity adjustments, and live subtotal calculations.
- **Checkout & Order Placement:** Integrated checkout workflow with multiple payment options (COD, UPI, Credit Card).
- **Automated Email Notifications:** Sends instant order confirmation emails via JavaMail API upon successful checkout.
- **Order History:** Live tracking of past orders and fulfillment statuses (`PROCESSING`, `SHIPPED`, `DELIVERED`).

### 🛡️ Admin Dashboard
- **Storefront Analytics:** Overview of key business metrics including total revenue, total orders, active listings, and fulfillment queues.
- **Product Management:** Full CRUD operations (Add, Edit, View, Delete) for product inventory and stock availability.
- **Order Monitoring:** Real-time order fulfillment updates and customer delivery tracking.
- **Role-Based Access Control:** Role-based management for customer profiles and admin privileges.

---

## 🛠️ Tech Stack & Tools

| Layer | Technologies / Tools |
| :--- | :--- |
| **Backend** | Java Servlets, JSP, JDBC, JavaMail API |
| **Frontend** | HTML5, CSS3, JavaScript |
| **Database** | MySQL, MySQL Workbench |
| **Server & Build** | Apache Tomcat, Apache Maven |
| **IDE** | Eclipse IDE |

---

## 📁 Repository Structure

```text
FashionProject/
├── src/                  # Java source files (Servlets, Controllers, Models, DAOs)
├── WebContent/           # JSP files, CSS styling, images, and JS scripts
├── pom.xml               # Dependencies and build configuration
└── .classpath / .project # Project environment metadata
