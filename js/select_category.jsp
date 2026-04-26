<%@ page import="java.util.*, com.jk.klap.dao.ContentDAO" %>
<%
    String activePage = request.getRequestURI();
    List<String[]> categories = ContentDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>KLAP - Select Category</title>

    <!-- Fonts & Bootstrap -->
    <link href="https://fonts.googleapis.com/css2?family=Comic+Neue:wght@400;700&family=Fredoka+One&family=Quicksand&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            font-family: 'Quicksand', sans-serif;
            position: relative;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* Top Navbar */
        .top-navbar {
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
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 60px;
            z-index: 1000;
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

        /* Sidebar */
        .sidebar {
            width: 200px;
            height: 100vh;
            background: linear-gradient(to bottom, #ffc1cc, #ffe4e1);
            position: fixed;
            top: 60px;
            left: 0;
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 2;
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            color: #880e4f;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s ease, color 0.3s ease;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #f06292;
            color: white;
            border-left: 5px solid #ad1457;
        }

        /* Main Content */
        .main-content {
            margin-left: 220px;
            padding: 100px 40px 40px 40px;
            position: relative;
            z-index: 3;
        }

        .main-box {
            background-color: #fff9f0;
            padding: 40px;
            border-radius: 30px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            margin: auto;
            animation: bounceIn 1s ease;
        }

        .main-box h3 {
            font-size: 28px;
            color: #ff4d6d;
            text-align: center;
            font-family: 'Fredoka One', cursive;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            color: #ff8c42;
            font-size: 1.1rem;
        }

        .form-select {
            border-radius: 25px;
            padding: 15px;
            font-size: 1rem;
            border: 2px solid #ffe3d8;
            background: #fffefb;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: #ff6b6b;
            box-shadow: 0 0 12px rgba(255, 107, 107, 0.4);
        }

        .btn-start {
            background: linear-gradient(145deg, #fca311, #ff4d6d);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 12px;
            font-size: 1.3rem;
            font-weight: bold;
            box-shadow: 0 8px 0 #c73659;
            transition: 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .btn-start:hover {
            background: linear-gradient(145deg, #ff4d6d, #fca311);
            transform: scale(1.05);
        }

        .btn-start:active {
            box-shadow: none;
            transform: scale(0.97);
        }

        /* Background Bubbles */
        .bg-bubbles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            overflow: hidden;
        }

        .bg-bubbles span {
            position: absolute;
            display: block;
            width: 60px;
            height: 60px;
            background: rgba(255, 195, 113, 0.4);
            border-radius: 50%;
            animation: floatUp 25s infinite;
            bottom: -100px;
        }

        .bg-bubbles span:nth-child(1) { left: 10%; animation-delay: 0s; }
        .bg-bubbles span:nth-child(2) { left: 20%; animation-delay: 2s; width: 80px; height: 80px; }
        .bg-bubbles span:nth-child(3) { left: 35%; animation-delay: 4s; }
        .bg-bubbles span:nth-child(4) { left: 50%; animation-delay: 0s; }
        .bg-bubbles span:nth-child(5) { left: 65%; animation-delay: 3s; width: 100px; height: 100px; }
        .bg-bubbles span:nth-child(6) { left: 80%; animation-delay: 5s; }

        @keyframes floatUp {
            0% { transform: translateY(0); opacity: 0.3; }
            50% { opacity: 0.7; }
            100% { transform: translateY(-1000px); opacity: 0; }
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.9); }
            100% { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>

<!-- Background Bubbles -->
<div class="bg-bubbles">
    <span></span><span></span><span></span>
    <span></span><span></span><span></span>
</div>

<!-- Top Navbar -->
<div class="top-navbar">
    <div>KLAP - Kids Learning & Assessment</div>
    <div>
        <a href="select_category.jsp" class="<%= activePage.contains("select_category.jsp") ? "button btn-highlight" : "button" %>">Tests</a>
        <a href="progress.jsp" class="<%= activePage.contains("progress.jsp") ? "button btn-highlight" : "button" %>">Progress</a>
        <a href="results.jsp" class="<%= activePage.contains("results.jsp") ? "button btn-highlight" : "button" %>">View Results</a>
        <a href="logout.jsp" class="button" style="background: #e53935; color: white;">Logout</a>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <% for(String[] cat : categories) { %>
        <a href="learning_content.jsp?categoryId=<%= cat[0] %>" class="<%= activePage.contains("categoryId=" + cat[0]) ? "active" : "" %>">
            <%= cat[1] %>
        </a>
    <% } %>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="main-box">
        <h3>Select a Category to Start Test</h3>
        <form action="test.jsp" method="get">
            <div class="mb-3">
                <label for="categoryId" class="form-label">Choose Category</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="">-- Select Category --</option>
                    <% for(String[] cat : categories) { %>
                        <option value="<%= cat[0] %>"><%= cat[1] %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn btn-start">Start Test</button>
        </form>
    </div>
</div>

</body>
</html>
