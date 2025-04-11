<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrer deg</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="<c:url value='/js/script.js' />" defer></script>
</head>
<body>
    <header>
        <h1>Registrer deg</h1>
    </header>

    <section>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="<c:url value='/users/register' />" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <label for="username">Brukernavn:</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Passord:</label>
            <input type="password" id="password" name="password" required><br>

            <button type="submit">Registrer</button>
        </form>
        
        <p>Allerede registrert? <a href="<c:url value='/login' />">Logg inn her</a></p>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>
</body>
</html>