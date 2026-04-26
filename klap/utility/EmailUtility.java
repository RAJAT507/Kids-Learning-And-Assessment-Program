/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.utility;

/**
 *
 * @author Mahadev
 */
//package utility;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtility {

    public static boolean sendEmail(String toEmail, String subject, String messageText) {
        final String fromEmail = "internmahadev@gmail.com";
        final String password = "aizj pfdw lpjk hoob";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");  
        props.put("mail.smtp.port", "587");  
        props.put("mail.smtp.auth", "true");  
        props.put("mail.smtp.starttls.enable", "true");  

        Session session = Session.getInstance(props, new Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(messageText);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
 public static void sendOtp(String recipientEmail, String otp) throws MessagingException {
        // Your email credentials and SMTP config
        final String senderEmail = "internrajat@gmail.com";      // 🔁 Replace with your email
        final String senderPassword = "exro lorq bnxn xwpf";      // 🔁 Replace with your email password or app password
        final String smtpHost = "smtp.gmail.com";                 // e.g., Gmail SMTP server
        final int smtpPort = 587;                                 // TLS port

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", String.valueOf(smtpPort));

        // Create session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // Compose message
        Message message = new MimeMessage(session);

        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Your OTP for Password Reset - KLAP");
        message.setText("Dear User,\n\nYour OTP to reset your password is: " + otp +
                "\n\nThis OTP is valid for 5 minutes.\n\nRegards,\nKLAP Team");

        // Send message
        Transport.send(message);
        System.out.println("OTP sent successfully to: " + recipientEmail);
    }
}
 


