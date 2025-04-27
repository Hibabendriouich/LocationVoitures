<%@ page import="java.util.List" %>
<%@ page import="entities.Location" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
    </style>
</head>
<body>
    <h1>Historique de mes locations</h1>

    <%
        // Récupérer la liste des locations
        List<Location> locations = (List<Location>) request.getAttribute("locations");

        // Format de la date
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        if (locations != null && !locations.isEmpty()) {
    %>
        <table>
            <thead>
                <tr>
                    <th>Voiture</th>
                    <th>Date début</th>
                    <th>Date fin</th>
                    <th>Prix total</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Afficher chaque location
                    for (Location loc : locations) {
                %>
                    <tr>
                        <td><%= loc.getVoiture().getMarque() %> <%= loc.getVoiture().getModele() %></td>
                        <td><%= sdf.format(loc.getDateDebut()) %></td>
                        <td><%= sdf.format(loc.getDateFin()) %></td>
                    </tr>
                <%
                    }
                %>
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
