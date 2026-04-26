57+8<%@page import="com.jk.klap.bean.QuestionBean"%>
<%@page import="com.jk.klap.utility.DBConnection"%>
<%@page import="com.jk.klap.dao.QuestionDAO"%>
<%@page import="java.sql.Connection"%>

<%
    int questionId = Integer.parseInt(request.getParameter("question_id"));
    int categoryId = Integer.parseInt(request.getParameter("category_id"));

   
    Connection con = DBConnection.getConnection();
    QuestionDAO dao = new QuestionDAO(con);
    QuestionBean q = dao.getQuestionById(questionId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            font-family: 'Poppins', sans-serif;
            color: #333;
        }

        .container-box {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
            border-radius: 16px;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        h2 {
            text-align: center;
            font-weight: bold;
            color: #203a43;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
        }

        .btn-primary {
            background-color: #203a43;
            border: none;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #2c5364;
            transform: scale(1.05);
        }

        .form-control:invalid {
            border-color: red;
        }
    </style>
</head>
<body>
    <%@ include file="admin_navbar.jsp" %>
    <div class="container-box">
        <h2>Edit Question</h2>
        <form action="QuestionServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="question_id" value="<%= q.getQuestionId() %>"/>
            <input type="hidden" name="category_id" value="<%= categoryId %>"/>

            <div class="mb-3">
                <label class="form-label">Question Text</label>
                <textarea class="form-control" name="question_text" required><%= q.getQuestionText() %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Option A</label>
                <input type="text" class="form-control" name="option_a" value="<%= q.getOptionA() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Option B</label>
                <input type="text" class="form-control" name="option_b" value="<%= q.getOptionB() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Option C</label>
                <input type="text" class="form-control" name="option_c" value="<%= q.getOptionC() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Option D</label>
                <input type="text" class="form-control" name="option_d" value="<%= q.getOptionD() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Correct Option</label>
                <select class="form-select" name="correct_option" required>
                    <option value="">--Select--</option>
                    <option value="A" <%= q.getCorrectOption().equals("A") ? "selected" : "" %>>A</option>
                    <option value="B" <%= q.getCorrectOption().equals("B") ? "selected" : "" %>>B</option>
                    <option value="C" <%= q.getCorrectOption().equals("C") ? "selected" : "" %>>C</option>
                    <option value="D" <%= q.getCorrectOption().equals("D") ? "selected" : "" %>>D</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Difficulty Level</label>
                <select class="form-select" name="difficulty_level" required>
                    <option value="">--Select--</option>
                    <option value="Easy" <%= q.getDifficultyLevel().equals("Easy") ? "selected" : "" %>>Easy</option>
                    <option value="Medium" <%= q.getDifficultyLevel().equals("Medium") ? "selected" : "" %>>Medium</option>
                    <option value="Hard" <%= q.getDifficultyLevel().equals("Hard") ? "selected" : "" %>>Hard</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Current Image</label><br/>
                <% if (q.getQuestionImage() != null && !q.getQuestionImage().isEmpty()) { %>
                    <img src="<%= q.getQuestionImage().replace(" ", "%20") %>" width="100" height="80" alt="Current Image"/>
                <% } else { %>
                    <span>No Image Uploaded</span>
                <% } %>
            </div>

            <div class="mb-3">
                <label class="form-label">Upload New Image (optional)</label>
                <input type="file" class="form-control" name="question_image" accept="image/*"/>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">Update Question</button>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            const correctOption = document.querySelector('select[name="correct_option"]').value;
            const difficulty = document.querySelector('select[name="difficulty_level"]').value;
            if (!correctOption || !difficulty) {
                alert("Please select both correct option and difficulty level.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>