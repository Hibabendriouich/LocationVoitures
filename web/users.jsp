<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liste des Clients</title>
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
                transition: background-color 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #444;
            }

            .main-content {
                flex: 1;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .main-content h1 {
                margin-bottom: 20px;
                color: #333;
            }

            fieldset {
                border: none;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            legend {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                padding: 0 10px;
                margin-bottom: 20px;
                position: relative;
            }

            legend::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #c92843;
                margin-top: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            th {
                background-color: #f8f9fa;
                font-weight: 600;
                color: #444;
                position: sticky;
                top: 0;
            }

            tbody tr:hover {
                background-color: #f9f9f9;
            }

            tbody tr:last-child td {
                border-bottom: none;
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

            .empty-message {
                text-align: center;
                padding: 20px;
                color: #666;
                font-style: italic;
            }

            .actions-container {
                display: flex;
                gap: 8px;
            }

            .add-button {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                margin-top: 20px;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .add-button:hover {
                background-color: #3e9142;
            }

            @media (max-width: 768px) {
                table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                .sidebar {
                    width: 200px;
                }

                .main-content {
                    padding: 15px;
                }

                th, td {
                    padding: 10px;
                }

                a {
                    padding: 6px 10px;
                    font-size: 13px;
                }
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="sidebar-logo">
            <h2>Admin Dashboard</h2>
            <a href="users.jsp">Liste des clients</a>
            <a href="graphe.jsp" class="btn btn-primary">Statistiques de voitures </a>
        </div>


        <div class="main-content">
            <h1>Liste des Clients</h1>

            <fieldset>
                <legend>Liste des Clients</legend>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            UserService us = new UserService();
                            java.util.List<User> users = us.findAll();
                            if (users != null && !users.isEmpty()) {
                                for (User u : users) {
                        %>
                        <tr>
                            <td><%= u.getId()%></td>
                            <td><%= u.getNom()%></td>
                            <td><%= u.getPrenom()%></td>
                            <td><%= u.getEmail()%></td>
                            <td class="actions-container">
                                <a href="<%= request.getContextPath() + "/UserController?id=" + u.getId() + "&op=delete"%>">Supprimer</a>
                                <a href="<%= request.getContextPath() + "/UserController?id=" + u.getId() + "&op=update"%>">Modifier</a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="empty-message">Aucun client trouvé</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </fieldset>
            <input type="hidden" name="source" value="<%= request.getParameter("admin") != null ? "admin" : "client" %>">
            <a href="Inscription.jsp?admin=true" class="add-button">Ajouter un client</a>


        </div>
    </body>
</html> 