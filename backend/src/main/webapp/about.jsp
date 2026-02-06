<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />

    <section class="hero-small" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1582719508461-905c673771fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');">
        <h1>Our Story</h1>
        <p>Experience the ultimate luxury where the ocean meets the sky.</p>
    </section>

    <section class="section">
        <div class="container" style="max-width: 1000px; margin: 0 auto;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center;">
                <div>
                    <img src="${pageContext.request.contextPath}/assets/about.png" alt="About Ocean View" style="width: 100%; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                </div>
                <div>
                    <h2 class="section-title" style="text-align: left;">A Sanctuary by the Sea</h2>
                    <p style="color: #666; line-height: 1.8; margin-bottom: 1.5rem;">
                        Founded in 2010, Ocean View Resort began with a simple vision: to create a sanctuary where guests could escape the hustle and bustle of everyday life and reconnect with nature. 
                        Situated on the pristine coast of Southern Sri Lanka, our resort offers a seamless blend of modern luxury and traditional hospitality.
                    </p>
                    <p style="color: #666; line-height: 1.8; margin-bottom: 1.5rem;">
                        With 25 exquisitely designed rooms and suites, world-class dining, and a dedicated team of staff, we ensure that every moment of your stay is memorable. 
                        Whether you are here for a romantic getaway, a family vacation, or a business retreat, Ocean View Resort is your home away from home.
                    </p>
                </div>
            </div>

            <div style="margin-top: 5rem; text-align: center;">
                <h2 class="section-title">Why Choose Us</h2>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; margin-top: 3rem;">
                    <div style="padding: 2rem; background: #fff; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                        <i class="fas fa-umbrella-beach" style="font-size: 2.5rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                        <h3 style="margin-bottom: 0.5rem;">Private Beach</h3>
                        <p style="color: #888;">Direct access to a secluded beach reserved exclusively for our guests.</p>
                    </div>
                    <div style="padding: 2rem; background: #fff; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                        <i class="fas fa-utensils" style="font-size: 2.5rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                        <h3 style="margin-bottom: 0.5rem;">Gourmet Dining</h3>
                        <p style="color: #888;">Experience local and international cuisines prepared by our award-winning chefs.</p>
                    </div>
                    <div style="padding: 2rem; background: #fff; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                        <i class="fas fa-spa" style="font-size: 2.5rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                        <h3 style="margin-bottom: 0.5rem;">Wellness Spa</h3>
                        <p style="color: #888;">Rejuvenate your body and mind with our signature spa treatments.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
</body>
</html>
