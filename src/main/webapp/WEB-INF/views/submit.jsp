<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gi Tilbakemelding</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <script src="<c:url value='/js/script.js' />" defer></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        header, footer {
            background-color: #343a40;
            color: white;
            padding: 20px;
            text-align: center;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 0;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
        }

        section {
            max-width: 700px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .emoji-container {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }

        .emoji-button {
            font-size: 36px;
            padding: 20px;
            cursor: pointer;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .emoji-button:hover {
            transform: scale(1.2);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .selected {
            outline: 3px solid #28a745;
        }

        button[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Tilbakemeldingsskjema</h1>
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
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <label for="lectureId">Velg forelesning:</label><br>
            <select id="lectureId" name="lectureId" required>
                <c:forEach items="${lectures}" var="lecture">
                    <option value="${lecture.id}">${lecture.title}</option>
                </c:forEach>
            </select><br><br>

            <label for="color">Vurder forelesningen:</label><br>
            <div class="emoji-container">
                <div class="emoji-button emoji-green" data-color="GREEN" title="Bra 😊">😊</div>
                <div class="emoji-button emoji-yellow" data-color="YELLOW" title="Middels 😐">😐</div>
                <div class="emoji-button emoji-red" data-color="RED" title="Dårlig 😞">😞</div>
            </div>
            <input type="hidden" id="color" name="color" required><br><br>

            <label for="comment">Kommentar:</label><br>
            <textarea id="comment" name="comment" rows="4" placeholder="Skriv din kommentar her..." required></textarea><br><br>

            <button type="submit">Send Tilbakemelding</button>
        </form>
    </section>

    <footer>
        <p>&copy; 2025. Alle rettigheter reservert.</p>
    </footer>

    <script>
        // Emoji valg og oppdatering av skjult input
        document.querySelectorAll('.emoji-button').forEach(button => {
            button.addEventListener('click', () => {
                document.querySelectorAll('.emoji-button').forEach(btn => btn.classList.remove('selected'));
                button.classList.add('selected');
                document.getElementById('color').value = button.getAttribute('data-color');
            });
        });

        // Validering: krever at en emoji er valgt
        document.querySelector('form').addEventListener('submit', function(e) {
            if (!document.getElementById('color').value) {
                e.preventDefault();
                alert('Vennligst velg en vurdering med emoji.');
            }
        });
    </script>
</body>
</html>
