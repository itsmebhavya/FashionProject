package com.fashionproject.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    // Configure your email provider credentials securely using environment variables
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    
    // Safely pull from environment variables with safe fallbacks
    private static final String SENDER_EMAIL = System.getenv("GMAIL_USER") != null 
            ? System.getenv("GMAIL_USER") 
            : "your-real-email@gmail.com";
            
    private static final String SENDER_PASSWORD = System.getenv("GMAIL_APP_PASSWORD") != null 
            ? System.getenv("GMAIL_APP_PASSWORD") 
            : "your-16-digit-app-password";

    public static boolean sendEmail(String recipientEmail, String subject, String messageBody) {
        // 1. Set up SMTP server properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // Enable TLS
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        // 2. Create the Authenticator session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            // 3. Compose the message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Fashion Store Support"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setText(messageBody);

            // 4. Send the email
            Transport.send(message);
            System.out.println("Email successfully sent to " + recipientEmail);
            return true;

        } catch (Exception e) {
            System.err.println("Failed to send email to " + recipientEmail);
            e.printStackTrace();
            return false;
        }
    }
}