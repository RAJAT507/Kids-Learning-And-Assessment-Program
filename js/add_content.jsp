<%@ page import="com.jk.klap.dao.ContentDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Learning Content</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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

        .content-container {
            max-width: 700px;
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

        .btn-primary {
            width: 100%;
            background-color: #FFD700;
            border: none;
            color: #022C43;
            font-weight: 600;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #e6c200;
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.6);
        }

        .alert {
            text-align: center;
            border-radius: 10px;
            font-weight: 500;
        }

        .view-link {
            color: #00BFFF; /* DeepSkyBlue */
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s ease;
            display: inline-block;
            margin-top: 15px;
        }

        .view-link:hover {
            color: #ffffff;
            text-shadow: 0 0 10px #00BFFF;
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
    <%@include file="admin_navbar.jsp" %>

    <div class="main-wrapper">
        <div class="content-container">
            <h2>Add New Learning Content</h2>
            <form action="AddContentServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label>Select Category:</label>
                    <select name="categoryId" class="form-control" required>
                        <option value="">-- Select --</option>
                        <%
                            List<String[]> categories = ContentDAO.getAllCategories();
                            for(String[] cat : categories) {
                        %>
                        <option value="<%=cat[0]%>"><%=cat[1]%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Upload Image:</label>
                    <input type="file" name="image" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Text Content:</label>
                    <input type="text" name="textContent" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Volume Level:</label>
                    <select name="volumeLevel" class="form-control" required>
                        <option value="">-- Select Volume Level --</option>
                        <option value="Low">Low</option>
                        <option value="Medium">Medium</option>
                        <option value="High">High</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add Content</button>
            </form>

            <%
                if(request.getParameter("msg") != null){
                    if(request.getParameter("msg").equals("success")){
                        out.print("<div class='alert alert-success mt-3'>🎉 Content Added Successfully!</div>");
                    } else {
                        out.print("<div class='alert alert-danger mt-3'>⚠️ Failed to Add Content!</div>");
                    }
                }
            %>
          
        </div>
    </div>
</body>
</html>
