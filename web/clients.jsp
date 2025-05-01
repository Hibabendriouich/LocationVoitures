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
        <title>Liste des Voitures</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                background: linear-gradient(to right, #f8f9fa, #e9ecef);
                position: relative;
                margin: 0;
                padding: 0;
            }

            .container {
                margin-left: auto;
                margin-right: auto;
                max-width: 1200px;  /* Ou une autre valeur que tu préfères */
                padding-left: 15px;
                padding-right: 15px;
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
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
            }

            .sidebar-logo {
                width: 200px; 
                height: auto;
                margin-bottom: 20px;
            }

            h1, h2 {
                text-align: center; /* Assurer que les titres sont bien centrés */
                width: 100%;
            }


            h1 {
                font-weight: 700;
                color: #343a40;
                margin-bottom: 2rem;
            }

            .car-card {
                border: none;
                border-radius: 15px;
                overflow: hidden;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                background-color: white;
            }

            .car-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 16px 24px rgba(0, 0, 0, 0.15);
            }

            .card-img-top {
                height: 200px;
                object-fit: cover;
            }

            .card-title {
                font-weight: 600;
            }

            .badge-available {
                background-color: #28a745;
            }

            .badge-unavailable {
                background-color: #dc3545;
            }

            .card-body {
                padding: 1.25rem;
            }

            .car-type {
                background-color: #6c757d;
                color: white;
                padding: 0.25rem 0.6rem;
                font-size: 0.8rem;
                border-radius: 10px;
                display: inline-block;
            }

            a {
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 5px;
                font-weight: 500;
                font-size: 14px;
                transition: all 0.3s ease;
                display: inline-block;
            }

            a[href*="delete"] {
                background-color: #ff5252;
                color: white;
            }

            a[href*="delete"]:hover {
                background-color: #e04646;
            }

            a[href*="update"] {
                background-color: #FFCC00;
                color: white;
            }

            a[href*="update"]:hover {
                background-color: #fde278;
            }

            .button {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 600;
                transition: background-color 0.3s ease, transform 0.2s ease;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .button:hover {
                background-color: #3e9142;
                transform: scale(1.05);
                text-decoration: none;
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
                width: 180px; 
                height: auto;
                margin-bottom: 30px;
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
                transition: background-color 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #444;
            }

            .profil-btn {
                background-color: #9c1330;
                color: white;
                padding: 10px 20px;
                border-radius: 30px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
                margin-top: 20px;
            }

            .profil-btn:hover {
                background-color: #bf2849;
            }

            .container {
                flex: 1;
                margin-left: 270px; /* Marge pour la barre latérale */
                padding: 2rem;
            }
            @media (max-width: 768px) {


                .sidebar {
                    width: 200px;
                }

                .main-content {
                    padding: 15px;
                }


                a {
                    padding: 6px 10px;
                    font-size: 13px;
                }
            }
            .btn-louer {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-louer:hover {
                background-color: #3e9142;
                transform: scale(1.05);
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
            <h2>Admin Dashboard</h2>
            <a href="VoitureController" class="profil-btn">Voitures</a>
            <a href="profil.jsp" class="profil-btn">Profil</a>
            <a href="DeconnexionController" class="profil-btn">Déconnexion</a>
        </div>

        <!-- Contenu principal -->
        <div class="container">
            <h1 class="my-4 text-center">Liste des Voitures disponibles</h1>
            <h2 class="my-4 text-center">Louez, Conduisez, Explorez</h2>

            <div class="row" id="car-list">
                <c:forEach var="voiture" items="${listeVoitures}">
                    <div class="col-md-4 mb-4">
                        <div class="card car-card">
                            <img src="${pageContext.request.contextPath}/images/${voiture.photo}" class="card-img-top" alt="Image de ${voiture.marque}">

                            <div class="card-body">
                                <h4 class="card-title fw-bold text-primary">${voiture.marque}</h4>
                                <h5 class="card-text mb-2">Modèle : <span class="text-dark">${voiture.modele}</span></h5>
                                <p class="card-text mb-1">Année : <strong>${voiture.annee}</strong></p>
                                <h6 class="card-text mb-3">Prix/j : <span class="text-success fw-semibold">${voiture.prix} MAD</span></h6>

                                <div class="d-flex justify-content-center">
                                    <button class="button text-decoration-none btn-louer" data-voiture-id="${voiture.id}">Louer</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Bootstrap JS et dépendances -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <div class="modal fade" id="locationModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
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
                            <button href="profil.jsp" type="submit" class="btn btn-primary">Confirmer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Gestion du modal de location
                const locationModal = new bootstrap.Modal(document.getElementById('locationModal'));
                        document.querySelectorAll('.btn-louer').forEach(btn => {
                btn.addEventListener('click', function () {
                    document.getElementById('modalVoitureId').value = this.dataset.voitureId;
                    locationModal.show();
                });
            });
            // Validation des dates
            const dateDebut = document.querySelector('input[name="dateDebut"]');
                    const dateFin = document.querySelector('input[name="dateFin"]');
                    dateDebut.addEventListener('change', function () {
                        dateFin.min = this.value;
                    });
            });
        </script>
    </body>
</html>
