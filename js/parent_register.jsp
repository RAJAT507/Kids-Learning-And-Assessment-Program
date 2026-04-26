<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Register</title>

    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
            font-family: 'Quicksand', sans-serif;
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            text-align: center;
        }

        h2 {
            font-family: 'Fredoka One', cursive;
            color: #ff4d6d;
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
            float: left;
            margin-bottom: 5px;
            color: #ff8c42;
        }

        .form-control {
            border-radius: 30px;
            padding: 12px 20px;
            border: 2px solid #ffe3d8;
            margin-bottom: 15px;
        }

        .btn-register-main {
            background: linear-gradient(to right, #ff4d6d, #fca311);
            border: none;
            color: white;
            padding: 12px;
            width: 100%;
            border-radius: 30px;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .bottom-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .btn-login {
            background-color: #00bfff;
            color: white;
        }

        .btn-forgot {
            background-color: #ffc107;
            color: black;
        }

        .msg {
            margin-top: 12px;
            font-weight: 600;
        }

        .success { color: green; }
        .error { color: red; }
        .warning { color: orange; }

    </style>
</head>

<body>

<div class="wrapper">
    <div class="register-box">

        <h2>👨‍👩‍👧 Parent Register</h2>

        <form action="ParentRegisterServlet" method="post">

            <div class="mb-3 text-start">
                <label>Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3 text-start">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3 text-start">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3 text-start">
                <label>Contact</label>
                <input type="text" name="contact" class="form-control" required>
            </div>

            <button type="submit" class="btn-register-main">
                Register
            </button>

        </form>

        <div class="bottom-buttons">
            <a href="login.jsp" class="btn btn-login">Login</a>
            <a href="forgot_password.jsp" class="btn btn-forgot">Forgot</a>
        </div>

        <!-- 🔥 MESSAGE SECTION -->
        <%
            String msg = request.getParameter("msg");
            if ("success".equals(msg)) {
        %>
            <p class="msg success">🎉 Registered Successfully!</p>

        <% } else if ("failed".equals(msg)) { %>
            <p class="msg error">❌ Registration Failed</p>

        <% } else if ("already".equals(msg)) { %>
            <p class="msg warning">⚠️ You are already registered with this email!</p>

        <% } %>

    </div>
</div>

</body>
</html>