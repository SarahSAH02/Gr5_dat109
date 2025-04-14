<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statistikk - Tilbakemeldinger</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="<c:url value='/js/script.js' />" defer></script>
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
        <h2>Statistikk for Forelesning</h2>
        <!-- Debug output (can remove after testing) -->
        <div style="display:none;">
            Number of lectures: ${lectures.size()}
        </div>
        
        <form id="statsForm">
            <label for="lectureId">Velg Forelesning:</label>
            <select id="lectureId" name="lectureId" required>
                <c:choose>
                    <c:when test="${not empty lectures}">
                        <c:forEach items="${lectures}" var="lecture">
                            <option value="${lecture.id}">${lecture.title}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Ingen forelesninger tilgjengelig</option>
                    </c:otherwise>
                </c:choose>
            </select>
            <button type="submit">Hent statistikk</button>
        </form>

        <div id="loading" style="display: none;">Laster data...</div>
        
        <div id="feedbackStats" style="display: none;">
            <h3>Antall Tilbakemeldinger: <span id="totalFeedback"></span></h3>
            <h3>Fordeling etter farge:</h3>
            <canvas id="feedbackChart" width="400" height="400"></canvas>
            <h3>Kommentarer:</h3>
            <ul id="commentsList"></ul>
        </div>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>

    <script>
        document.getElementById('statsForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const lectureId = document.getElementById('lectureId').value;
            
            // Show loading state
            document.getElementById('feedbackStats').style.display = 'none';
            document.getElementById('loading').style.display = 'block';
            
            fetch(`/api/stats/${lectureId}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById('loading').style.display = 'none';
                    
                    // Update total feedback count
                    document.getElementById('totalFeedback').textContent = data.total;
                    
                    // Update comments
                    const commentsList = document.getElementById('commentsList');
                    commentsList.innerHTML = '';
                    if (data.comments && data.comments.length > 0) {
                        data.comments.forEach(comment => {
                            const li = document.createElement('li');
                            li.textContent = comment;
                            commentsList.appendChild(li);
                        });
                    } else {
                        commentsList.innerHTML = '<li>Ingen kommentarer</li>';
                    }
                    
                    // Update chart
                    updateChart(data);
                    
                    // Show stats section
                    document.getElementById('feedbackStats').style.display = 'block';
                })
                .catch(error => {
                    document.getElementById('loading').style.display = 'none';
                    console.error('Error:', error);
                    alert('Kunne ikke hente statistikk. Prøv igjen senere.');
                });
        });

        let feedbackChart = null;
        
        function updateChart(data) {
            const ctx = document.getElementById('feedbackChart').getContext('2d');
            
            // Destroy previous chart if it exists
            if (feedbackChart) {
                feedbackChart.destroy();
            }
            
            feedbackChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Grønn', 'Gul', 'Rød'],
                    datasets: [{
                        data: [
                            data.byColor?.GREEN || 0,
                            data.byColor?.YELLOW || 0,
                            data.byColor?.RED || 0
                        ],
                        backgroundColor: ['#4CAF50', '#FFEB3B', '#F44336'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return `${context.label}: ${context.raw} tilbakemeldinger`;
                                }
                            }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>