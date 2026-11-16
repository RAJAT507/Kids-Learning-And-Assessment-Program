# KLAP – Kids Learning and Assessment Program

**An Interactive Learning and Assessment Platform for Kids (Age 2–7)**

KLAP (Kids Learning and Assessment Program) is a web-based educational platform designed to make learning engaging and interactive for young children. It provides learning content, quizzes, assessments, and reward-based activities while allowing parents and administrators to access relevant features.

## 🌟 Key Features

### 👨‍💼 Admin Module
- Admin Login
- Add, Edit, Delete and Manage Categories
- Add, Edit, Delete and View Learning Content
- Manage Questions and Rewards
- Admin Reward Management

### 👨‍👩‍👧 Parent Module
- Parent Registration and Login
- Forgot Password and OTP-based verification
- Access Learning Content
- Participate in Tests and Assessments
- View Test Results
- Access Available Rewards
- Redeem Rewards

### 📚 Learning and Assessment
- Interactive learning content
- Audio learning support
- Question-based assessments
- Test submission and result management
- Reward-based learning experience

  
  ### 🪙 Coin & Premium Learning Module

- Children can earn coins through learning activities.
- Redeem earned coins.
- Use coins to unlock premium learning content.
- Generate PDF reports for parents showing coin usage and premium content unlocking details.

## 🛠️ Technologies Used

| Category | Technologies |
|---|---|
| Programming Language | Java |
| Backend | Java Servlets, JDBC |
| Frontend | HTML, CSS, JavaScript, JSP |
| Database | MySQL |
| Platform | Jakarta EE 10 |
| Email Service | Jakarta Mail, Gmail SMTP |
| File Handling | Java File I/O |
| PDF Library | iText PDF |
| Development IDE | NetBeans |
| Server | Apache Tomcat |

## 🏗️ Project Architecture

The project follows a layered structure using Java Beans, DAO classes, Servlets, JSP pages, and utility classes.

```text
Kids-Learning-And-Assessment-Program/
│
├── klap/
│   ├── bean/
│   │   ├── CategoryBean.java
│   │   ├── ContentBean.java
│   │   ├── ParentBean.java
│   │   ├── QuestionBean.java
│   │   └── TestResultBean.java
│   │
│   ├── dao/
│   │   ├── CategoryDAO.java
│   │   ├── ContentDAO.java
│   │   ├── ParentDAO.java
│   │   ├── QuestionDAO.java
│   │   └── TestResultDAO.java
│   │
│   ├── servlet/
│   │   ├── AdminLoginServlet.java
│   │   ├── ParentLoginServlet.java
│   │   ├── ParentRegisterServlet.java
│   │   ├── QuestionServlet.java
│   │   ├── SubmitTestServlet.java
│   │   └── ... other servlets
│   │
│   ├── utility/
│   │   ├── DBConnection.java
│   │   ├── EmailUtility.java
│   │   ├── FileUploadUtility.java
│   │   └── PDFUtility.java
│   │
│   └── resources/
│
├── css/
├── js/
│   └── JSP and frontend pages
│
└── index.html
```

## ⚙️ Project Setup

### Prerequisites
- Java Development Kit (JDK)
- Apache NetBeans IDE
- Apache Tomcat compatible with the project's Jakarta EE dependencies
- MySQL Server
- MySQL Workbench

### Installation Steps

1. Clone the repository:

```bash
git clone https://github.com/RAJAT507/Kids-Learning-And-Assessment-Program.git
```

2. Open the project in NetBeans.

3. Configure the MySQL database connection.

4. Create and configure the required database tables.

5. Configure the application server.

6. Build and deploy the project.

7. Open the application in your browser.

## 🔐 Security Note

Database and email credentials should be stored securely using environment variables or protected configuration files. Do not commit passwords or private credentials to a public repository.

## 🎯 Project Objective

The main objective of KLAP is to provide a child-friendly digital learning environment that combines educational content, assessments, and rewards to make early learning more engaging.

## 👨‍💻 Developer

**Rajat Warhade**

- GitHub: [RAJAT507](https://github.com/RAJAT507)
- LinkedIn: [Rajat Warhade](https://www.linkedin.com/in/rajat-warhade-14112244b/)

---

⭐ If you find this project interesting, consider giving it a star!

**KLAP – Making Learning Fun for Kids!**

