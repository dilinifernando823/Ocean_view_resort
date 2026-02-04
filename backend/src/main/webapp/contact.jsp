<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Ocean View Resort</title>
</head>
<body>
    <jsp:include page="/components/header.jsp" />
    <section class="section">
        <h2 class="section-title">Get In Touch</h2>
        <div class="auth-container" style="margin-top:0;">
            <form>
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" class="form-control">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control">
                </div>
                <div class="form-group">
                    <label>Message</label>
                    <textarea class="form-control" rows="4"></textarea>
                </div>
                <button type="button" class="btn btn-primary" style="width:100%;">Send Message</button>
            </form>
        </div>
    </section>
    <jsp:include page="/components/footer.jsp" />
</body>
</html>
