<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.jk.klap.bean.CategoryBean, com.jk.klap.dao.CategoryDAO" %>
<html>
<head>
    <title>View Categories - Admin Panel</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #022C43, #053F5E, #115173);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .main-wrapper {
            margin-left: 220px;
            padding: 40px 20px;
        }

        .table-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            animation: fadeUp 1s ease-in-out;
        }

        h2 {
            text-align: center;
            color: #022C43;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .btn-edit {
            background-color: #17a2b8;
            color: white;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
            font-weight: 500;
            border-radius: 8px;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .main-wrapper {
                margin-left: 0;
                padding: 20px 10px;
            }
        }
    </style>
</head>

<body>
<%@ include file="admin_navbar.jsp" %>

<div class="main-wrapper">
    <div class="table-container">
        <h2>All Categories</h2>

        <%
            List<CategoryBean> list = CategoryDAO.getAllCategories();
            if (list != null && !list.isEmpty()) {
        %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (CategoryBean cb : list) {
                %>
                <tr>
                    <td><%= cb.getCategoryId() %></td>
                    <td><%= cb.getCategoryName() %></td>
                    <td><%= cb.getCreatedAt() %></td>
                    <td>
                        <a href="edit_category.jsp?id=<%= cb.getCategoryId() %>" class="btn btn-edit btn-sm">Edit</a>
                        <a href="DeleteCategoryServlet?id=<%= cb.getCategoryId() %>" 
                           class="btn btn-delete btn-sm" 
                           onclick="return confirm('Are you sure you want to delete this category?');">
                           Delete
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <div class="alert alert-warning text-center">No categories found.</div>
        <%
            }
        %>

        <!-- Feedback messages -->
        <%
            String msg = request.getParameter("msg");
            if (msg != null) {
                if (msg.equals("deleted")) {
        %>
            <div class="alert alert-success mt-3 text-center">✅ Category deleted successfully!</div>
        <%
                } else if (msg.equals("fail")) {
        %>
            <div class="alert alert-danger mt-3 text-center">⚠️ Failed to delete category!</div>
        <%
                } else if (msg.equals("invalid")) {
        %>
            <div class="alert alert-warning mt-3 text-center">⚠️ Invalid category ID!</div>
        <%
                } else if (msg.equals("missing")) {
        %>
            <div class="alert alert-warning mt-3 text-center">⚠️ Category ID missing!</div>
        <%
                }
            }
        %>
    </div>
</div>
</body>
</html>
