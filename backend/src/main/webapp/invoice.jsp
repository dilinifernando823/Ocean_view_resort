<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - ${invoice.invoiceNumber} | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <style>
        .invoice-container {
            max-width: 800px;
            margin: 4rem auto;
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 2rem;
            margin-bottom: 2rem;
        }
        .logo-section h1 {
            color: var(--primary-color);
            margin: 0;
            font-size: 2rem;
            letter-spacing: -1px;
        }
        .invoice-details { text-align: right; }
        .invoice-details h2 { margin: 0; color: #888; font-size: 1.2rem; }
        .invoice-details p { margin: 0.2rem 0; color: #333; font-weight: 600; }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }
        .info-block h4 {
            color: #888;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1px;
            margin-bottom: 0.8rem;
        }
        .info-block p { margin: 0.2rem 0; line-height: 1.4; }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        .invoice-table th {
            text-align: left;
            background: #f8f9fa;
            padding: 1rem;
            color: #555;
            font-weight: 600;
        }
        .invoice-table td {
            padding: 1.5rem 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .item-desc h5 { margin: 0 0 0.3rem; font-size: 1rem; color: var(--primary-color); }
        .item-desc span { font-size: 0.85rem; color: #888; }

        .invoice-footer {
            display: flex;
            justify-content: flex-end;
        }
        .total-box {
            width: 250px;
            background: var(--primary-color);
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            text-align: right;
        }
        .total-box p { margin: 0; opacity: 0.8; font-size: 0.9rem; }
        .total-box h3 { margin: 0.5rem 0 0; font-size: 1.8rem; }

        .btn-group {
            max-width: 800px;
            margin: 2rem auto;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        @media print {
            header, footer, .btn-group { display: none !important; }
            body { background: white !important; }
            .invoice-container { box-shadow: none; margin: 0; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body style="background: #f4f7f6;">
    <jsp:include page="/components/header.jsp" />

    <div class="btn-group">
        <button onclick="window.print()" class="btn btn-primary"><i class="fas fa-print"></i> Print Invoice</button>
        <a href="${pageContext.request.contextPath}/profile" class="btn" style="background: #eee; color: #333;"><i class="fas fa-arrow-left"></i> Back to Profile</a>
    </div>

    <div class="invoice-container">
        <div class="invoice-header">
            <div class="logo-section">
                <h1>OCEAN VIEW</h1>
                <p style="color: #666; font-size: 0.9rem;">Luxury Resort & Spa</p>
            </div>
            <div class="invoice-details">
                <h2>INVOICE</h2>
                <p># ${invoice.invoiceNumber}</p>
                <span style="color: #888; font-size: 0.8rem;">Date: <fmt:formatDate value="${invoice.invoicedAt}" pattern="MMM dd, yyyy" /></span>
            </div>
        </div>

        <div class="info-grid">
            <div class="info-block">
                <h4>From</h4>
                <p><strong>Ocean View Resort</strong></p>
                <p>123 Coastal Road</p>
                <p>Galle, Sri Lanka</p>
                <p>contact@oceanview.com</p>
            </div>
            <div class="info-block" style="text-align: right;">
                <h4>Bill To</h4>
                <p><strong>${sessionScope.user.fullName}</strong></p>
                <p>${sessionScope.user.email}</p>
                <p>${sessionScope.user.phone}</p>
                <p>${sessionScope.user.address}</p>
            </div>
        </div>

        <table class="invoice-table">
            <thead>
                <tr>
                    <th>Description</th>
                    <th style="text-align: right;">Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="item-desc">
                            <h5>Room Booking: ${room.roomName} (Room #${room.roomNumber})</h5>
                            <span>Check-in: <fmt:formatDate value="${res.checkInDate}" pattern="yyyy-MM-dd" /></span><br>
                            <span>Check-out: <fmt:formatDate value="${res.checkOutDate}" pattern="yyyy-MM-dd" /></span>
                        </div>
                    </td>
                    <td style="text-align: right; font-weight: 700;">LKR ${invoice.amount}</td>
                </tr>
            </tbody>
        </table>

        <div class="invoice-footer">
            <div class="total-box">
                <p>Total Amount Paid</p>
                <h3>LKR ${invoice.amount}</h3>
            </div>
        </div>

        <div style="margin-top: 4rem; text-align: center; color: #aaa; font-size: 0.85rem; border-top: 1px solid #f0f0f0; padding-top: 2rem;">
            <p>Thank you for choosing Ocean View Resort. We hope you enjoyed your stay!</p>
            <p style="margin-top: 0.5rem; font-weight: 600; color: var(--primary-color);">www.oceanviewresort.com</p>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
