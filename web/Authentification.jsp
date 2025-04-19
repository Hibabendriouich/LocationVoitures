<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Authentification</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background: url('images/bg.png') no-repeat center center fixed;
                background-size: cover;
                min-height: 100vh;
                font-family: 'Segoe UI', sans-serif;
                position: relative;
            }

            .form-wrapper {
                position: absolute;
                top: 50%;
                margin-left: 100px;
                transform: translateY(-50%);
                width: 700px;
                max-width: 90%;
            }

            .card {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
                backdrop-filter: blur(6px);
                background-color: rgba(255, 255, 255, 0.9);
            }

            .card-header {
                background-color: #6f42c1;
                color: white;
            }

            .form-control:focus {
                border-color: #6f42c1;
                box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
            }

            .btn-primary {
                background-color: #6f42c1;
                border: none;
            }

            .btn-primary:hover {
                background-color: #5931a9;
            }

            a {
                text-decoration: none;
                color: #6f42c1;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <style>
        body {
            background: url('images/bg.png') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            position: relative;
        }

        .form-wrapper {
            position: absolute;
            top: 50%;
            left: 70px; 
            transform: translateY(-50%);
            width: 400px;
            max-width: 90%;
        }

        .card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(6px);
            background-color: rgba(255, 255, 255, 0.9);
        }

        .card-header {
            background-color: #6f42c1;
            color: white;
        }

        .form-control:focus {
            border-color: #6f42c1;
            box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
        }

        .btn-primary {
            background-color: #6f42c1;
            border: none;
        }

        .btn-primary:hover {
            background-color: #5931a9;
        }

        a {
            text-decoration: none;
            color: #6f42c1;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>

    <body>
        <div class="form-wrapper">
            <div class="card">
                <div class="card-header text-center">
                    <h4><i class="bi bi-person-circle me-2"></i>Authentification</h4>
                </div>
                <div class="card-body">
                   <form action="/locationVoitures/AuthentificationController" method="post">

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Mot de passe</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </div>
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Connexion
                            </button>
                        </div>
                        <div class="d-flex justify-content-between">
                            <a href="forgotPassword.jsp">Mot de passe oublié</a>
                            <a href="Inscription.jsp">Créer un compte</a>
                        </div>
                        <% if (request.getParameter("msg") != null) {%>
                        <div class="mt-3 text-danger text-center">
                            <%= request.getParameter("msg")%>
                        </div>
                        <% }%>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
