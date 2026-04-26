<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jk.klap.dao.CategoryDAO" %>
<%@ page import="com.jk.klap.bean.CategoryBean" %>
<%
    String idStr = request.getParameter("id");
    int id = 0;
    CategoryBean bean = null;
    if(idStr != null) {
        id = Integer.parseInt(idStr);
        bean = CategoryDAO.getCategoryById(id);
    } else {
        response.sendRedirect("view_categories.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Category</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 80px; /* Adjust if your navbar is fixed */
        }
        .form-box {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .btn-yellow {
            background-color: #ffc107;
            color: #000;
        }
        .btn-yellow:hover {
            background-color: #e0a800;
            color: #fff;
        }
    </style>
</head>
<body>
    <%@ include file="admin_navbar.jsp" %>
    
    <div class="container">
        <div class="form-box mt-5">
            <h4 class="text-center mb-4">Edit Category</h4>
            <form action="EditCategoryServlet" method="post">
                <input type="hidden" name="categoryId" value="<%=bean.getCategoryId()%>">
                <div class="mb-3">
                    <label for="categoryName" class="form-label">Category Name</label>
                    <input type="text" name="categoryName" id="categoryName" class="form-control" required value="<%=bean.getCategoryName()%>">
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-yellow">Update Category</button>
                </div>
            </form>

            <%
                String msg = request.getParameter("msg");
                if(msg != null) {
                    if(msg.equals("updated")) {
            %>
                        <div class="alert alert-success mt-3 text-center">✅ Category Updated Successfully!</div>
            <%
                    } else if(msg.equals("fail")) {
            %>
                        <div class="alert alert-danger mt-3 text-center">⚠️ Failed to Update Category!</div>
            <%
                    }
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
