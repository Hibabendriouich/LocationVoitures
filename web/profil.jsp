<%@ page import="java.util.List" %>
<%@ page import="entities.Location" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="services.LocationService" %>
<%@ page import="entities.Client" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon Profil - Historique des locations</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #999;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        h1 {
            text-align: center;
            margin-top: 30px;
        }
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
    </style>
    <%
            if ( (session.getAttribute("admin") == null && session.getAttribute("client") == null)) {
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
    <h1>Historique de mes locations</h1>
<%
    Client client = (Client) session.getAttribute("client");
    if (client == null) {
        response.sendRedirect("Authentification.jsp");
        return;
    }

    LocationService ls = new LocationService();
    List<Location> locations = ls.getLocationsByClient(client.getId());
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        if (locations != null && !locations.isEmpty()) {
    %>
        <table>
    <thead>
        <tr>
            <th>Voiture</th>
            <th>Date début</th>
            <th>Date fin</th>
        </tr>
    </thead>
    <tbody>
        <% for (Location loc : locations) { %>
            <tr>
                <td><%= loc.getVoiture().getMarque() %> <%= loc.getVoiture().getModele() %></td>
                <td><%= sdf.format(loc.getId().getDateDebut()) %></td>
                <td><%= sdf.format(loc.getDateFin()) %></td>
            </tr>
        <% } %>
    </tbody>
</table>
    <%
        } else {
    %>
        <p style="text-align:center;">Aucune location trouvée.</p>
    <%
        }
    %>
</body>
</html>