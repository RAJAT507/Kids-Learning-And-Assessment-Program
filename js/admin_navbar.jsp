<%
    String activePage = request.getRequestURI();
%>

<!-- Google Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style>
/* ===== TOP NAVBAR ===== */
.top-navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 30px;
    background: rgba(2, 44, 67, 0.9);
    backdrop-filter: blur(10px);
    color: white;
    font-family: 'Poppins', sans-serif;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.logo {
    font-size: 20px;
    font-weight: 600;
    letter-spacing: 1px;
}

/* NAV BUTTONS */
.nav-links a {
    text-decoration: none;
    color: white;
    margin-left: 15px;
    padding: 10px 16px;
    border-radius: 10px;
    font-size: 14px;
    transition: 0.3s;
}

.nav-links a:hover {
    background: rgba(255,255,255,0.1);
    transform: translateY(-2px);
}

/* ACTIVE BUTTON */
.btn-highlight {
    background: linear-gradient(45deg, #FFD700, #ffcc00);
    color: #022C43 !important;
    font-weight: 600;
    box-shadow: 0 0 10px rgba(255, 215, 0, 0.6);
}

/* LOGOUT */
.logout {
    background: #f44336;
    color: white !important;
}

/* ===== SIDEBAR ===== */
.sidebar {
    position: fixed;
    top: 70px;
    left: 0;
    width: 240px;
    height: 100%;
    background: linear-gradient(180deg, #053F5E, #022C43);
    padding-top: 20px;
    font-family: 'Poppins', sans-serif;
    box-shadow: 3px 0 15px rgba(0, 0, 0, 0.4);
}

/* SIDEBAR LINKS */
.sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 20px;
    color: white;
    text-decoration: none;
    font-size: 15px;
    transition: 0.3s;
    border-left: 4px solid transparent;
}

.sidebar a:hover {
    background: rgba(255,255,255,0.08);
    border-left: 4px solid #FFD700;
    padding-left: 25px;
}

/* ACTIVE SIDEBAR */
.sidebar a.active {
    background: #FFD700;
    color: #022C43;
    font-weight: 600;
}

/* ICON STYLE */
.material-icons {
    font-size: 18px;
}

/* MOBILE */
@media (max-width: 768px) {
    .sidebar {
        width: 100%;
        position: relative;
        height: auto;
    }

    .top-navbar {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }

    .nav-links {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }
}
</style>

<!-- ===== NAVBAR ===== -->
<div class="top-navbar">
    <div class="logo"> KLAP Admin</div>

    <div class="nav-links">
        <a href="adminsupercoin.jsp"
           class="<%= activePage.contains("adminsupercoin.jsp") ? "btn-highlight" : "" %>">
             Supercoin
        </a>

        <a href="admin_navbar.jsp"
           class="<%= activePage.contains("admin_navbar.jsp") ? "btn-highlight" : "" %>">
             Dashboard
        </a>

        <a href="logout.jsp" class="logout">Logout</a>
    </div>
</div>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">

    <a href="add_category.jsp"
       class="<%= activePage.contains("add_category.jsp") ? "active" : "" %>">
        <span class="material-icons">category</span> Add Category
    </a>

    <a href="edit_category.jsp"
       class="<%= activePage.contains("edit_category.jsp") ? "active" : "" %>">
        <span class="material-icons">edit</span> Edit Category
    </a>

    <a href="add_content.jsp"
       class="<%= activePage.contains("add_content.jsp") ? "active" : "" %>">
        <span class="material-icons">menu_book</span> Learning Content
    </a>

    <a href="add_question.jsp"
       class="<%= activePage.contains("add_question.jsp") ? "active" : "" %>">
        <span class="material-icons">quiz</span> Test Questions
    </a>

    <a href="view_parents.jsp"
       class="<%= activePage.contains("view_parents.jsp") ? "active" : "" %>">
        <span class="material-icons">people</span> Users
    </a>

    <a href="ViewContentServlet"
       class="<%= activePage.contains("ViewContentServlet") ? "active" : "" %>">
        <span class="material-icons">visibility</span> View Content
    </a>

</div>