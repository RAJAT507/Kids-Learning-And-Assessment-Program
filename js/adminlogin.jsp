<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - KLAP</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #022C43, #053F5E, #115173);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 22px;
            width: 420px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(12px);
            animation: fadeUp 0.8s ease-in-out;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #022C43;
            margin-bottom: 25px;
            font-size: 26px;
        }

        .input-group {
            position: relative;
            margin-bottom: 22px;
        }

        .input-group input {
            width: 100%;
            padding: 14px 12px;
            border: 2px solid #FFD700;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
            background: transparent;
        }

        .input-group label {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #777;
            font-size: 14px;
            pointer-events: none;
            transition: 0.3s;
            background: #fff;
            padding: 0 5px;
        }

        .input-group input:focus + label,
        .input-group input:valid + label {
            top: -8px;
            font-size: 12px;
            color: #022C43;
        }

        input:focus {
            border-color: #00c6ff;
            box-shadow: 0 0 8px rgba(0,198,255,0.5);
        }

        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 14px;
            color: #555;
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(45deg, #FFD700, #ffcc00);
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-weight: 600;
            color: #022C43;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            font-size: 16px;
        }

        .btn-login:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 215, 0, 0.7);
        }

        /* 🔥 BACK BUTTON STYLE */
        .btn-back {
            display: inline-block;
            margin-top: 14px;
            padding: 10px 18px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            color: #022C43;
            background: rgba(255, 255, 255, 0.7);
            border: 2px solid #FFD700;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: #FFD700;
            transform: translateY(-2px);
            box-shadow: 0 5px 12px rgba(255, 215, 0, 0.5);
        }

    </style>
</head>

<body>

<div class="login-container">

    <h2>Admin Login</h2>

    <form action="AdminLoginServlet" method="post">

        <div class="input-group">
            <input type="email" name="email" required>
            <label>Email Address</label>
        </div>

        <div class="input-group">
            <input type="password" name="password" id="password" required>
            <label>Password</label>
            <span class="password-toggle" onclick="togglePassword()">👁</span>
        </div>

        <input type="submit" value="Login" class="btn-login">

        <a href="ok.jsp" class="btn-back">← Back</a>

    </form>
</div>

<script>
function togglePassword() {
    var pwd = document.getElementById("password");
    pwd.type = (pwd.type === "password") ? "text" : "password";
}
</script>

<% if (request.getParameter("error") != null) { %>
<script>
    alert("❌ Sorry! Wrong credentials. Please try again.");
</script>
<% } %>

</body>
</html>