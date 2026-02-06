<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Payment | Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .payment-page {
            max-width: 600px;
            margin: 5rem auto;
            padding: 0 1rem;
        }
        .payment-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .payment-header {
            background: var(--primary-color);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .payment-header h2 { margin: 0; font-size: 1.5rem; }
        .payment-header p { margin: 0.5rem 0 0; opacity: 0.8; }
        
        .payment-body { padding: 2.5rem; }
        
        .order-summary {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }
        .summary-total {
            border-top: 1px solid #ddd;
            margin-top: 1rem;
            padding-top: 1rem;
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--primary-color);
        }
        
        .card-preview {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            height: 200px;
            border-radius: 15px;
            margin-bottom: 2rem;
            padding: 2rem;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            position: relative;
        }
        .card-chip {
            width: 45px;
            height: 35px;
            background: #ffcc00;
            border-radius: 5px;
        }
        .card-number { font-size: 1.5rem; letter-spacing: 4px; font-family: 'Courier New', monospace; }
        .card-holder { font-size: 0.9rem; text-transform: uppercase; }
        .card-expiry { font-size: 0.9rem; }
        
        .input-icon-group { position: relative; }
        .input-icon-group i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }
        .input-with-icon { padding-left: 2.8rem !important; }
        
        .btn-pay {
            width: 100%;
            height: 60px;
            font-size: 1.2rem;
            background: #28a745;
            color: white;
            border-radius: 50px;
            border: none;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s ease;
            margin-top: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }
        .btn-pay:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }
    </style>
</head>
<body style="background: var(--bg-color);">
    <jsp:include page="/components/header.jsp" />

    <div class="payment-page">
        <div class="payment-card">
            <div class="payment-header">
                <h2>Secure Checkout</h2>
                <p>Complete your reservation payment</p>
            </div>
            
            <div class="payment-body">
                <div class="order-summary">
                    <div class="summary-item">
                        <span>Reservation ID</span>
                        <span>#${reservation.id}</span>
                    </div>
                    <div class="summary-item">
                        <span>Check-in</span>
                        <span>${reservation.checkInDate}</span>
                    </div>
                    <div class="summary-item">
                        <span>Check-out</span>
                        <span>${reservation.checkOutDate}</span>
                    </div>
                    <div class="summary-total">
                        <span>Total to Pay</span>
                        <span>LKR ${reservation.totalAmount}</span>
                    </div>
                </div>

                <div class="card-preview">
                    <div class="card-chip"></div>
                    <div class="card-number" id="preview-number">•••• •••• •••• ••••</div>
                    <div style="display: flex; justify-content: space-between;">
                        <div class="card-holder">
                            <div style="font-size: 0.7rem; opacity: 0.7;">Card Holder</div>
                            <div id="preview-name">YOUR NAME</div>
                        </div>
                        <div class="card-expiry">
                            <div style="font-size: 0.7rem; opacity: 0.7;">Expires</div>
                            <div id="preview-expiry">MM/YY</div>
                        </div>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/pay" method="POST">
                    <input type="hidden" name="reservationId" value="${reservation.id}">
                    
                    <div class="form-group">
                        <label>Cardholder Name</label>
                        <div class="input-icon-group">
                            <i class="fas fa-user"></i>
                            <input type="text" class="form-control input-with-icon" placeholder="John Doe" required id="card-name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Card Number</label>
                        <div class="input-icon-group">
                            <i class="fas fa-credit-card"></i>
                            <input type="text" class="form-control input-with-icon" placeholder="0000 0000 0000 0000" maxlength="19" required id="card-number">
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label>Expiry Date</label>
                            <input type="text" class="form-control" placeholder="MM/YY" maxlength="5" required id="card-expiry">
                        </div>
                        <div class="form-group">
                            <label>CVV / CVC</label>
                            <input type="password" class="form-control" placeholder="•••" maxlength="3" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-pay">
                        <i class="fas fa-lock"></i>
                        Confirm Payment
                    </button>
                    
                    <p style="text-align: center; font-size: 0.8rem; color: #888; margin-top: 1.5rem;">
                        <i class="fas fa-shield-alt"></i> Your payment is protected with 256-bit SSL encryption
                    </p>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Simple interactive preview
        document.getElementById('card-name').addEventListener('input', function(e) {
            document.getElementById('preview-name').textContent = e.target.value.toUpperCase() || 'YOUR NAME';
        });

        document.getElementById('card-number').addEventListener('input', function(e) {
            let val = e.target.value.replace(/\D/g, '');
            let formatted = val.match(/.{1,4}/g)?.join(' ') || '•••• •••• •••• ••••';
            e.target.value = val.match(/.{1,4}/g)?.join(' ') || '';
            document.getElementById('preview-number').textContent = formatted;
        });

        document.getElementById('card-expiry').addEventListener('input', function(e) {
            let val = e.target.value.replace(/\D/g, '');
            if (val.length >= 2) val = val.substring(0,2) + '/' + val.substring(2);
            e.target.value = val;
            document.getElementById('preview-expiry').textContent = val || 'MM/YY';
        });
    </script>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
