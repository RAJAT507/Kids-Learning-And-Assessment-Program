<%@ page import="com.jk.klap.bean.ContentBean" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>View Learning Content</title>
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

        .btn-primary {
            background-color: #053F5E;
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #022C43;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(2, 44, 67, 0.6);
        }

        .btn-danger {
            background-color: #D9534F;
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #C9302C;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(217, 83, 79, 0.6);
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
    <%@ include file="admin_navbar.jsp" %>

    <div class="container-box">
        <h2>Learning Content List</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Content ID</th>
                    <th>Category ID</th>
                    <th>Image</th>
                    <th>Text</th>
                    <th>Volume Level</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<ContentBean> contentList = (List<ContentBean>) request.getAttribute("contentList");
                    if(contentList != null && !contentList.isEmpty()) {
                        for(ContentBean c : contentList) {
                %>
                    <tr>
                        <td><%= c.getContentId() %></td>
                        <td><%= c.getCategoryId() %></td>
                        <td>
                            <% if(c.getImagePath() != null && !c.getImagePath().isEmpty()) { %>
                                <img src="<%= c.getImagePath() %>" width="100" height="80"/>
                            <% } else { %>
                                No Image
                            <% } %>
                        </td>
                        <td><%= c.getTextContent() %></td>
                        <td><%= c.getVolumeLevel() %></td>
                        <td>
                            <a href="ContentServlet?action=edit&content_id=<%= c.getContentId() %>" class="btn btn-primary btn-sm">Edit</a>
                            <a href="ContentServlet?action=delete&content_id=<%= c.getContentId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure to delete?')">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr><td colspan="6" class="text-center">No content found.</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
                <%
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    Integer totalPages = (Integer) request.getAttribute("totalPages");

                    if(currentPage == null) currentPage = 1;
                    if(totalPages == null) totalPages = 1;

                    for(int i = 1; i <= totalPages; i++) {
                        String active = (i == currentPage) ? "active" : "";
                %>
                    <li class="page-item <%= active %>">
                        <a class="page-link" href="ContentServlet?action=list&page=<%= i %>"><%= i %></a>
                    </li>
                <%
                    }
                %>
            </ul>
        </nav>
    </div>
</body>
</html>
