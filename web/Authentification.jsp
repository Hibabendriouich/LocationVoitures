<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Connexion</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background: url('images/ins.png') no-repeat center center fixed;
                background-size: cover;
                min-height: 100vh;
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-container {
                background-color: white;
                border-radius: 20px;
                display: flex;
                width: 900px;
                max-width: 95%;
                overflow: hidden;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            }

            .login-left {
                background: linear-gradient(135deg, #9b1d34, #c92843);
                color: white;
                flex: 1;
                padding: 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                text-align: center;
            }

            .login-left h2 {
                font-weight: bold;
                margin-bottom: 10px;
            }

            .login-left p {
                font-size: 0.9rem;
            }

            .login-right {
                flex: 1;
                padding: 40px;
            }

            .form-control:focus {
                border-color: #c92843;
                box-shadow: 0 0 0 0.2rem rgba(201, 40, 67, 0.25);
            }

            .btn-primary {
                background-color: #c92843;
                border: none;
                transition: background-color 0.3s;
            }

            .btn-primary:hover {
                background-color: #a91f35;
            }

            .btn-outline-secondary {
                border-color: #c92843;
                color: #c92843;
            }

            .btn-outline-secondary:hover {
                background-color: #c92843;
                color: white;
            }

            .small-text {
                font-size: 0.875rem;
            }

            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 20px 0;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                border-bottom: 1px solid #ccc;
            }

            .divider:not(:empty)::before {
                margin-right: 0.75em;
            }

            .divider:not(:empty)::after {
                margin-left: 0.75em;
            }

            a {
                color: #c92843;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="login-left">
                <h2>Bienvenue chez BdRide</h2>
                <p>Louez la voiture parfaite en quelques clics.</p>
                <p>Connectez-vous pour accéder à vos réservations, gérer vos locations, et explorer notre large gamme de véhicules.</p>
                <div class="mt-4">
                    <i class="bi bi-car-front" style="font-size: 3rem;"></i>
                </div>
            </div>
            <div class="login-right">
                <h4 class="mb-4 text-center">Connexion</h4>
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

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label small-text" for="remember">Se souvenir de moi</label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Connexion
                        </button>
                    </div>

                    <div class="divider">ou</div>

                    <div class="d-grid mb-3">
                        <button type="button" class="btn btn-outline-secondary">
                            <a href="forgotPassword.jsp" class="text-center" style="color: black;">Mot de passe oublié ?</a>

                        </button>
                    </div>

                    <div class="text-center small-text">
                        Vous n'avez pas de compte ?
                        <a href="Inscription.jsp">Créer un compte</a>
                    </div>

                    <% if (request.getAttribute("msg") != null) {%>
                    <div class="mt-3 text-danger text-center">
                        <%= request.getAttribute("msg")%>
                    </div>
                    <% }%>

                </form>
            </div>
        </div>

    </body>
</html>
