<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Tilbakemelding</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="<c:url value='/js/script.js' />" defer></script>
</head>
<body>
    <header>
        <h1>Send Tilbakemelding</h1>
        <nav>
            <ul>
                <li><a href="<c:url value='/dashboard' />">Dashboard</a></li>
                <li><a href="<c:url value='/lectures' />">Se forelesninger</a></li>
                <li><a href="<c:url value='/stats' />">Se statistikk</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2>Statistikk for Forelesning</h2>
        <!-- Form for selecting the lecture to see statistics -->
        <form id="statsForm">
            <label for="lectureId">Velg Forelesning:</label>
            <select id="lectureId" name="lectureId" required>
                <c:forEach items="${lectures}" var="lecture">
                    <option value="${lecture.id}">${lecture.title}</option>
                </c:forEach>
            </select>
            <button type="submit">Hent statistikk</button>
        </form>

        <!-- Placeholder for feedback stats -->
        <div id="feedbackStats" style="display: none;">
            <h3>Antall Tilbakemeldinger: <span id="totalFeedback"></span></h3>
            <h3>Fordeling etter farge:</h3>
            <canvas id="feedbackChart"></canvas>
            <h3>Kommentarer:</h3>
            <ul id="commentsList"></ul>
        </div>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>

    <script>
        // Handle form submission and fetch stats from backend
        document.getElementById('statsForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const lectureId = document.getElementById('lectureId').value;

            // Show a loading message or spinner while fetching data
            document.getElementById('feedbackStats').style.display = 'none';
            const totalFeedbackElem = document.getElementById('totalFeedback');
            totalFeedbackElem.textContent = 'Henter data...';

            // Fetch the statistics for the selected lecture
            fetch(`/api/stats/${lectureId}`)
                .then(response => response.json())
                .then(data => {
                    // Display the total number of feedbacks
                    totalFeedbackElem.textContent = data.total;

                    // Display the feedback stats section
                    document.getElementById('feedbackStats').style.display = 'block';

                    // Display the comments
                    const commentsList = document.getElementById('commentsList');
                    commentsList.innerHTML = ''; // Clear previous comments
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
                .catch(error => {
                    // Handle errors here
                    console.error('Feil ved henting av statistikk:', error);
                    totalFeedbackElem.textContent = 'Kunne ikke hente statistikk. Prøv igjen senere.';
                });
        });
    </script>
</body>
</html>