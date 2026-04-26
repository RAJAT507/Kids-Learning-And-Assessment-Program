<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ include file="navbar.jsp" %>

<%
    // ? Login check removed
    Integer parentId = (Integer) session.getAttribute("parent_id");

    // ? Safe fallback (important)
    if (parentId == null) {
        parentId = 1; // default/test user
    }

    int totalSupercoins = 0;
    int redeemedCoins = 0;
    int supercoinBalance = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/klap", "root", "root")) {

            // ? NULL safe query
            PreparedStatement ps1 = conn.prepareStatement(
                "SELECT COALESCE(SUM(supercoin_added),0) FROM test_results WHERE parent_id = ?");
            ps1.setInt(1, parentId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) totalSupercoins = rs1.getInt(1);

            PreparedStatement ps2 = conn.prepareStatement(
                "SELECT COALESCE(SUM(coins_used),0) FROM supercoin_redeem WHERE parent_id = ?");
            ps2.setInt(1, parentId);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) redeemedCoins = rs2.getInt(1);

            supercoinBalance = totalSupercoins - redeemedCoins;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Supercoins & Rewards</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
            font-family: 'Comic Sans MS', cursive, sans-serif;
        }

        .main-content {
            margin-left: 240px;
            margin-top: 70px;
            padding: 20px;
            height: calc(100vh - 70px);
            overflow-y: auto;
            background-color: #fef9f4;
        }

        .coin-card {
            background: linear-gradient(135deg, #d4f4fa, #fff3cd);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .super-text {
            font-size: 20px;
            color: #005f73;
        }

        .super-number {
            font-size: 42px;
            font-weight: bold;
            color: #ff7c43;
        }

        .reward-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .btn-primary {
            border-radius: 20px;
        }
    </style>
</head>

<body>

<div class="main-content">

    <% if (message != null) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- ? COIN CARD -->
    <div class="coin-card">
        <h2 class="text-success mb-4"> My Supercoins</h2>

        <div class="super-text">Total Earned</div>
        <div class="super-number mb-3"><%= totalSupercoins %></div>

        <div class="super-text">Redeemed</div>
        <div class="super-number mb-3"><%= redeemedCoins %></div>

        <div class="super-text">Available Balance</div>
        <div class="super-number text-success"><%= supercoinBalance %></div>
    </div>

    <!-- ? REWARDS -->
    <h4> Available Rewards</h4>

    <table class="table reward-table mt-3">
        <thead class="table-dark">
            <tr>
                <th>Reward</th>
                <th>Coins Required</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
            <tr>
                <td>Extra Practice Set</td>
                <td>2</td>
                <td>
                    <form action="RedeemServlet" method="post">
                        <input type="hidden" name="reward" value="Extra Practice Set">
                        <input type="hidden" name="required" value="2">
                        <button class="btn btn-primary"
                            <%= supercoinBalance >= 2 ? "" : "disabled" %>>
                            Redeem
                        </button>
                    </form>
                </td>
            </tr>

            <tr>
                <td>Certificate Print</td>
                <td>5</td>
                <td>
                    <form action="RedeemServlet" method="post">
                        <input type="hidden" name="reward" value="Certificate Print">
                        <input type="hidden" name="required" value="5">
                        <button class="btn btn-primary"
                            <%= supercoinBalance >= 5 ? "" : "disabled" %>>
                            Redeem
                        </button>
                    </form>
                </td>
            </tr>
        </tbody>
    </table>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>