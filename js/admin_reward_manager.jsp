<%@ page import="java.sql.*" %>

<%
    String msg = request.getParameter("msg");
    try (var conn = DriverManager.getConnection("jdbc:mysql://localhost/klap","root","root")) {
        if ("delete".equals(request.getParameter("action"))) {
            PreparedStatement p = conn.prepareStatement("DELETE FROM rewards WHERE id=?");
            p.setInt(1, Integer.parseInt(request.getParameter("id"))); p.executeUpdate();
            response.sendRedirect("admin_reward_manager.jsp?msg=deleted"); return;
        }
    } catch(Exception e){ e.printStackTrace(); }
%>
<!DOCTYPE html><html><head>
    <title>Admin » Reward Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head><body><div class="container mt-4">
    <h2>Reward Manager</h2>
    <% if (msg!=null){ %><div class="alert alert-success"><%=msg%></div><% } %>

    <button class="btn btn-success mb-3" onclick="location.href='admin_reward_form.jsp'">Add Reward</button>
    <table class="table table-bordered">
        <thead><tr><th>Title</th><th>Coins</th><th>Actions</th></tr></thead><tbody>
        <%
        try (var conn = DriverManager.getConnection("jdbc:mysql://localhost/klap","root","root");
             var rs = conn.createStatement().executeQuery("SELECT * FROM rewards")) {
            while(rs.next()){ %>
            <tr>
                <td><%=rs.getString("title")%></td>
                <td><%=rs.getInt("coins_required")%></td>
                <td>
                    <a class="btn btn-sm btn-warning" href="admin_reward_form.jsp?id=<%=rs.getInt("id")%>">Edit</a>
                    <a class="btn btn-sm btn-danger" href="?action=delete&id=<%=rs.getInt("id")%>">Delete</a>
                </td>
            </tr>
        <% }} %>
        </tbody>
    </table>
</div></body></html>
