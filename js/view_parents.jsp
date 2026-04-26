<%@ page import="java.sql.*, java.util.*, com.jk.klap.dao.*, com.jk.klap.bean.*, com.jk.klap.utility.DBConnection" %> 
<%
    Connection con = DBConnection.getConnection();
    ParentDAO dao = new ParentDAO(con);
    List<ParentBean> list = dao.getAllParents();
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Registered Parents</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #022C43, #053F5E, #115173);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: #022C43;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container-box {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-top: 40px;
            margin-left: 250px;
            width: calc(100% - 270px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            text-align: center;
            color: #022C43;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .table th {
            background-color: #053F5E;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: center;
        }

        @media (max-width: 768px) {
            .container-box {
                margin-left: 0;
                width: 100%;
                padding: 15px;
            }

            .table-responsive {
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <%@include file="admin_navbar.jsp" %>

    <div class="container-box">
        <h2>All Registered Parents</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Contact</th>
                    <!-- <th>Actions</th> -->
                </tr>
                </thead>
                <tbody>
                <% for(ParentBean p : list) { %>
                <tr>
                    <td><%= p.getParentId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getEmail() %></td>
                    <td><%= p.getPassword() %></td>
                    <td><%= p.getContact() %></td>
                    <!--
                    <td>
                        <a href="progress.jsp?parentId=<%= p.getParentId() %>" class="btn btn-sm btn-success">View Progress</a>
                    </td>
                    -->
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
