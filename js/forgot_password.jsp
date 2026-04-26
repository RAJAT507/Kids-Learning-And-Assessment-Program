<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reset Password - KLAP</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg, #ff9a9e, #fad0c4);
    font-family: 'Poppins', sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
}

/* CARD */
.box {
    background: white;
    padding: 35px;
    border-radius: 20px;
    width: 100%;
    max-width: 380px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.2);
    text-align: center;
}

h2 {
    margin-bottom: 20px;
    color: #e91e63;
}

/* INPUT */
.form-control {
    border-radius: 12px;
    padding: 12px;
}

/* BUTTON */
.btn-main {
    width: 100%;
    border-radius: 25px;
    padding: 10px;
    background: #e91e63;
    color: white;
    border: none;
}

.btn-main:hover {
    background: #c2185b;
}

/* OTP BOX */
.otp-box {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
}

.otp-box input {
    width: 45px;
    height: 45px;
    text-align: center;
    font-size: 20px;
    border-radius: 10px;
    border: 1px solid #ccc;
}

.hidden {
    display: none;
}

.status {
    font-size: 14px;
    margin-top: 10px;
}

/* RESEND */
.resend {
    font-size: 13px;
    color: #e91e63;
    cursor: pointer;
    margin-top: 10px;
}

/* LOADER */
.loader {
    border: 4px solid #eee;
    border-top: 4px solid #e91e63;
    border-radius: 50%;
    width: 25px;
    height: 25px;
    animation: spin 1s linear infinite;
    margin: 10px auto;
    display: none;
}

@keyframes spin {
    100% { transform: rotate(360deg); }
}
</style>
</head>

<body>

<div class="box">

    <h2>? Reset Password</h2>

    <!-- EMAIL -->
    <input type="email" id="email" class="form-control mb-3" placeholder="Enter your email">

    <button class="btn btn-main" onclick="sendOtp()">Send OTP</button>

    <!-- LOADER -->
    <div class="loader" id="loader"></div>

    <!-- OTP -->
    <div id="otpSection" class="hidden">
        <div class="otp-box">
            <input maxlength="1">
            <input maxlength="1">
            <input maxlength="1">
            <input maxlength="1">
            <input maxlength="1">
            <input maxlength="1">
        </div>

        <button class="btn btn-outline-dark mt-3" onclick="verifyOtp()">Verify OTP</button>

        <div class="resend" onclick="sendOtp()">Resend OTP</div>
    </div>

    <!-- PASSWORD -->
    <div id="passwordSection" class="hidden">
        <input type="password" id="newPassword" class="form-control mt-3" placeholder="New Password">
        <input type="password" id="confirmPassword" class="form-control mt-3" placeholder="Confirm Password">

        <button class="btn btn-main mt-3" onclick="resetPassword()">Reset Password</button>
    </div>

    <div id="statusText" class="status"></div>

</div>

<script>

function showStatus(msg, color="black") {
    const el = document.getElementById("statusText");
    el.innerText = msg;
    el.style.color = color;
}

function showLoader(show) {
    document.getElementById("loader").style.display = show ? "block" : "none";
}

/* GET OTP VALUE FROM BOX */
function getOtp() {
    let inputs = document.querySelectorAll(".otp-box input");
    let otp = "";
    inputs.forEach(i => otp += i.value);
    return otp;
}

/* AUTO MOVE */
document.querySelectorAll(".otp-box input").forEach((input, index, arr) => {
    input.addEventListener("input", () => {
        if (input.value && index < arr.length - 1) {
            arr[index + 1].focus();
        }
    });
});

/* SEND OTP */
function sendOtp() {
    const email = document.getElementById("email").value;

    if (!email) {
        showStatus("Enter email ?", "red");
        return;
    }

    showLoader(true);
    showStatus("Sending OTP...", "blue");

    fetch("ForgotPasswordUnifiedServlet", {
        method: "POST",
        headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "action=sendOtp&email=" + encodeURIComponent(email)
    })
    .then(res => res.text())
    .then(data => {
        showLoader(false);

        if (data === "otp_sent") {
            showStatus("OTP sent to your email ?", "green");
            document.getElementById("otpSection").classList.remove("hidden");
        } else if (data === "email_error") {
            showStatus("Email sending failed ?", "red");
        } else {
            showStatus("Email not found ?", "red");
        }
    });
}

/* VERIFY OTP */
function verifyOtp() {
    const otp = getOtp();
    const email = document.getElementById("email").value;

    if (otp.length !== 6) {
        showStatus("Enter full OTP ?", "red");
        return;
    }

    showStatus("Verifying...", "blue");

    fetch("ForgotPasswordUnifiedServlet", {
        method: "POST",
        headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "action=verifyOtp&email=" + email + "&otp=" + otp
    })
    .then(res => res.text())
    .then(data => {
        if (data === "otp_verified") {
            showStatus("OTP verified ?", "green");
            document.getElementById("passwordSection").classList.remove("hidden");
        } else if (data === "expired") {
            showStatus("OTP expired ?", "red");
        } else {
            showStatus("Invalid OTP ?", "red");
        }
    });
}

/* RESET PASSWORD */
function resetPassword() {
    const email = document.getElementById("email").value;
    const pass = document.getElementById("newPassword").value;
    const confirm = document.getElementById("confirmPassword").value;

    if (!pass || !confirm) {
        showStatus("Fill all fields ?", "red");
        return;
    }

    if (pass !== confirm) {
        showStatus("Passwords do not match ?", "red");
        return;
    }

    showStatus("Updating password...", "blue");

    fetch("ForgotPasswordUnifiedServlet", {
        method: "POST",
        headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "action=resetPassword&email=" + email + "&newPassword=" + pass
    })
    .then(res => res.text())
    .then(data => {
        if (data === "password_updated") {
            showStatus("Password updated ?", "green");
            setTimeout(() => window.location.href="login.jsp", 1500);
        } else {
            showStatus("Error updating ?", "red");
        }
    });
}

</script>

</body>
</html>