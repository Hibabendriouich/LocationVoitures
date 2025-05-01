<%@ page import="java.util.List" %>
<%@ page import="entities.Location" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="services.LocationService" %>
<%@ page import="entities.Client" %>
<%@ page import="entities.Voiture" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historique des Locations | Luxury Drive</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            width: 250px; /* Réduit de 280px */
            background: linear-gradient(135deg, var(--primary) 0%, #1a2b3c 100%);
            color: white;
            padding: 30px 15px; /* Padding réduit sur les côtés */
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            z-index: 100;
        }
        
        .sidebar-logo {
            width: 160px; /* Logo légèrement plus petit */
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
            gap: 8px; /* Espace entre les boutons */
        }
        
        .profil-btn {
            display: flex;
            align-items: center;
            width: auto; /* Largeur automatique au lieu de 100% */
            padding: 10px 15px; /* Padding réduit */
            margin: 0;
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        
        .profil-btn i {
            margin-right: 10px;
            font-size: 1rem;
        }
        
        .profil-btn:hover {
            background-color: rgba(255,255,255,0.2);
            transform: translateX(5px);
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px; /* Ajout de 30px d'espace (250px sidebar + 30px) */
            padding: 40px;
            max-width: calc(100% - 280px); /* Empêche le débordement */
        }
        
        h1 {
            color: var(--primary);
            font-size: 2rem;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
            font-weight: 600;
        }
        
        h1:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        /* Table Styling */
        .rental-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .rental-table thead th {
            background-color: var(--primary);
            color: white;
            padding: 16px 20px;
            text-align: left;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }
        
        .rental-table tbody tr {
            transition: all 0.2s ease;
        }
        
        .rental-table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .rental-table tbody td {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .car-info {
            display: flex;
            align-items: center;
        }
        
        .car-icon {
            width: 40px;
            height: 40px;
            background-color: rgba(52, 152, 219, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--accent);
        }
        
        .date-badge {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--accent);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
        }
        
        .date-badge i {
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        .no-rentals {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .no-rentals i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .no-rentals p {
            font-size: 1.1rem;
            color: #777;
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
            
            .rental-table {
                display: block;
                overflow-x: auto;
            }
            
            .nav-links {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .profil-btn {
                margin: 5px;
                flex: 1 0 auto;
                max-width: 200px;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="images/logo.png" alt="Logo" class="sidebar-logo">
        <h2>Tableau de Bord</h2>
        
        <div class="nav-links">
            <a href="VoitureController" class="profil-btn">
                <i class="fas fa-car"></i> Voitures
            </a>
            <a href="profil.jsp" class="profil-btn">
                <i class="fas fa-user"></i> Profil
            </a>
            <a href="DeconnexionController" class="profil-btn">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </div>
    </div>

    <div class="main-content">
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
        <table class="rental-table">
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
                    <td>
                        <div class="car-info">
                            <div class="car-icon">
                                <i class="fas fa-car"></i>
                            </div>
                            <div>
                                <strong><%= loc.getVoiture().getMarque() %> <%= loc.getVoiture().getModele() %></strong>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="date-badge">
                            <i class="far fa-calendar-alt"></i> <%= sdf.format(loc.getId().getDateDebut()) %>
                        </span>
                    </td>
                    <td>
                        <span class="date-badge">
                            <i class="far fa-calendar-alt"></i> <%= sdf.format(loc.getDateFin()) %>
                        </span>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <div class="no-rentals">
            <i class="far fa-folder-open"></i>
            <p>Aucune location trouvée.</p>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>