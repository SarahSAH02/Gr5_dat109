// Når dokumentet er lastet
document.addEventListener('DOMContentLoaded', function() {

    // Legger til hover-effekt for emojis
    const emojiButtons = document.querySelectorAll('.emoji-button');
    
    emojiButtons.forEach(function(button) {
        button.addEventListener('mouseenter', function() {
            button.style.transform = 'scale(1.1)';
        });

        button.addEventListener('mouseleave', function() {
            button.style.transform = 'scale(1)';
        });

        // Legger til event listener for å registrere klikk på emoji-knappene
        button.addEventListener('click', function() {
            const color = button.classList.contains('emoji-green') ? 'green' :
                          button.classList.contains('emoji-yellow') ? 'yellow' : 'red';
            
            alert(`Du valgte en ${color} emoji!`);
        });
    });

    // Animasjon for hover på statistikk og info-kort
    const statsCards = document.querySelectorAll('.card');
    statsCards.forEach(function(card) {
        card.addEventListener('mouseenter', function() {
            card.style.transform = 'scale(1.05)';
        });

        card.addEventListener('mouseleave', function() {
            card.style.transform = 'scale(1)';
        });
    });

    // Feedback stats - du kan håndtere dynamisk data her i fremtiden
    const feedbackButtons = document.querySelectorAll('.feedback-box');
    feedbackButtons.forEach(function(button) {
        button.addEventListener('mouseenter', function() {
            button.style.boxShadow = '0px 6px 12px rgba(0, 0, 0, 0.15)';
        });

        button.addEventListener('mouseleave', function() {
            button.style.boxShadow = 'none';
        });
    });

});
