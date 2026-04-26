<%@ page import="java.sql.*" %>
<%@ page import="com.jk.klap.utility.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("parent_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Object parentIdObj = session1.getAttribute("parent_id");
    int parentId = (parentIdObj instanceof Integer) ? (Integer) parentIdObj : Integer.parseInt(parentIdObj.toString());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Test Results</title>

    <!-- Bootstrap + Icons -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand&family=Fredoka+One&display=swap');

        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
            margin: 0;
        }

        /* ===== MAIN CONTENT FIX ===== */
        #main-content {
            margin-left: 200px; /* sidebar width */
            padding: 90px 30px 30px 30px; /* navbar height adjust */
        }

        /* CARD */
        .results-card {
            max-width: 1100px;
            margin: auto;
            background: #fff;
            border-radius: 30px;
            padding: 35px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            animation: fadeInUp 0.6s ease;
        }

        h2 {
            font-family: 'Fredoka One', cursive;
            text-align: center;
            color: #ff4d6d;
            margin-bottom: 20px;
        }

        .sub-text {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
        }

        table {
            border-radius: 20px;
            overflow: hidden;
        }

        thead {
            background: linear-gradient(135deg, #fcbf49, #ff9f1c);
            color: #000;
        }

        tr:hover {
            background-color: #fff4e6;
        }

        .badge-success {
            background: linear-gradient(135deg, #38b000, #70e000);
            padding: 7px 14px;
            border-radius: 20px;
        }

        .badge-secondary {
            background: linear-gradient(135deg, #adb5bd, #6c757d);
            padding: 7px 14px;
            border-radius: 20px;
        }

        .alert {
            border-radius: 20px;
            text-align: center;
            font-weight: bold;
        }

        /* MOBILE FIX */
        @media (max-width: 768px) {
            #main-content {
                margin-left: 0;
                padding: 80px 15px;
            }

            .results-card {
                padding: 20px;
            }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

    </style>
</head>

<body>

<%@ include file="navbar.jsp" %>

<div id="main-content">

    <div class="results-card">

        <h2>🎉 My Test Results 🎉</h2>
        <p class="sub-text">Track your child’s progress & performance</p>

        <%
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
            <div class="alert alert-info">
                <i class="fa-solid fa-circle-info"></i>
                <%= msg.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
            </div>
        <%
            }
        %>

        <div class="table-responsive">
            <table class="table table-bordered text-center table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Date</th>
                        <th>Category</th>
                        <th>Total</th>
                        <th>Correct</th>
                        <th>%</th>
                        <th>Supercoin</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        conn = DBConnection.getConnection();
                        ps = conn.prepareStatement(
                            "SELECT tr.*, c.category_name FROM test_results tr " +
                            "JOIN categories c ON tr.category_id = c.category_id " +
                            "WHERE tr.parent_id = ? ORDER BY tr.test_date DESC"
                        );
                        ps.setInt(1, parentId);
                        rs = ps.executeQuery();

                        int i = 1;
                        boolean hasResults = false;

                        while (rs.next()) {
                            hasResults = true;
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= rs.getTimestamp("test_date") %></td>
                        <td><%= rs.getString("category_name") %></td>
                        <td><%= rs.getInt("total_questions") %></td>
                        <td><%= rs.getInt("correct_answers") %></td>
                        <td><strong><%= rs.getDouble("percentage") %>%</strong></td>
                        <td>
                            <% if (rs.getInt("supercoin_added") == 1) { %>
                                <span class="badge badge-success">💰 Added</span>
                            <% } else { %>
                                <span class="badge badge-secondary">⏳ Pending</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                        }

                        if (!hasResults) {
                %>
                    <tr>
                        <td colspan="7">😔 No test results found</td>
                    </tr>
                <%
                        }

                    } catch (Exception e) {
                        out.println("<tr><td colspan='7'>Error loading results</td></tr>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (ps != null) ps.close(); } catch (Exception e) {}
                        try { if (conn != null) conn.close(); } catch (Exception e) {}
                    }
                %>
                </tbody>

            </table>
        </div>

    </div>

</div>

</body>
</html>