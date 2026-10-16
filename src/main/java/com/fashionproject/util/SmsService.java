package com.fashionproject.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class SmsService {

    // Background thread pool to ensure SMS sending doesn't block the checkout thread
    private static final ExecutorService smsExecutor = Executors.newSingleThreadExecutor();

    // Pulls credentials securely from environment variables
    private static final String ACCOUNT_SID = System.getenv("TWILIO_ACCOUNT_SID");
    private static final String AUTH_TOKEN = System.getenv("TWILIO_AUTH_TOKEN");
    private static final String TWILIO_PHONE = System.getenv("TWILIO_PHONE_NUMBER");

    public static void sendSmsAsync(String recipientPhone, String messageBody) {
        if (ACCOUNT_SID == null || AUTH_TOKEN == null || TWILIO_PHONE == null) {
            System.err.println("WARNING: Twilio SMS credentials are not configured in environment variables.");
            return;
        }

        smsExecutor.submit(() -> {
            try {
                String urlStr = "https://api.twilio.com/2010-04-01/Accounts/" + ACCOUNT_SID + "/Messages.json";
                URL url = URI.create(urlStr).toURL();
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);

                // Basic Authentication encoding for Twilio
                String authString = ACCOUNT_SID + ":" + AUTH_TOKEN;
                String encodedAuth = Base64.getEncoder().encodeToString(authString.getBytes(StandardCharsets.UTF_8));
                conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                // Format form data parameters
                String data = "To=" + java.net.URLEncoder.encode(recipientPhone, StandardCharsets.UTF_8) +
                              "&From=" + java.net.URLEncoder.encode(TWILIO_PHONE, StandardCharsets.UTF_8) +
                              "&Body=" + java.net.URLEncoder.encode(messageBody, StandardCharsets.UTF_8);

                try (OutputStream os = conn.getOutputStream()) {
                    os.write(data.getBytes(StandardCharsets.UTF_8));
                }

                int responseCode = conn.getResponseCode();
                if (responseCode == HttpURLConnection.HTTP_CREATED || responseCode == HttpURLConnection.HTTP_OK) {
                    System.out.println("Async SMS sent successfully to " + recipientPhone);
                } else {
                    try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
                        StringBuilder response = new StringBuilder();
                        String responseLine;
                        while ((responseLine = br.readLine()) != null) {
                            response.append(responseLine.trim());
                        }
                        System.err.println("WARNING: Failed to send SMS. Response Code: " + responseCode + " | Error: " + response.toString());
                    }
                }
            } catch (Exception e) {
                System.err.println("WARNING: Exception occurred while sending SMS to " + recipientPhone);
                e.printStackTrace();
            }
        });
    }
}