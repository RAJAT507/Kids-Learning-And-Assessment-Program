<%@ page import="java.util.*, java.sql.*" %>

<%
    String month = request.getParameter("month"); // format YYYY-MM
    String export = request.getParameter("export"); // "csv" or "pdf"
    List<Map<String,Object>> rows = new ArrayList<>();

    String dateFilter = "";
    if (month != null && month.matches("\\d{4}-\\d{2}")) {
        dateFilter = "WHERE DATE_FORMAT(tr.test_date,'%Y-%m') = ? OR DATE_FORMAT(sr.redeemed_at,'%Y-%m') = ?";
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/klap","root","root")) {
           String sql = 
    "SELECT p.name, " +
    "       IFNULL(SUM(tr.supercoin_added),0) AS earned, " +
    "       IFNULL(SUM(sr.coins_used),0) AS redeemed " +
    "FROM parents p " +
    "LEFT JOIN test_results tr ON p.parent_id=tr.parent_id " +
    "LEFT JOIN supercoin_redeem sr ON p.parent_id=sr.parent_id " +
    dateFilter + " " +
    "GROUP BY p.parent_id " +
    "ORDER BY earned - redeemed DESC";

               
            PreparedStatement ps = conn.prepareStatement(sql);
            if (!dateFilter.isEmpty()) {
                ps.setString(1, month);
                ps.setString(2, month);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                int e = rs.getInt("earned");
                int r = rs.getInt("redeemed");
                rows.add(Map.of("name",name,"earned",e,"redeemed",r,"balance", e-r));
            }
        }
    } catch(Exception e){ e.printStackTrace(); }

    if ("csv".equals(export)) {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition","attachment;filename=supercoin_summary.csv");
        out.write("Name, Earned, Redeemed, Balance\n");
        for(var r:rows){
            out.write(r.get("name")+","+r.get("earned")+","+r.get("redeemed")+","+r.get("balance")+"\n");
        }
        return;
    }
%>

<!DOCTYPE html>
<html><head>
    <title>Admin » Supercoin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head><body>
<div class="container mt-4">
    <h2>Supercoin Dashboard</h2>
    <form class="row g-3 mb-3">
        <div class="col-auto"><input type="month" name="month" value="<%=month!=null?month:""%>" class="form-control"></div>
        <div class="col-auto"><button class="btn btn-primary">Filter</button></div>
        <div class="col-auto"><a class="btn btn-secondary" href="?export=csv<%=month!=null?"&month="+month:""%>">Export CSV</a></div>
    </form>
    <table class="table table-hover">
        <thead><tr><th>Name</th><th>Earned</th><th>Redeemed</th><th>Balance</th></tr></thead>
        <tbody>
        <% for(var r:rows){ %>
            <tr><td><%=r.get("name")%></td>
                <td><%=r.get("earned")%></td>
                <td><%=r.get("redeemed")%></td>
                <td><%=r.get("balance")%></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body></html>
