<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Review | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <style>
        .star-rating {
            direction: rtl;
            display: inline-flex;
            font-size: 2rem;
            cursor: pointer;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            color: #ddd;
            transition: color 0.2s;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffc107;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="section">
        <div style="max-width: 600px; margin: 0 auto; background: white; padding: 2rem; border-radius: 20px; box-shadow: var(--shadow);">
            <h2 style="margin-bottom: 1.5rem; text-align: center;">How was your stay?</h2>
            <p style="text-align: center; margin-bottom: 2rem; color: #666;">We'd love to hear about your experience for Reservation #${reservation.id}</p>

            <form action="${pageContext.request.contextPath}/add-review" method="POST">
                <input type="hidden" name="reservationId" value="${reservation.id}">
                
                <div class="form-group" style="text-align: center;">
                    <label style="display: block; margin-bottom: 0.5rem;">Rate your experience</label>
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rating" value="5" required/><label for="star5" title="Excellent"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="Good"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="Average"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="Poor"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="Very Poor"><i class="fas fa-star"></i></label>
                    </div>
                </div>

                <div class="form-group">
                    <label>Share your feedback</label>
                    <textarea name="feedback" class="form-control" rows="5" placeholder="Tell us what you liked or how we can improve..." required></textarea>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Submit Review</button>
                <a href="${pageContext.request.contextPath}/profile" class="btn" style="width: 100%; text-align: center; margin-top: 1rem; background: #eee; color: #333; display: block;">Cancel</a>
            </form>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
