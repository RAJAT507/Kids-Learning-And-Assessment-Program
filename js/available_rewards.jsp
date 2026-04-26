<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    int coins = Integer.parseInt(request.getParameter("coins"));
    try (var conn = DriverManager.getConnection("jdbc:mysql://localhost/klap","root","root")) {
        if (id>0) {
            PreparedStatement p = conn.prepareStatement("UPDATE rewards SET title=?,coins_required=? WHERE id=?");
            p.setString(1,title); p.setInt(2,coins); p.setInt(3,id); p.executeUpdate();
        } else {
            PreparedStatement p = conn.prepareStatement("INSERT INTO rewards(title,coins_required) VALUES(?,?)");
            p.setString(1,title); p.setInt(2,coins); p.executeUpdate();
        }
    } catch(Exception e){ e.printStackTrace(); }
    response.sendRedirect("admin_reward_manager.jsp?msg=saved");
%>
