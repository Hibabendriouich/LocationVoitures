<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    User user = (User) session.getAttribute("admin");
if (user == null) {
    response.sendRedirect("Authentification.jsp");
    return;
}

%>

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
    <title>Liste des Clients | Luxury Drive</title>
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
            width: auto;
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
        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .data-table thead th {
            background-color: var(--primary);
            color: white;
            padding: 16px 20px;
            text-align: left;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }
        
        .data-table tbody tr {
            transition: all 0.2s ease;
        }
        
        .data-table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .data-table tbody td {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .actions-container {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
        }
        
        .action-btn i {
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        .delete-btn {
            background-color: var(--secondary);
            color: white;
        }
        
        .delete-btn:hover {
            background-color: #c0392b;
        }
        
        .update-btn {
            background-color: #FFCC00;
            color: #333;
        }
        
        .update-btn:hover {
            background-color: #e6b800;
        }
        
        .add-btn {
            background-color: var(--success);
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            margin-top: 20px;
            transition: all 0.2s ease;
        }
        
        .add-btn i {
            margin-right: 8px;
        }
        
        .add-btn:hover {
            background-color: #219653;
            transform: translateY(-2px);
        }
        
        .empty-message {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .empty-message i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-message p {
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
            
            .data-table {
                display: block;
                overflow-x: auto;
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
            <a href="graphe.jsp" class="sidebar-link">
                <i class="fas fa-chart-bar"></i> Statistiques
            </a>
            <a href="DeconnexionController" class="sidebar-link">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </div>
    </div>

    <div class="main-content">
        <h1>Liste des Clients</h1>
        
        <table class="data-table">
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
                        <a href="<%= request.getContextPath() + "/UserController?id=" + u.getId() + "&op=delete"%>" class="action-btn delete-btn">
                            <i class="fas fa-trash-alt"></i> Supprimer
                        </a>
                        <a href="<%= request.getContextPath() + "/UserController?id=" + u.getId() + "&op=update"%>" class="action-btn update-btn">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">
                        <div class="empty-message">
                            <i class="fas fa-user-slash"></i>
                            <p>Aucun client trouvé</p>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <a href="Inscription.jsp?admin=true" class="add-btn">
            <i class="fas fa-plus"></i> Ajouter un client
        </a>
        
        <input type="hidden" name="source" value="<%= request.getParameter("admin") != null ? "admin" : "client"%>">
    </div>
</body>
</html>