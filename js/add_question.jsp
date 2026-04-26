<%@page import="com.jk.klap.utility.DBConnection"%>
<%@page import="java.sql.*" %>
<%
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM categories");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            margin-left: 220px; /* For sidebar */
            padding: 40px 20px;
        }

        .admin-container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
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

        .form-control, .form-select {
            border-radius: 10px;
            font-size: 16px;
        }

        .btn-yellow {
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

        .btn-secondary {
            background-color: #0099cc;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #0077aa;
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(0, 153, 204, 0.5);
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

    <script>
        function viewQuestions() {
            const catId = document.getElementById('categorySelect').value;
            if (catId) {
                window.location.href = 'view_questions.jsp?category_id=' + catId;
            } else {
                alert("Please select a category.");
            }
        }
    </script>
</head>

<body>
<%@include file="admin_navbar.jsp" %>

<div class="main-wrapper">
    <div class="admin-container">
        <h2>Add New Question</h2>
        <form action="QuestionServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add"/>
            
            <div class="mb-3">
                <label>Category:</label>
                <select name="category_id" id="categorySelect" class="form-select" required>
                    <option value="">Select Category</option>
                    <% while (rs.next()) { %>
                        <option value="<%= rs.getInt("category_id") %>"><%= rs.getString("category_name") %></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label>Question Text:</label>
                <input type="text" name="question_text" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Question Image (optional):</label>
                <input type="file" name="question_image" class="form-control"/>
            </div>

            <div class="mb-3"><label>Option A:</label><input type="text" name="option_a" class="form-control" required/></div>
            <div class="mb-3"><label>Option B:</label><input type="text" name="option_b" class="form-control" required/></div>
            <div class="mb-3"><label>Option C:</label><input type="text" name="option_c" class="form-control" required/></div>
            <div class="mb-3"><label>Option D:</label><input type="text" name="option_d" class="form-control" required/></div>

            <div class="mb-3">
                <label>Correct Option:</label>
                <select name="correct_option" class="form-select" required>
                    <option value="">Select Correct Option</option>
                    <option value="A">Option A</option>
                    <option value="B">Option B</option>
                    <option value="C">Option C</option>
                    <option value="D">Option D</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Difficulty Level:</label>
                <select name="difficulty_level" class="form-select" required>
                    <option value="">Select Difficulty</option>
                    <option value="very_easy">Very Easy</option>
                    <option value="easy">Easy</option>
                    <option value="medium">Medium</option>
                    <option value="hard">Hard</option>
                    <option value="extreme">Extreme</option>
                    <option value="extreme_hard">Extreme Hard</option>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <button class="btn btn-yellow" type="submit">Add Question</button>
                <button type="button" class="btn btn-secondary" onclick="viewQuestions()">View Questions</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
