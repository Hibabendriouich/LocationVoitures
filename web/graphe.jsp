<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statistiques | Luxury Drive</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #e74c3c;
            --accent: #3498db;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --text: #34495e;
            --success: #27ae60;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            color: var(--text);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        /* Sidebar Styling */
        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, var(--primary) 0%, #1a2b3c 100%);
            color: white;
            padding: 30px 15px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            z-index: 100;
        }
        
        .sidebar-logo {
            width: 160px;
            margin: 0 auto 30px;
            display: block;
        }
        
        .sidebar h2 {
            color: white;
            margin-bottom: 30px;
            font-weight: 600;
            font-size: 1.3rem;
            text-align: center;
        }
        
        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        
        .sidebar-link i {
            margin-right: 10px;
            font-size: 1rem;
        }
        
        .sidebar-link:hover {
            background-color: rgba(255,255,255,0.2);
            transform: translateX(5px);
        }
        
        .sidebar-link.active {
            background-color: rgba(255,255,255,0.25);
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 40px;
            max-width: calc(100% - 280px);
        }
        
        /* Chart Container */
        .chart-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            height: 600px;
            display: flex;
            flex-direction: column;
        }
        
        .chart-title {
            color: var(--primary);
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        .chart-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        .chart-wrapper {
            flex: 1;
            position: relative;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
                padding: 25px 10px;
            }
            
            .main-content {
                margin-left: 250px;
                padding: 30px;
                max-width: calc(100% - 250px);
            }
            
            .chart-container {
                height: 500px;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
                padding: 20px;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
                max-width: 100%;
            }
            
            .chart-container {
                height: 400px;
                padding: 20px;
            }
            
            .chart-title {
                font-size: 1.5rem;
            }
            
            .nav-links {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .sidebar-link {
                margin: 5px;
                flex: 1 0 auto;
                max-width: 200px;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            .chart-container {
                height: 350px;
                padding: 15px;
            }
            
            .chart-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="images/logo.png" alt="Logo" class="sidebar-logo">
        <h2>Tableau de Bord</h2>
        
        <div class="nav-links">
            <a href="users.jsp" class="sidebar-link">
                <i class="fas fa-users"></i> Clients
            </a>
            <a href="graphe.jsp" class="sidebar-link active">
                <i class="fas fa-chart-bar"></i> Statistiques
            </a>
            <a href="DeconnexionController" class="sidebar-link">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="chart-container">
            <h1 class="chart-title">Répartition des voitures par type</h1>
            <div class="chart-wrapper">
                <canvas id="typeVoitureChart"></canvas>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', () => {
        // Couleurs modernes pour le graphique
        const colorPalette = [
            'rgba(75, 192, 192, 0.7)',
            'rgba(54, 162, 235, 0.7)',
            'rgba(255, 99, 132, 0.7)',
            'rgba(255, 159, 64, 0.7)',
            'rgba(153, 102, 255, 0.7)',
            'rgba(255, 206, 86, 0.7)'
        ];
        
        const borderPalette = [
            'rgba(75, 192, 192, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 99, 132, 1)',
            'rgba(255, 159, 64, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 206, 86, 1)'
        ];

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

                const ctx = document.getElementById('typeVoitureChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Nombre de voitures',
                            data: valeurs,
                            backgroundColor: colorPalette,
                            borderColor: borderPalette,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { 
                                display: false
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return `${context.parsed.y} voiture(s)`;
                                    }
                                },
                                backgroundColor: 'rgba(0,0,0,0.8)',
                                titleFont: { family: 'Poppins', size: 14 },
                                bodyFont: { family: 'Poppins', size: 12 },
                                padding: 12,
                                cornerRadius: 6
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: { 
                                    stepSize: 1, 
                                    precision: 0,
                                    font: { family: 'Poppins' }
                                },
                                title: { 
                                    display: true, 
                                    text: 'Nombre de voitures',
                                    font: { family: 'Poppins', size: 14 }
                                },
                                grid: {
                                    color: 'rgba(0,0,0,0.05)'
                                }
                            },
                            x: {
                                title: { 
                                    display: true, 
                                    text: 'Types de voitures',
                                    font: { family: 'Poppins', size: 14 }
                                },
                                ticks: {
                                    font: { family: 'Poppins' }
                                },
                                grid: {
                                    display: false
                                }
                            }
                        },
                        animation: {
                            duration: 1500,
                            easing: 'easeOutQuart'
                        },
                        layout: {
                            padding: {
                                top: 20,
                                bottom: 20
                            }
                        }
                    }
                });
            })
            .catch(err => {
                console.error('Erreur de chargement des données:', err);
                document.getElementById('typeVoitureChart').parentElement.innerHTML = `
                    <div class="text-center py-5">
                        <i class="fas fa-exclamation-triangle text-warning" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Erreur de chargement des données</h4>
                        <p class="text-muted">${err.message}</p>
                    </div>
                `;
            });
    });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>