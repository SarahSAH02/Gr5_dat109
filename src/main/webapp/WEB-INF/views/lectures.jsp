<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forelesninger</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="<c:url value='/js/script.js' />" defer></script>
</head>
<body>
    <header>
        <h1>Forelesninger</h1>
        <nav>
            <ul>
                <li><a href="<c:url value='/dashboard' />">Dashboard</a></li>
                <li><a href="<c:url value='/submit' />">Send inn tilbakemelding</a></li>
                <li><a href="<c:url value='/stats' />">Statistikk</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2>Forelesninger</h2>
        <p>Her vises en liste over tilgjengelige forelesninger.</p>

        <!-- Dynamisk liste over forelesninger -->
        <c:if test="${not empty lectures}">
            <ul>
                <c:forEach var="lecture" items="${lectures}">
                    <li>
                        <strong>${lecture.title}</strong> - ${lecture.date}
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <c:if test="${empty lectures}">
            <p>Det er ingen tilgjengelige forelesninger for øyeblikket.</p>
        </c:if>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>
</body>
</html>
