<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Voitures | Luxury Drive</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            justify-content: center;
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
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 40px;
            max-width: calc(100% - 280px);
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title {
            color: var(--primary);
            font-size: 2rem;
            font-weight: 600;
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        
        .page-title:after {
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
        
        .page-subtitle {
            color: var(--text);
            font-size: 1.2rem;
            font-weight: 400;
        }
        
        /* Cars Grid */
        .cars-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .car-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .car-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .car-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .car-body {
            padding: 20px;
        }
        
        .car-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 5px;
        }
        
        .car-model {
            color: var(--text);
            font-size: 1rem;
            margin-bottom: 10px;
        }
        
        .car-detail {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        
        .car-detail-label {
            color: #777;
        }
        
        .car-detail-value {
            font-weight: 500;
        }
        
        .car-price {
            color: var(--success);
            font-weight: 600;
            font-size: 1.1rem;
            margin: 15px 0;
            text-align: center;
        }
        
        .rent-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: var(--accent);
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .rent-btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        /* Modal Styling */
        .modal-header {
            border-bottom: none;
            padding-bottom: 0;
        }
        
        .modal-title {
            color: var(--primary);
            font-weight: 600;
        }
        
        .modal-footer {
            border-top: none;
        }
        
        .btn-confirm {
            background-color: var(--success);
            border: none;
        }
        
        .btn-confirm:hover {
            background-color: #219653;
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
            
            .nav-links {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .sidebar-link {
                margin: 5px;
                flex: 1 0 auto;
                max-width: 200px;
            }
            
            .cars-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <%
        if ((session.getAttribute("admin") == null && session.getAttribute("client") == null)) {
            response.sendRedirect("Authentification.jsp");
            return;
        }
    %>
</head>
<body>
    <div class="sidebar">
        <img src="images/logo.png" alt="Logo" class="sidebar-logo">
        <h2>Tableau de Bord</h2>
        
        <div class="nav-links">
            <a href="VoitureController" class="sidebar-link active">
                <i class="fas fa-car"></i> Voitures
            </a>
            <a href="profil.jsp" class="sidebar-link">
                <i class="fas fa-user"></i> Profil
            </a>
            <a href="DeconnexionController" class="sidebar-link">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="page-header">
            <h1 class="page-title">Liste des Voitures disponibles</h1>
            <p class="page-subtitle">Louez, Conduisez, Explorez</p>
        </div>
        
        <div class="cars-grid">
            <c:forEach var="voiture" items="${listeVoitures}">
                <div class="car-card">
                    <img src="${pageContext.request.contextPath}/images/${voiture.photo}" class="car-img" alt="${voiture.marque} ${voiture.modele}">
                    
                    <div class="car-body">
                        <h3 class="car-title">${voiture.marque}</h3>
                        <p class="car-model">${voiture.modele}</p>
                        
                        <div class="car-detail">
                            <span class="car-detail-label">Année :</span>
                            <span class="car-detail-value">${voiture.annee}</span>
                        </div>
                        
                        <div class="car-price">
                            ${voiture.prix} MAD / jour
                        </div>
                        
                        <button class="rent-btn" data-bs-toggle="modal" data-bs-target="#locationModal" data-voiture-id="${voiture.id}">
                            <i class="fas fa-calendar-alt"></i> Réserver maintenant
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Modal de réservation -->
    <div class="modal fade" id="locationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Réservation</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="${pageContext.request.contextPath}/LocationController" method="post">
                    <input type="hidden" name="voiture" id="modalVoitureId">
                    
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Date de début</label>
                            <input type="date" name="dateDebut" class="form-control" required 
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date de fin</label>
                            <input type="date" name="dateFin" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary btn-confirm">Confirmer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Gestion du modal de location
            const locationModal = document.getElementById('locationModal');
            if (locationModal) {
                locationModal.addEventListener('show.bs.modal', function(event) {
                    const button = event.relatedTarget;
                    const voitureId = button.getAttribute('data-voiture-id');
                    document.getElementById('modalVoitureId').value = voitureId;
                });
            }
            
            // Validation des dates
            const dateDebut = document.querySelector('input[name="dateDebut"]');
            const dateFin = document.querySelector('input[name="dateFin"]');
            
            if (dateDebut && dateFin) {
                dateDebut.addEventListener('change', function() {
                    dateFin.min = this.value;
                });
            }
        });
    </script>
</body>
</html>