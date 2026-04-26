<%@ page import="java.sql.*, java.util.*, com.jk.klap.dao.*, com.jk.klap.bean.*, com.jk.klap.utility.DBConnection" %>
<%
    Connection con = DBConnection.getConnection();
    QuestionDAO dao = new QuestionDAO(con);

    List<CategoryBean> categories = new ArrayList<>();
    Statement st = con.createStatement();
    ResultSet rsCat = st.executeQuery("SELECT * FROM categories");
    while (rsCat.next()) {
        CategoryBean c = new CategoryBean();
        c.setCategoryId(rsCat.getInt("category_id"));
        c.setCategoryName(rsCat.getString("category_name"));
        categories.add(c);
    }

    String catIdStr = request.getParameter("category_id");
    int catId = 0;
    if (catIdStr != null && !catIdStr.trim().isEmpty()) {
        catId = Integer.parseInt(catIdStr);
    } else if (!categories.isEmpty()) {
        catId = categories.get(0).getCategoryId();
    }

    List<QuestionBean> list = dao.getQuestionsByCategory(catId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Questions List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: #1b1b1b;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container-box {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(6px);
            border-radius: 16px;
            padding: 30px;
            margin-top: 40px;
            margin-left: 250px;
            width: calc(100% - 270px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            animation: fadeInUp 1s ease;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #0f2027;
            font-weight: 700;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
        }

        .table {
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .table th {
            background-color: #203a43;
            color: #fff;
            text-align: center;
            font-weight: 600;
        }

        .table td {
            text-align: center;
            vertical-align: middle;
            font-size: 15px;
            color: #333;
        }

        .table img {
            border-radius: 6px;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 5px 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #c82333;
            transform: scale(1.05);
            box-shadow: 0 0 8px rgba(220, 53, 69, 0.5);
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
            padding: 5px 12px;
            font-weight: 600;
            color: #000;
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            transform: scale(1.05);
            box-shadow: 0 0 8px rgba(255, 193, 7, 0.5);
        }

        select.form-select {
            max-width: 300px;
        }

        @media (max-width: 768px) {
            .container-box {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }

            .table-responsive {
                overflow-x: auto;
            }
        }
    </style>

    <script>
        function onCategoryChange() {
            const catId = document.getElementById('categorySelect').value;
            window.location.href = 'view_questions.jsp?category_id=' + catId;
        }
    </script>
</head>
<body>
    <%@ include file="admin_navbar.jsp" %>

    <div class="container-box">
        <h2>Questions</h2>

        <!-- Category Selector -->
        <div class="mb-4">
            <label for="categorySelect" class="form-label">Select Category:</label>
            <select id="categorySelect" class="form-select" onchange="onCategoryChange()">
                <% for (CategoryBean c : categories) { %>
                    <option value="<%= c.getCategoryId() %>" <%= (c.getCategoryId() == catId) ? "selected" : "" %>>
                        <%= c.getCategoryName() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Text</th>
                        <th>Image</th>
                        <th>Options</th>
                        <th>Correct</th>
                        <th>Difficulty</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(QuestionBean q : list) { %>
                    <tr>
                        <td><%= q.getQuestionId() %></td>
                        <td><%= q.getQuestionText() %></td>
                        <td>
                            <%
                                String imgPath = q.getQuestionImage();
                                if (imgPath != null && !imgPath.trim().isEmpty()) {
                            %>
                                <img src="<%= imgPath.trim().replace(" ", "%20") %>" width="80" height="60" alt="Image"/>
                            <%
                                } else {
                            %>
                                No Image
                            <%
                                }
                            %>
                        </td>
                        <td>
                            A: <%= q.getOptionA() %><br/>
                            B: <%= q.getOptionB() %><br/>
                            C: <%= q.getOptionC() %><br/>
                            D: <%= q.getOptionD() %>
                        </td>
                        <td><%= q.getCorrectOption() %></td>
                        <td><%= q.getDifficultyLevel() %></td>
                        <td>
                            <a href="QuestionServlet?action=delete&question_id=<%= q.getQuestionId() %>&category_id=<%= catId %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
                            <a href="edit_question.jsp?question_id=<%= q.getQuestionId() %>&category_id=<%= catId %>" class="btn btn-warning btn-sm">Edit</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
