# LPU Fresh Check - Campus Food Ordering System 🍔

**LPU Fresh Check** is a dynamic web application designed for university campuses to streamline the food ordering process. It allows students to browse fresh food items from the canteen, view prices, add items to their cart, and place orders seamlessly.

## 🚀 Features

* **Student Authentication:**
    * Secure Sign Up & Login for students.
    * Session management to keep users logged in.
* **Smart Menu Catalog:**
    * View variety of food items (Snacks, Meals, Beverages).
    * Real-time availability status.
* **Food Cart System:**
    * Add favorite dishes to the cart.
    * Review total bill before ordering.
* **Order Processing:**
    * "Place Order" functionality for instant booking.
    * Order success confirmation screen.
    * Auto-clears cart after successful checkout.
* **Clean UI:** Responsive design for easy access on mobile and laptops.

## 🛠️ Tech Stack Used

* **Frontend:** HTML5, CSS3, JSP (JavaServer Pages).
* **Backend:** Java (JDK), Jakarta Servlets.
* **Server:** Apache Tomcat (v10+).
* **IDE:** Apache NetBeans / Eclipse.
* **Data Handling:** In-memory Data Provider (List-based architecture).

<img width="3200" height="2000" alt="Screenshot 2025-12-31 220550" src="https://github.com/user-attachments/assets/65fa90cf-02af-4b88-8da2-49f07ade00bf" />
<img width="1611" height="1245" alt="Screenshot 2025-12-31 220610" src="https://github.com/user-attachments/assets/de11b0be-4880-4fe6-8119-599b409c8b8c" />
<img width="3200" height="2000" alt="Screenshot 2025-12-31 220629" src="https://github.com/user-attachments/assets/3a3162d8-59b2-4ac6-b021-5e96ceac7d5f" />
<img width="3200" height="2000" alt="Screenshot 2025-12-31 220653" src="https://github.com/user-attachments/assets/c535e3bf-60f4-47ba-bb69-bbfcad09ec04" />
<img width="3200" height="2000" alt="Screenshot 2025-12-31 220705" src="https://github.com/user-attachments/assets/00f9f922-a4dc-4d75-b050-0d5b81b5f479" />
<img width="3200" height="2000" alt="Screenshot 2025-12-31 220724" src="https://github.com/user-attachments/assets/a1916937-949e-4302-bf3a-261e22d0aa63" />
<img width="3200" height="2000" alt="Screenshot 2025-12-31 220732" src="https://github.com/user-attachments/assets/a408011d-3531-4359-a7f4-0c174d55e680" />



## 📂 Project Structure

```bash
LPU_Fresh_Check/
├── src/main/java/com/lpu/servlets/
│   ├── AuthServlet.java       # Handles Student Login
│   ├── RegisterServlet.java   # Handles Student Registration
│   ├── CartServlet.java       # Manages Food Cart
│   ├── OrderServlet.java      # Handles Order Placement
│   ├── LogoutServlet.java     # Session Logout
│   └── ProductProvider.java   # Mock Menu Database
├── src/main/webapp/
│   ├── index.jsp              # Home Page (Menu)
│   ├── login.jsp              # Login Page
│   ├── signup.jsp             # Registration Page
│   ├── cart.jsp               # Cart Page
│   ├── order_success.jsp      # Order Confirmation
│   └── style.css              # Custom Styling
└── WEB-INF/
    └── web.xml                # Deployment Descriptor






