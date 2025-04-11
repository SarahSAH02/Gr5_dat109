<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="<c:url value='/js/script.js' />" defer></script>
</head>
<body>
    <header>
        <h1>Dashboard</h1>
        <nav>
            <ul>
                <li><a href="<c:url value='/lectures' />">Se forelesninger</a></li>
                <li><a href="<c:url value='/submit' />">Send inn tilbakemelding</a></li>
                <li><a href="<c:url value='/stats' />">Statistikk</a></li>
                <li><a href="<c:url value='/logout' />">Logg ut</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2 id="welcome-message">Velkommen!</h2>

       <!-- Action section available for all logged-in users -->
<div class="user-actions">
    <h3>Legg til nytt skjema!</h3>
    
    <!-- Button to open the modal -->
    <button id="newFeedbackFormBtn">Opprett nytt skjema</button>

    <!-- Modal for creating new feedback form -->
    <div id="feedbackFormModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Opprett nytt tilbakemeldingsskjema</h3>
            <form id="newFeedbackForm" action="<c:url value='/lectures/create' />" method="POST">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <label for="lectureTitle">Forelesningstittel:</label>
                <input type="text" id="lectureTitle" name="lectureTitle" required>
                
                <label for="lectureDate">Dato:</label>
                <input type="date" id="lectureDate" name="lectureDate" required>
                
                <button type="submit">Opprett skjema</button>
            </form>
        </div>
    </div>
</div>

<p>Her kan du administrere tilbakemeldinger, forelesninger og mer.</p>

<footer>
    <p>&copy; 2025. Alle rettigheter reservert.</p>
</footer>

<script>
    // Modal functionality
    const modal = document.getElementById("feedbackFormModal");
    const btn = document.getElementById("newFeedbackFormBtn");
    const span = document.getElementsByClassName("close")[0];

    btn.onclick = function() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
