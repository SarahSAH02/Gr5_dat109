<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logg Inn</title>
    <!-- Linking CSS file using JSTL tag, updated path -->
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <!-- Linking JavaScript file using JSTL tag, updated path -->
    <script src="<c:url value='/js/script.js' />" defer></script>
</head>
<body>
    <header>
        <h1>Logg inn</h1>
    </header>

    <section>

        <c:if test="${param.error != null}">
    <p style="color:red;">Ugyldig brukernavn eller passord.</p>
</c:if>

        <!-- Form submission to /login -->
        <form action="<c:url value='/login' />" method="POST" onsubmit="return validateForm(this)">
    <!-- Add this CSRF token input -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    
    <label for="username">Brukernavn:</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">Passord:</label>
    <input type="password" id="password" name="password" required><br>

    <button type="submit">Logg inn</button>
</form>

        <!-- Link to registration page -->
        <p>Ikke registrert? <a href="<c:url value='/users/register' />">Registrer deg her</a></p>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>
</body>
</html>
