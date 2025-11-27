# 🎄 Pesebre WebApp – Christmas Nativity Web Application (JSP + Java + PostgreSQL)

Pesebre WebApp is a complete educational web application built with **JSP, Java, Apache Tomcat, and PostgreSQL**.  
It includes public modules, a dynamic gallery, a voting system for nativity scenes, a donation/support module, and a fully functional **admin panel** for managing users, events, nativity scenes, and audit logs.  
The project also integrates **GLB 3D models** for an enhanced visual experience.

---

## 🚀 Features Overview

### 🟢 Public Modules
- Home page  
- Christmas categories  
- Dynamic gallery (database-driven)  
- History/information section  
- 3D GLB model viewer  
- Nativity scene voting system  
- Donation/support system with cart-like behavior  
- Payment processing simulation  

### 🟠 Authentication
- User registration  
- User login  
- Session management  
- Logout  

### 🔴 Admin Panel
- Statistics dashboard  
- User management (CRUD)  
- Nativity scenes management (CRUD)  
- Christmas events management (CRUD)  
- System audit log (Bitácora) viewer  

---

## 🧱 Technologies Used

### Backend
- Java 8+  
- JSP (JavaServer Pages)  
- Apache Tomcat  
- PostgreSQL  
- JDBC (postgresql-42.7.8.jar)  

### Frontend
- HTML5  
- CSS3  
- Basic JavaScript  
- Embedded Java inside JSP pages  
- GLB 3D models  

### Tools
- Eclipse IDE  
- Git & GitHub  

---

## 📁 Project Structure

```
pesebre/
│
├── build/
│   └── classes/
│       ├── com/pesebre/datos/          # Database connection classes
│       ├── com/pesebre/seguridad/      # Security & authentication
│       ├── com/pesebre/visitante/      # Public modules (Gallery, Voting, Events)
│       └── com/pesebre/adm/            # Admin functionality
│
├── src/main/webapp/
│   ├── 3d/                              # GLB 3D models
│   ├── admin/                           # Admin JSP pages
│   ├── css/                             # Stylesheets
│   ├── WEB-INF/
│   │   └── lib/postgresql-42.7.8.jar    # PostgreSQL driver
│   ├── index.jsp
│   ├── categorias.jsp
│   ├── galeria.jsp
│   ├── historia.jsp
│   ├── login.jsp
│   ├── registro.jsp
│   ├── novenas.jsp
│   ├── pesebres.jsp
│   ├── votacion.jsp
│   ├── apoyo.jsp
│   └── pagos.jsp
│
└── .settings, .classpath, .project       # Eclipse configuration
```

---

## 🗄️ Database Structure (Summary)

The system uses PostgreSQL with a typical relational structure.  
Tables identified in the application:

- `tb_usuario`  
- `tb_perfil`  
- `tb_estadocivil`  
- `tb_pesebres`  
- `tb_novenas` (Christmas events)  
- `tb_galeria`  
- `tb_votaciones`  
- `tb_apoyos`  
- `tb_bitacora` (audit log)  

---

## ⚙️ How the System Works

### Public Side
1. Users browse galleries, categories, and 3D models.  
2. They can vote for nativity scenes.  
3. They can give donations (support system).  
4. Payments are simulated and recorded.  

### Authentication
- Login checks credentials in `tb_usuario`.  
- User session stored in memory.  
- Admin pages validate user profile/role.  

### Admin Panel
- CRUD modules interact with backend Java classes in `com.pesebre.adm`.  
- Admin dashboard shows statistics through SQL queries.  
- Actions may be logged inside the audit log table.  

---

## 🛠️ How to Run the Project

### Requirements
- Apache Tomcat 9+  
- Java 8+  
- PostgreSQL 13+  
- Eclipse IDE or VSCode (optional)  

### Setup
1. Create a PostgreSQL database.  
2. Import your SQL schema and tables.  
3. Update database credentials inside your connection class or config.  
4. Deploy project into `webapps/` folder or build a `.war` and deploy it.  

### Access URLs
```
http://localhost:8080/pesebre/
```

Admin Panel:
```
http://localhost:8080/pesebre/admin/admin.jsp
```

---

## 🎨 3D Models

Located under:
```
src/main/webapp/3d/
```

Included models:
- Angel  
- Christmas tree  
- Nativity scene  
- Santa Claus  
- Snowman  
- Star  
- Magi  
- Reindeer  
- More holiday models  

---

## 🧪 Manual Testing

- Test user login/registration  
- Verify CRUD operations in Admin panel  
- Test gallery loading from DB  
- Perform voting  
- Add/remove items in donation support  
- Process payment simulation  

---

## 📌 Purpose

This project was developed for **educational purposes**, demonstrating:
- JSP-based web development  
- Java + database integration  
- Basic admin panel architecture  
- Use of 3D models in web applications  

---

## 📄 License

This project is for educational use only.  
Feel free to explore, learn from it, or extend it.

