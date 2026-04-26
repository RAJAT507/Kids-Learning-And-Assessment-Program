package com.jk.klap.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/ForgotPasswordUnifiedServlet")
public class ForgotPasswordUnifiedServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/klap";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    // 👉 CHANGE THESE
    private static final String FROM_EMAIL = "internrajat@gmail.com";
    private static final String APP_PASSWORD = "exro lorq bnxn xwpf";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // ================= SEND OTP =================
            if ("sendOtp".equals(action)) {

                String email = request.getParameter("email");

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM parents WHERE email=?");
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    int otp = new Random().nextInt(900000) + 100000;

                    // save in session
                    session.setAttribute("otp", String.valueOf(otp));
                    session.setAttribute("email", email);
                    session.setAttribute("otpTime", System.currentTimeMillis());

                    // 🔥 SEND EMAIL
                    boolean sent = sendEmail(email, otp);

                    if (sent) {
                        out.print("otp_sent");
                    } else {
                        out.print("email_error");
                    }

                } else {
                    out.print("email_not_found");
                }
            }

            // ================= VERIFY OTP =================
            else if ("verifyOtp".equals(action)) {

                String userOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("otp");
                Long otpTime = (Long) session.getAttribute("otpTime");

                if (sessionOtp == null || otpTime == null) {
                    out.print("expired");
                    return;
                }

                long currentTime = System.currentTimeMillis();

                // ⏳ OTP valid for 2 min
                if ((currentTime - otpTime) > 120000) {
                    out.print("expired");
                    return;
                }

                if (sessionOtp.equals(userOtp)) {
                    out.print("otp_verified");
                } else {
                    out.print("invalid_otp");
                }
            }

            // ================= RESET PASSWORD =================
            else if ("resetPassword".equals(action)) {

                String email = request.getParameter("email");
                String newPassword = request.getParameter("newPassword");

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE parents SET password=? WHERE email=?");

                ps.setString(1, newPassword);
                ps.setString(2, email);

                int row = ps.executeUpdate();

                if (row > 0) {
                    session.removeAttribute("otp");
                    out.print("password_updated");
                } else {
                    out.print("error");
                }
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        }
    }

    // ================= EMAIL FUNCTION =================
    private boolean sendEmail(String toEmail, int otp) {

        try {
            Properties props = new Properties();

            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props,
                    new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                        }
                    });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject("KLAP Password Reset OTP");

            message.setText("Your OTP is: " + otp + "\nValid for 2 minutes.");

            Transport.send(message);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}