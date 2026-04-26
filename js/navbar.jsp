<%@ page import="java.util.*, com.jk.klap.dao.ContentDAO" %>
<%
    String activePage = request.getRequestURI();
    List<String[]> categories = ContentDAO.getAllCategories();
%>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* ================= NAVBAR ================= */
.top-navbar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;    
    background: linear-gradient(to right, #ff9a9e, #fad0c4);
    padding: 12px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #fff;
    font-family: 'Segoe UI', sans-serif;
    font-size: 18px;
    font-weight: bold;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.top-navbar .button {
    margin: 0 6px;
    padding: 8px 14px;
    background-color: white;
    color: #e91e63;
    border: none;
    border-radius: 20px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
}

.top-navbar .button:hover {
    background-color: #f48fb1;
    color: white;
}

.top-navbar .btn-highlight {
    background-color: #e91e63;
    color: white;
    font-weight: bold;
}

/* ? SUPER COIN BUTTON */
.coin-btn {
    background: white;
    color: #5d4037 !important;
    font-weight: bold;
    border-radius: 25px;
    box-shadow: 0 0 10px rgba(255, 193, 7, 0.7);
    transition: all 0.3s ease;
}

.coin-btn:hover {
    transform: scale(1.08);
    box-shadow: 0 0 18px rgba(255, 193, 7, 1);
}

/* ================= SIDEBAR ================= */
.sidebar {
    width: 230px;
    height: 100vh;
    background: linear-gradient(180deg, #ffdde1, #ee9ca7);
    position: fixed;
    top: 60px;
    left: 0;
    padding-top: 15px;
    box-shadow: 4px 0 15px rgba(0, 0, 0, 0.15);
    overflow-y: auto;
}

/* Scrollbar */
.sidebar::-webkit-scrollbar {
    width: 6px;
}
.sidebar::-webkit-scrollbar-thumb {
    background: #f06292;
    border-radius: 10px;
}

/* Sidebar links */
.sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 18px;
    margin: 6px 10px;
    border-radius: 12px;
    color: #4a148c;
    text-decoration: none;
    font-weight: 600;
    background: rgba(255,255,255,0.4);
    transition: all 0.3s ease;
}

/* Hover */
.sidebar a:hover {
    background: #f06292;
    color: white;
    transform: translateX(6px);
}

/* Active */
.sidebar a.active {
    background: #e91e63;
    color: white;
    box-shadow: 0 4px 10px rgba(233, 30, 99, 0.4);
}

/* Sidebar title */
.sidebar-title {
    text-align: center;
    color: #880e4f;
    font-weight: bold;
    margin-bottom: 10px;
}

/* ================= MAIN CONTENT ================= */
.main-content {
    margin-left: 240px;
    padding: 80px 20px 20px 20px;
}
</style>

<!-- ? NAVBAR -->
<div class="top-navbar">
    <div>KLAP - Kids Learning & Assessment</div>

    <div>
        <!-- ? SUPER COINS -->
        <a href="usersupercoin.jsp" class="button coin-btn">
             Super Coins
        </a>

        <a href="select_category.jsp" 
           class="<%= activePage.contains("select_category.jsp") ? "button btn-highlight" : "button" %>">
           Tests
        </a>

        <a href="progress.jsp" 
           class="<%= activePage.contains("progress.jsp") ? "button btn-highlight" : "button" %>">
           Progress
        </a>

        <a href="results.jsp" 
           class="<%= activePage.contains("results.jsp") ? "button btn-highlight" : "button" %>">
           Results
        </a>

        <a href="logout.jsp" class="button" style="background:#e53935; color:white;">
            Logout
        </a>
    </div>
</div>

<!-- ? SIDEBAR -->
<div class="sidebar">

    <div class="sidebar-title">Categories</div>

    <% for(String[] cat : categories) { 
        String activeClass = "";
        String query = request.getQueryString();

        if(query != null && query.contains("categoryId=" + cat[0])) {
            activeClass = "active";
        }
    %>

        <a href="learning_content.jsp?categoryId=<%= cat[0] %>" 
           class="<%= activeClass %>">
            <%= cat[1] %>
        </a>

    <% } %>

</div>

<!-- ? MAIN CONTENT START -->
<div class="main-content">