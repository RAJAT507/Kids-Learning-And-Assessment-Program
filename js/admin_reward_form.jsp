<%@ page import="java.sql.*, java.util.*" %>

<%
    String msg = request.getParameter("msg");

    // Handle deletion
    if ("delete".equals(request.getParameter("action"))) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/klap", "root", "root")) {
            PreparedStatement p = conn.prepareStatement("DELETE FROM rewards WHERE id=?");
            p.setInt(1, Integer.parseInt(request.getParameter("id")));
            p.executeUpdate();
            response.sendRedirect("admin_reward_form.jsp?msg=deleted");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Form loading logic (edit)
    int formId = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
    String title = ""; int coins = 0;
    if (formId > 0) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/klap", "root", "root")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM rewards WHERE id=?");
            ps.setInt(1, formId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                title = rs.getString("title");
                coins = rs.getInt("coins_required");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Handle save (add/update reward)
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submit") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        String formTitle = request.getParameter("title");
        int formCoins = Integer.parseInt(request.getParameter("coins"));
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/klap", "root", "root")) {
            if (id > 0) {
                PreparedStatement p = conn.prepareStatement("UPDATE rewards SET title=?, coins_required=? WHERE id=?");
                p.setString(1, formTitle);
                p.setInt(2, formCoins);
                p.setInt(3, id);
                p.executeUpdate();
            } else {
                PreparedStatement p = conn.prepareStatement("INSERT INTO rewards(title, coins_required) VALUES(?, ?)");
                p.setString(1, formTitle);
                p.setInt(2, formCoins);
                p.executeUpdate();
            }
            // ? Redirect to usersupercoin.jsp after save
            response.sendRedirect("usersupercoin.jsp?msg=saved");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin » Reward Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-4">
    <h2>Reward Manager</h2>
    <% if (msg != null) { %>
        <div class="alert alert-success"><%= msg %></div>
    <% } %>

    <ul class="nav nav-tabs" id="adminTab" role="tablist">
        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#list">All Rewards</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#form"><%= formId > 0 ? "Edit" : "Add" %> Reward</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#history">Redemption History</a></li>
    </ul>

    <div class="tab-content mt-3">
        <!-- Reward List -->
        <div class="tab-pane fade show active" id="list">
            <table class="table table-bordered">
                <thead>
                    <tr><th>Title</th><th>Coins</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <%
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/klap", "root", "root");
                         ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM rewards")) {
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getInt("coins_required") %></td>
                        <td>
                            <a class="btn btn-sm btn-warning" href="admin_rewards.jsp?id=<%= rs.getInt("id") %>#form">Edit</a>
                            <a class="btn btn-sm btn-danger" href="?action=delete&id=<%= rs.getInt("id") %>">Delete</a>
                        </td>
                    </tr>
                <%  }} catch(Exception e){ e.printStackTrace(); } %>
                </tbody>
            </table>
        </div>

        <!-- Reward Form -->
        <div class="tab-pane fade" id="form">
            <form method="post" action="usersupercoin.jsp#form">
                <input type="hidden" name="id" value="<%= formId %>"/>
                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input class="form-control" name="title" required value="<%= title %>"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Coins Required</label>
                    <input class="form-control" name="coins" type="number" required min="1" value="<%= coins %>"/>
                </div>
                <button class="btn btn-primary" name="submit"><%= formId > 0 ? "Update" : "Add" %></button>
            </form>
        </div>

        <!-- Redemption History -->
        <div class="tab-pane fade" id="history">
            <table class="table table-hover">
                <thead><tr><th>Parent</th><th>Reward</th><th>Coins Used</th><th>Date</th></tr></thead>
                <tbody>
                <%
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/klap", "root", "root");
                         ResultSet rs = conn.createStatement().executeQuery(
                             "SELECT p.name, sr.reward_name, sr.coins_used, sr.redeemed_at " +
                             "FROM supercoin_redeem sr " +
                             "JOIN parents p ON p.parent_id = sr.parent_id " +
                             "ORDER BY sr.redeemed_at DESC"
                         )) {
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString(1) %></td>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getInt(3) %></td>
                    <td><%= rs.getTimestamp(4) %></td>
                </tr>
                <%  }} catch (Exception e) { e.printStackTrace(); } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
