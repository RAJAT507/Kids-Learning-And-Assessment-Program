<%@page import="java.sql.*, java.util.*, com.jk.klap.utility.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer parentId = (Integer) session.getAttribute("parent_id");
    if (parentId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String> testDates = new ArrayList<>();
    List<Double> percentages = new ArrayList<>();
    List<String> categories = new ArrayList<>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT tr.test_date, tr.percentage, c.category_name " +
                     "FROM test_results tr " +
                     "JOIN categories c ON tr.category_id = c.category_id " +
                     "WHERE tr.parent_id = ? ORDER BY tr.test_date ASC";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, parentId);
        rs = ps.executeQuery();

        while (rs.next()) {
            Timestamp ts = rs.getTimestamp("test_date");
            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy").format(ts);
            testDates.add(formattedDate);
            percentages.add(rs.getDouble("percentage"));
            categories.add(rs.getString("category_name"));
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Progress Graph</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Quicksand&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            font-family: 'Quicksand', sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        h2 {
            font-family: 'Fredoka One', cursive;
            color: #ff4d6d;
            text-align: center;
            font-size: 2.8rem;
            margin-top: 30px;
        }

        .alert {
            border-radius: 20px;
            font-size: 1.1rem;
            font-weight: 600;
            text-align: center;
            margin-top: 20px;
            font-family: 'Fredoka One', cursive;
        }

        .btn-success {
            background: linear-gradient(145deg, #fca311, #ff4d6d);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 12px 25px;
            font-size: 1.3rem;
            font-weight: bold;
            box-shadow: 0 8px 0 #c73659;
            transition: 0.3s ease;
            display: inline-block;
            margin-top: 30px;
        }

        .btn-success:hover {
            background: linear-gradient(145deg, #ff4d6d, #fca311);
            transform: scale(1.05);
        }

        .btn-success:active {
            box-shadow: none;
            transform: scale(0.97);
        }

        .button-wrapper {
            text-align: center;
        }
    </style>
</head>
<body class="container">

    <h2>Your Test Progress</h2>

    <% if (testDates.isEmpty()) { %>
        <div class="alert alert-warning mt-4">No test results found to display progress.</div>
    <% } else { %>
        <canvas id="progressChart" width="800" height="400" style="margin: auto; display: block;"></canvas>

        <script>
            const ctx = document.getElementById('progressChart').getContext('2d');

            const labels = <%= testDates.toString().replace("[", "[\"").replace("]", "\"]").replace(", ", "\",\"") %>;
            const percentages = <%= percentages.toString() %>;
            const categories = <%= categories.toString().replace("[", "[\"").replace("]", "\"]").replace(", ", "\",\"") %>;

            const data = {
                labels: labels,
                datasets: [{
                    label: 'Test Percentage',
                    data: percentages,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1,
                    pointRadius: 6,
                    pointHoverRadius: 8,
                    pointBackgroundColor: 'rgb(54, 162, 235)'
                }]
            };

            const config = {
                type: 'line',
                data: data,
                options: {
                    responsive: true,
                    interaction: {
                        mode: 'nearest',
                        intersect: false,
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const idx = context.dataIndex;
                                    return [
                                        'Category: ' + categories[idx],
                                        'Percentage: ' + context.parsed.y + '%'
                                    ];
                                }
                            }
                        },
                        legend: {
                            display: true,
                            position: 'top',
                        }
                    },
                    scales: {
                        y: {
                            min: 0,
                            max: 100,
                            title: {
                                display: true,
                                text: 'Percentage (%)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Test Date'
                            }
                        }
                    }
                },
            };

            const progressChart = new Chart(ctx, config);
        </script>
    <% } %>

    <div class="button-wrapper">
        <a href="navbar.jsp" class="btn-success">← Back to Dashboard</a>
    </div>

</body>
</html>
