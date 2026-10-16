package com.fashionproject.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class EmailUtil {
    
    // Background thread pool to ensure email sending doesn't block the checkout page
    private static final ExecutorService emailExecutor = Executors.newSingleThreadExecutor();

    // Pulls credentials securely from environment variables
    private static final String SENDER_EMAIL = System.getenv("FASHION_EMAIL");
    private static final String SENDER_PASSWORD = System.getenv("FASHION_EMAIL_PASS");

    public static void sendOrderConfirmationAsync(String recipientEmail, String orderId, double totalAmount) {
        // Safety check to prevent errors if environment variables are missing
        if (SENDER_EMAIL == null || SENDER_PASSWORD == null) {
            System.err.println("WARNING: Email credentials are not configured in environment variables.");
            return;
        }

        emailExecutor.submit(() -> {
            try {
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session session = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                    }
                });

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SENDER_EMAIL));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
                message.setSubject("Order Confirmed! - Fashion Project (#" + orderId + ")");
                message.setText("Thank you for shopping with Fashion Project!\n\n"
                        + "Your order #" + orderId + " has been successfully placed.\n"
                        + "Total Amount: ₹" + totalAmount + "\n\n"
                        + "We are currently processing your order and will notify you when it ships.");

                Transport.send(message);
                System.out.println("Async email sent successfully to " + recipientEmail);

            } catch (MessagingException e) {
                // Graceful failure handling so order processing is never blocked by email issues
                System.err.println("WARNING: Failed to send confirmation email to " + recipientEmail);
                e.printStackTrace();
            }
        });
    }
}