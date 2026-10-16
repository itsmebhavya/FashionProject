<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Fashion Project</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 0; padding: 20px; }
        .container { max-width: 600px; background: white; padding: 30px; margin: auto; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2, h3 { color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #555; }
        input[type="text"], select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; font-weight: bold; }
        .btn-submit:hover { background-color: #218838; }
        .total-box { font-size: 18px; font-weight: bold; margin: 20px 0; color: #d9534f; }
        
        /* QR Code Scanner Box Styling */
        #upiScannerBox {
            display: none;
            background: #f1f8ff;
            border: 2px dashed #007bff;
            padding: 20px;
            text-align: center;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        #upiScannerBox img {
            width: 160px;
            height: 160px;
            margin-top: 10px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Secure Checkout</h2>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin-bottom: 15px; font-weight: bold;">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <h3>Delivery Address</h3>
        
        <div class="form-group">
            <label>Full Name:</label>
            <input type="text" name="deliveryName" value="${loggedInUser.name}" required>
        </div>

        <div class="form-group">
            <label>Phone Number:</label>
            <input type="text" name="deliveryPhone" value="${loggedInUser.phone}" required>
        </div>

        <div class="form-group">
            <label>Address Line 1:</label>
            <input type="text" name="deliveryAddressLine1" value="${loggedInUser.addressLine1}" required>
        </div>

        <div class="form-group">
            <label>Address Line 2 (Optional):</label>
            <input type="text" name="deliveryAddressLine2" value="${loggedInUser.addressLine2}">
        </div>

        <div class="form-group">
            <label>City:</label>
            <input type="text" name="deliveryCity" value="${loggedInUser.city}" required>
        </div>

        <div class="form-group">
            <label>State:</label>
            <input type="text" name="deliveryState" value="${loggedInUser.state}" required>
        </div>

        <div class="form-group">
            <label>Pincode:</label>
            <input type="text" name="deliveryPincode" value="${loggedInUser.pincode}" required>
        </div>

        <div class="form-group">
            <label>Country:</label>
            <input type="text" name="deliveryCountry" value="India" required>
        </div>

        <h3>Payment Method</h3>
        <div class="form-group">
            <select name="paymentMethod" id="paymentMethodSelect" onchange="toggleUpiScanner()">
                <option value="UPI">UPI</option>
                <option value="COD">Cash on Delivery</option>
                <option value="Credit Card">Credit Card</option>
            </select>
        </div>

        <!-- UPI QR Code Scanner & Transaction ID Box -->
        <div id="upiScannerBox">
            <p style="font-weight: bold; color: #0056b3; margin-bottom: 5px;">Scan QR Code to Pay via UPI</p>
            <p style="font-size: 13px; color: #555;">Use Google Pay, PhonePe, Paytm, or any UPI app</p>
            <!-- Using custom project placeholder VPA handle -->
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=160x160&data=upi://pay?pa=fashionproject@upi&pn=FashionProject&am=${cartTotal}&cu=INR" alt="UPI QR Code">
            <p style="font-size: 12px; color: #666; margin-top: 8px;">UPI ID: <b>fashionproject@upi</b></p>
            
            <div style="margin-top: 15px; text-align: left;">
                <label style="font-size: 13px; font-weight: bold; color: #333; margin-bottom: 5px;">UPI Transaction ID / UTR Number:</label>
                <input type="text" name="upiTransactionId" placeholder="Enter 12-digit UTR number after payment" style="width: 100%; padding: 9px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
            </div>
        </div>

        <div class="total-box">
            Total Amount: ₹${cartTotal}
        </div>

        <button type="submit" class="btn-submit">Place Order &amp; Send Notifications</button>
    </form>
</div>

<script>
    function toggleUpiScanner() {
        const paymentSelect = document.getElementById('paymentMethodSelect');
        const upiBox = document.getElementById('upiScannerBox');
        
        if (paymentSelect.value === 'UPI') {
            upiBox.style.display = 'block';
        } else {
            upiBox.style.display = 'none';
        }
    }

    window.onload = function() {
        toggleUpiScanner();
    };
</script>

</body>
</html>