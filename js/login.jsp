<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            font-family: 'Quicksand', sans-serif;
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            font-family: 'Fredoka One', cursive;
            color: #ff4d6d;
            margin-bottom: 30px;
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
            font-size: 1rem;
            border: 2px solid #ffe3d8;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: #ff6b6b;
            box-shadow: 0 0 8px rgba(255, 107, 107, 0.4);
        }

        .btn-login {
            background: linear-gradient(to right, #ff4d6d, #fca311);
            border: none;
            color: white;
            padding: 12px;
            width: 100%;
            border-radius: 30px;
            font-size: 1.2rem;
            font-weight: 600;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-login:hover {
            transform: scale(1.05);
        }

        .bottom-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .btn-forgot, .btn-register {
            border-radius: 20px;
            font-weight: 600;
            padding: 10px 18px;
            font-size: 0.95rem;
        }

        .btn-forgot {
            background-color: #ffc107;
            color: black;
        }

        .btn-register {
            background-color: #00bfff;
            color: white;
        }

        .btn-forgot i, .btn-register i, .btn-login i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="login-box">
        <h2><i class="fas fa-user-circle"></i> Parent Login</h2>
        <form action="ParentLoginServlet" method="post">
            <div class="mb-3 text-start">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3 text-start">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn-login"><i class="fas fa-sign-in-alt"></i>Login</button>
        </form>

        <div class="bottom-buttons">
            <a href="forgot_password.jsp" class="btn btn-forgot"><i class="fas fa-key"></i>Forgot Password</a>
            <a href="parent_register.jsp" class="btn btn-register"><i class="fas fa-user-plus"></i>Register</a>
        </div>
    </div>
</div>
</body>
</html>
