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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <style>
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, .15);
            font-size: 16px;
            line-height: 24px;
            color: #555;
            background: #fff;
            border-radius: 10px;
        }
        .invoice-box table { width: 100%; line-height: inherit; text-align: left; }
        .invoice-box table td { padding: 5px; vertical-align: top; }
        .invoice-box table tr td:nth-child(2) { text-align: right; }
        .invoice-box table tr.top table td { padding-bottom: 20px; }
        .invoice-box table tr.top table td.title { font-size: 45px; line-height: 45px; color: #333; font-weight: bold; }
        .invoice-box table tr.information table td { padding-bottom: 40px; }
        .invoice-box table tr.heading td { background: #eee; border-bottom: 1px solid #ddd; font-weight: bold; }
        .invoice-box table tr.details td { padding-bottom: 20px; }
        .invoice-box table tr.item td{ border-bottom: 1px solid #eee; }
        .invoice-box table tr.item.last td { border-bottom: none; }
        .invoice-box table tr.total td:nth-child(2) { border-top: 2px solid #eee; font-weight: bold; font-size: 1.2rem; }
        
        @media print {
            .sidebar, .dashboard-header, .btn-group-invoice { display: none !important; }
            .main-content { margin-left: 0 !important; padding: 0 !important; }
            .invoice-box { border: none; box-shadow: none; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body class="dashboard-body">
    
    <jsp:include page="/components/admin_sidebar.jsp" />

    <div class="main-content">
        <header class="dashboard-header btn-group-invoice">
            <h2 style="font-weight: 700; color: #333;">Invoice</h2>
            <div style="display: flex; gap: 1rem;">
                <button onclick="window.print()" class="btn" style="background: #2c3e50; color: white;"><i class="fas fa-print"></i> Print Invoice</button>
                <a href="${pageContext.request.contextPath}/admin/invoice?action=email&id=${invoice.id}" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Email to Customer</a>
                <a href="${pageContext.request.contextPath}/admin/reservations?action=view&id=${res.id}" class="btn" style="background: #eee; color: #333;">Back to Reservation</a>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="invoice-box">
                <table cellpadding="0" cellspacing="0">
                    <tr class="top">
                        <td colspan="2">
                            <table>
                                <tr>
                                    <td class="title">OCEAN VIEW</td>
                                    <td>
                                        Invoice #: ${invoice.invoiceNumber}<br>
                                        Created: <fmt:formatDate value="${invoice.invoicedAt}" pattern="MMMM dd, yyyy" /><br>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr class="information">
                        <td colspan="2">
                            <table>
                                <tr>
                                    <td>
                                        Ocean View Resort<br>
                                        123 Coastal Road<br>
                                        Galle, Sri Lanka
                                    </td>
                                    <td>
                                        ${guest.fullName}<br>
                                        ${guest.email}<br>
                                        ${guest.phone}
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr class="heading">
                        <td>Payment Method</td>
                        <td>Reference #</td>
                    </tr>
                    <tr class="details">
                        <td>Cash / Physical</td>
                        <td>${res.id}</td>
                    </tr>
                    <tr class="heading">
                        <td>Item</td>
                        <td>Price</td>
                    </tr>
                    <tr class="item">
                        <td>Room Booking: Room #${room.roomNumber} (${room.roomName})<br>
                            <span style="font-size: 0.8rem; color: #888;">
                                <fmt:formatDate value="${res.checkInDate}" pattern="yyyy-MM-dd" /> to 
                                <fmt:formatDate value="${res.checkOutDate}" pattern="yyyy-MM-dd" />
                            </span>
                        </td>
                        <td>Rs. ${invoice.amount}</td>
                    </tr>
                    <tr class="total">
                        <td></td>
                        <td>Total: Rs. ${invoice.amount}</td>
                    </tr>
                </table>
                <div style="margin-top: 50px; text-align: center; color: #aaa; font-size: 0.8rem;">
                    Thank you for staying with us at Ocean View Resort!
                </div>
            </div>
        </div>
    </div>
</body>
</html>
