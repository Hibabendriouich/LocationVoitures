<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Statistiques des voitures</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            body {
                background: linear-gradient(to right, #74ebd5, #ACB6E5);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            #chart-container {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                max-width: 700px;
                width: 100%;
            }
            .chart-title {
                text-align: center;
                margin-bottom: 30px;
                font-size: 2rem;
                font-weight: bold;
                color: #333;
            }
            canvas {
                max-height: 400px; 
            }
        </style>
    </head>

    <body>

        <div id="chart-container">
            <h1 class="chart-title">Nombre de voitures par type</h1>
            <canvas id="typeVoitureChart"></canvas>
        </div>

        <script>
        document.addEventListener('DOMContentLoaded', () => {
          fetch('http://localhost:8080/locationVoitures/VoitureTypeStatController')
            .then(response => {
              if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
              }
              return response.json();
            })
            .then(data => {
              const labels = data.map(item => item.typeVoiture);
              const valeurs = data.map(item => item.voitureCount);

              const backgroundColors = [
                'rgba(255, 99, 132, 0.7)',
                'rgba(54, 162, 235, 0.7)',
                'rgba(255, 206, 86, 0.7)',
                'rgba(75, 192, 192, 0.7)',
                'rgba(153, 102, 255, 0.7)',
                'rgba(255, 159, 64, 0.7)'
              ];

              const ctx = document.getElementById('typeVoitureChart').getContext('2d');
              new Chart(ctx, {
                type: 'bar',
                data: {
                  labels: labels,
                  datasets: [{
                    label: 'Nombre de voitures',
                    data: valeurs,
                    backgroundColor: backgroundColors,
                    borderColor: backgroundColors.map(color => color.replace('0.7', '1')),
                    borderWidth: 1
                  }]
                },
                options: {
                  responsive: true,
                  maintainAspectRatio: false, 
                  plugins: {
                    legend: { display: false },
                    tooltip: {
                      callbacks: {
                        label: function(context) {
                          return `${context.parsed.y} voiture(s)`;
                        }
                      }
                    }
                  },
                  scales: {
                    y: {
                      beginAtZero: true,
                      ticks: { stepSize: 1, precision: 0 },
                      title: { display: true, text: 'Nombre de voitures' }
                    },
                    x: {
                      title: { display: true, text: 'Types de voitures' }
                    }
                  },
                  animation: {
                    duration: 2000,
                    easing: 'easeInOutBounce'
                  }
                }
              });
            })
            .catch(err => {
              console.error('Erreur de chargement des données:', err);
            });
        });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
