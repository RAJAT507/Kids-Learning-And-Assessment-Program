<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logging Out - KLAP</title>

    <!-- Auto Redirect -->
    <meta http-equiv="refresh" content="3;URL=index.html" />

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .logout-box {
            background: white;
            padding: 40px 50px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            width: 350px;
            animation: fadeIn 0.6s ease;
        }

        /* ICON */
        .logout-icon {
            font-size: 50px;
            margin-bottom: 10px;
            animation: bounce 1s infinite;
        }

        .logout-box h2 {
            color: #e91e63;
            margin-bottom: 10px;
        }

        .logout-box p {
            color: #555;
            font-size: 16px;
            margin-bottom: 25px;
        }

        /* PROGRESS BAR */
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #eee;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress {
            height: 100%;
            width: 0%;
            background: linear-gradient(90deg, #ff758c, #ff7eb3);
            animation: load 3s linear forwards;
        }

        /* SPINNER */
        .spinner {
            margin-top: 15px;
            width: 30px;
            height: 30px;
            border: 4px solid #eee;
            border-top: 4px solid #e91e63;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        /* ANIMATIONS */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes load {
            from { width: 0%; }
            to { width: 100%; }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes bounce {
            0%,100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }
    </style>
</head>

<body>

<div class="logout-box">

    <div class="logout-icon">🚪</div>

    <h2>Logging You Out...</h2>

    <p>Please wait while we securely log you out.</p>

    <!-- Progress bar -->
    <div class="progress-bar">
        <div class="progress"></div>
    </div>

    <!-- Spinner -->
    <div class="spinner"></div>

    <p style="margin-top:15px; font-size:14px; color:#888;">
        Redirecting to home page...
    </p>

</div>

</body>
</html>