<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statistikk - Tilbakemeldinger</title>
    <!-- Linking CSS file using JSTL tag, updated path -->
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <!-- Linking JavaScript file using JSTL tag, updated path -->
    <script src="<c:url value='/js/script.js' />" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- For Chart.js -->
</head>
<body>
    <header>
        <h1>Statistikk for Tilbakemeldinger</h1>
        <nav>
            <ul>
                <li><a href="<c:url value='/dashboard' />">Dashboard</a></li>
                <li><a href="<c:url value='/lectures' />">Se forelesninger</a></li>
                <li><a href="<c:url value='/submit' />">Send inn tilbakemelding</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2>Gi Tilbakemelding på Forelesning</h2>
        <form action="<c:url value='/feedback/submit' />" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <label for="lectureId">Velg Forelesning:</label>
            <select id="lectureId" name="lectureId" required>
                <c:forEach items="${lectures}" var="lecture">
                    <option value="${lecture.id}">${lecture.title}</option>
                </c:forEach>
            </select><br><br>

            <label for="color">Vurder forelesningen:</label><br>
            <div class="emoji-container">
                <div class="emoji-button emoji-green" data-color="GREEN">😊</div>
                <div class="emoji-button emoji-yellow" data-color="YELLOW">😐</div>
                <div class="emoji-button emoji-red" data-color="RED">😞</div>
            </div><br><br>

            <input type="hidden" id="color" name="color" required>

            <label for="comment">Kommentar:</label>
            <textarea id="comment" name="comment" placeholder="Skriv din kommentar her..." required></textarea><br><br>

            <button type="submit">Send Tilbakemelding</button>
        </form>

       
    </section>
    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>

    <script>
        // Handle form submission and fetch stats from backend
        document.getElementById('statsForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const lectureId = document.getElementById('lectureId').value;

            fetch(`/api/stats/${lectureId}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalFeedback').textContent = data.total;
                    document.getElementById('feedbackStats').style.display = 'block';

                    // Show comments in the list
                    const commentsList = document.getElementById('commentsList');
                    commentsList.innerHTML = '';
                    data.comments.forEach(comment => {
                        const li = document.createElement('li');
                        li.textContent = comment;
                        commentsList.appendChild(li);
                    });

                    // Create chart for color distribution
                    const ctx = document.getElementById('feedbackChart').getContext('2d');
                    const chart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['Grønn', 'Gul', 'Rød'],
                            datasets: [{
                                label: 'Fordeling av Tilbakemeldinger',
                                data: [
                                    data.byColor.GREEN || 0,
                                    data.byColor.YELLOW || 0,
                                    data.byColor.RED || 0
                                ],
                                backgroundColor: ['#4CAF50', '#FFEB3B', '#F44336'],
                                borderColor: ['#fff', '#fff', '#fff'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: { position: 'top' },
                                tooltip: {
                                    callbacks: {
                                        label: function(tooltipItem) {
                                            return tooltipItem.raw + ' tilbakemeldinger';
                                        }
                                    }
                                }
                            }
                        }
                    });
                })
                .catch(error => console.error('Feil ved henting av statistikk:', error));
        });
    </script>
</body>
</html>
