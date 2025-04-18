<%-- 
    Document   : users
    Created on : 16 avr. 2025, 21:52:59
    Author     : hibaa
--%>

<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                background: url('images/liste.png') no-repeat center center fixed;
                background-size: cover; 
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            fieldset {
                border: none;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 900px;
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
                background-color:  #c92843;
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
                
                fieldset {
                    padding: 20px;
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
        <fieldset>
            <legend>Liste des clients</legend>
            
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
                        if(users != null && !users.isEmpty()) {
                            for(User u : users){
                    %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getNom() %></td>
                        <td><%= u.getPrenom() %></td>
                        <td><%= u.getEmail() %></td>
                        <td class="actions-container">
                            <a href="../UserController?id=<%= u.getId()%>&op=delete">Supprimer</a>
                            <a href="../UserController?id=<%= u.getId()%>&op=update">Modifier</a>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="empty-message">Aucun étudiant trouvé</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
            <a href="user.jsp" class="add-button">Ajouter un étudiant</a>
        </fieldset>
    </body>
</html>