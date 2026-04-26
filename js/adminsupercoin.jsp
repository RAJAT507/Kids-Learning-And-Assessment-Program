<%@ page import="java.sql.*, java.util.*" %>
<%
   
  

    Map<String, Integer> studentCoins = new LinkedHashMap<>();
    String errorMessage = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/klap", "root", "root");

        String query = "SELECT p.name, IFNULL(SUM(tr.supercoin_added), 0) AS totalCoins " +
                       "FROM parents p " +
                       "LEFT JOIN test_results tr ON p.parent_id = tr.parent_id " +
                       "GROUP BY p.parent_id " +
                       "ORDER BY totalCoins DESC";

        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String name = rs.getString("name");
            int coins = rs.getInt("totalCoins");
            studentCoins.put(name, coins);
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        errorMessage = e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Supercoin Report - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2 class="text-primary text-center">Supercoin Report</h2>

    <% if (errorMessage != null) { %>
        <div class="alert alert-danger text-center"><%= errorMessage %></div>
    <% } %>

    <table class="table table-bordered table-striped mt-4">
        <thead class="table-dark">
            <tr>
                <th>Parent Name</th>
                <th>Total Supercoins</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Map.Entry<String, Integer> entry : studentCoins.entrySet()) {
            %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td><%= entry.getValue() %></td>
                </tr>
            <%
                }
                if (studentCoins.isEmpty()) {
            %>
                <tr>
                    <td colspan="2" class="text-center text-muted">No records found</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
