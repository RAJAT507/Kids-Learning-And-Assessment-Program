<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Category - Admin Panel</title>

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
            margin-left: 220px; /* leave space for sidebar */
            padding: 40px 20px;
        }

        .admin-container {
            max-width: 600px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            animation: fadeUp 1s ease-in-out;
        }

        h2 {
            text-align: center;
            color: #022C43;
            font-weight: 600;
            margin-bottom: 25px;
        }

        label {
            color: #053F5E;
            font-weight: 500;
        }

        .form-control {
            border-radius: 10px;
            font-size: 16px;
        }

        .btn-yellow {
            width: 100%;
            background-color: #FFD700;
            border: none;
            color: #022C43;
            font-weight: 600;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-yellow:hover {
            background-color: #e6c200;
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.6);
        }

        .alert {
            text-align: center;
            border-radius: 10px;
            font-weight: 500;
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
        <div class="admin-container">
            <h2>Add New Category</h2>
            <form action="AddCategoryServlet" method="post">
                <div class="mb-3">
                    <label for="categoryName">Category Name:</label>
                    <input type="text" name="categoryName" id="categoryName" class="form-control" placeholder="e.g. Alphabets, Numbers, Shapes" required>
                </div>
                <button type="submit" class="btn btn-yellow">Add Category</button>
            </form>

            <%
                String msg = request.getParameter("msg");
                if(msg != null) {
                    if(msg.equals("category_added")) {
            %>
                        <div class="alert alert-success mt-3">🎉 Category Added Successfully!</div>
            <%
                    } else if(msg.equals("fail")) {
            %>
                        <div class="alert alert-danger mt-3">⚠️ Failed to Add Category!</div>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
