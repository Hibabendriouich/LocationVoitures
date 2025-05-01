package controllers;

import entities.Client;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.ClientService;
import util.Util;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "UpdatePasswordController", urlPatterns = {"/UpdatePasswordController"})
public class UpdatePasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String password = request.getParameter("password");
        String passwordcnf = request.getParameter("passwordcnf");
        ClientService cs = new ClientService();
        
        // Vérification des champs vides
        if (password == null || passwordcnf == null || password.isEmpty() || passwordcnf.isEmpty()) {
            request.setAttribute("msg", "Veuillez remplir tous les champs");
            RequestDispatcher dispatcher = request.getRequestDispatcher("updateMotdePasse.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        if (password.equals(passwordcnf)) {
            HttpSession session = request.getSession();
            Client c = (Client) session.getAttribute("client");
            String email = null;
            
            if (c == null) {
                email = (String) session.getAttribute("reset_email");
                if (email != null) {
                    c = cs.findClientByEmail(email);
                    if (c == null) {
                        request.setAttribute("msg", "Utilisateur non trouvé");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                } else {
                    Client sessionClient = (Client) session.getAttribute("client");
                    if (sessionClient != null) {
                        email = sessionClient.getEmail();
                        c = cs.findClientByEmail(email);
                    }
                    
                    if (c == null) {
                        response.sendRedirect(request.getContextPath() + "/login.jsp");
                        return;
                    }
                }
            }
            
            c.setPassword(password);
            boolean updateSuccess = cs.update(c);
            
            if (!updateSuccess) {
                request.setAttribute("msg", "Échec de la mise à jour du mot de passe");
                RequestDispatcher dispatcher = request.getRequestDispatcher("updateMotdePasse.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            if (session.getAttribute("client") != null) {
                session.setAttribute("client", c);
            }
            
            session.removeAttribute("reset_email");
            session.removeAttribute("code_verification");
            
            request.setAttribute("successMessage", "Mot de passe mis à jour avec succès");
            request.setAttribute("email", c.getEmail());
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("msg", "Les mots de passe ne correspondent pas");
            RequestDispatcher dispatcher = request.getRequestDispatcher("updateMotdePasse.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Update Password Controller";
    }
}