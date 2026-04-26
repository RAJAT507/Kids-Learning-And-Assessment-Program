<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.jk.klap.bean.ContentBean" %>
<%
    ContentBean content = (ContentBean) request.getAttribute("content");
    List<String[]> categories = (List<String[]>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Content</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* === Floating effect for dropdown === */
        select.form-select {
            transition: all 0.3s ease-in-out;
            transform-origin: top;
        }

        select.form-select:focus {
            transform: scale(1.05);
            box-shadow: 0 0 12px rgba(251, 191, 36, 0.7);
            border-color: #fbbf24;
            outline: none;
        }

        select.form-select option:hover {
            background-color: #fde68a;
            color: #7c2d12;
            font-weight: bold;
        }

        /* === Your KLAP theme colors for form inputs === */
        body {
            background: #fff8f1;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #7a4f01;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(250, 170, 60, 0.3);
        }

        .card-header {
            background: linear-gradient(45deg, #fbbf24, #f59e0b);
            color: #4a2700;
            font-weight: 700;
            font-size: 1.5rem;
            border-radius: 12px 12px 0 0;
        }

        label {
            font-weight: 600;
            color: #b45309;
        }

        .form-control, .form-select {
            background-color: #fff8f1;
            border: 1.5px solid #fcd34d;
            color: #7a4f01;
            padding: 10px 14px;
            border-radius: 6px;
            transition: all 0.2s ease-in-out;
        }

        .form-control:focus, .form-select:focus {
            border-color: #fbbf24;
            box-shadow: 0 0 8px #fbbf24;
            background-color: #fff8f1;
        }

        .btn-success {
            width: 100%;
            font-weight: 700;
            font-size: 1.1rem;
            padding: 10px;
            border-radius: 8px;
            background: linear-gradient(45deg, #fbbf24, #f59e0b);
            border: none;
            color: #4a2700;
            box-shadow: 0 3px 10px rgba(251, 191, 36, 0.5);
            transition: all 0.3s ease-in-out;
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #f59e0b, #fbbf24);
            box-shadow: 0 5px 20px rgba(251, 191, 36, 0.8);
            color: #3a2100;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header">
            <h3>Edit Learning Content</h3>
        </div>
        <div class="card-body">
            <form action="ContentServlet" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="contentId" value="<%=content.getContentId()%>">
                <input type="hidden" name="oldImage" value="<%=content.getImagePath()%>">

                <div class="mb-3">
                    <label for="categoryId" class="form-label">Category:</label>
                    <select class="form-select" name="categoryId" id="categoryId" required>
                        <option value="">Select Category</option>
                        <% for(String[] cat : categories) { %>
                            <option value="<%=cat[0]%>" <%= (Integer.parseInt(cat[0]) == content.getCategoryId()) ? "selected" : "" %>>
                                <%=cat[1]%>
                            </option>
                        <% } %>
                    </select>
                    <div class="invalid-feedback">Please select a category.</div>
                </div>

                <div class="mb-3">
                    <label for="textContent" class="form-label">Text Content:</label>
                    <input type="text" class="form-control" id="textContent" name="textContent" value="<%=content.getTextContent()%>" required>
                    <div class="invalid-feedback">Text content is required.</div>
                </div>

                <div class="mb-3">
                    <label for="volumeLevel" class="form-label">Volume Level:</label>
                    <input type="text" class="form-control" id="volumeLevel" name="volumeLevel" value="<%=content.getVolumeLevel()%>" required>
                    <div class="invalid-feedback">Volume level is required.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Current Image:</label><br>
                    <img src="<%=content.getImagePath()%>" width="150" class="img-thumbnail">
                </div>

                <div class="mb-3">
                    <label for="uploads" class="form-label">Change Image:</label>
                    <input type="file" class="form-control" name="uploads" id="uploads">
                </div>

                <button type="submit" class="btn btn-success">Update Content</button>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Validation -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

</body>
</html>
