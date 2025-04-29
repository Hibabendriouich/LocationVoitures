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
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                display: flex;
                justify-content: flex-start;  
                background-color: #f5f5f5;
                min-height: 100vh;
                padding: 20px;
                gap: 20px;
            }

            #chart-container {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                max-width: 700px;
                width: 100%;
                margin: 0 auto;
                height : 700px;
                margin-top: 50px;
            }

            .chart-title {
                text-align: center;
                margin-bottom: 30px;
                font-size: 2rem;
                font-weight: bold;
                color: #333;
            }

            canvas {
                max-height: 500px;
                height: 300px;
            }

            .sidebar {
                width: 250px;
                background-color: #333;
                color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .sidebar-logo {
                width: 200px; 
                height: auto;
                margin-bottom: 20px;
            }

            .sidebar h2 {
                margin-bottom: 40px;
                font-size: 24px;
            }

            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                font-size: 16px;
                margin-bottom: 15px;
                border-radius: 5px;
                transition: background-color 0.3s ease, padding-left 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #444;
                padding-left: 15px;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
                text-align: center;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #6c757d; 
                border-color: #6c757d;
                color: white;
            }

            @media (max-width: 768px) {
                body {
                    flex-direction: column;
                    padding: 10px;
                }

                .sidebar {
                    width: 100%;
                    margin-bottom: 20px;
                }

                #chart-container {
                    width: 100%;
                }

                th, td {
                    padding: 10px;
                    font-size: 14px;
                }

                .sidebar a {
                    font-size: 14px;
                    padding: 8px 12px;
                }
            }

            @media (max-width: 480px) {
                canvas {
                    max-height: 300px;
                }

                .chart-title {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="sidebar-logo">
            <h2>Admin Dashboard</h2>
            <a href="users.jsp">Liste des clients</a>
            <a href="graphe.jsp">Statistiques de voitures</a>
        </div>

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

