<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

            .sidebar-logo {
                width: 200px; 
                height: auto;
                margin-bottom: 20px;
            }

            /* Style du bouton Profil */
            .profil-btn {
                position: absolute;
                top: 20px;
                right: 20px;
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border-radius: 30px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .profil-btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>

        <!-- Bouton Profil en haut à droite -->
        <a href="profil.jsp" class="profil-btn">Profil</a>

        <div class="container">
            <h1 class="my-4" text-center>Liste des Voitures disponibles</h1>
            <h2 class="my-4" text-center>Louez, Conduisez, Explorez</h2>

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
                                    <a href="louer.jsp?id=${voiture.id}" class="button text-decoration-none">Louer</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Bootstrap JS et dépendances -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
