<%-- 
    Document   : delete_category
    Created on : 29 May 2025, 4:52:30 pm
    Author     : P92
--%>

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
<html>
<head>
    <title>Delete Category</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="admin_navbar.jsp" %>
    <div class="main-wrapper">
        <div class="admin-container">
            <h2>Delete Category</h2>
            <p>Are you sure you want to delete the category: <strong><%=bean.getCategoryName()%></strong>?</p>
            <form action="DeleteCategoryServlet" method="post">
                <input type="hidden" name="categoryId" value="<%=bean.getCategoryId()%>">
                <button type="submit" class="btn btn-danger">Yes, Delete</button>
                <a href="view_categories.jsp" class="btn btn-secondary">Cancel</a>
            </form>
            <%
                String msg = request.getParameter("msg");
                if(msg != null && msg.equals("fail")) {
            %>
                <div class="alert alert-danger mt-3">⚠️ Failed to Delete Category!</div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>

