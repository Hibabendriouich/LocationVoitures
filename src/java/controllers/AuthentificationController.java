package controllers;

import entities.Admin;
import entities.Client;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.AdminService;
import services.ClientService;
import services.UserService;

@WebServlet(name = "AuthentificationController", urlPatterns = {"/AuthentificationController"})
public class AuthentificationController extends HttpServlet {

    private UserService us;
    private AdminService as;
    private ClientService cs;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
        as = new AdminService();
        cs = new ClientService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // If no credentials provided, check for existing session
        if (email == null || password == null) {
            checkExistingSession(request, response);
            return;
        }

        // Authentication logic
        Admin admin = as.findAdminByEmail(email);
        if (admin != null) {
            if (admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                response.sendRedirect("users.jsp");
                return;
            } else {
                request.setAttribute("msg", "Mot de passe incorrect");
                request.getRequestDispatcher("Authentification.jsp").forward(request, response);
                return;
            }
        }

        Client client = cs.findClientByEmail(email);
        if (client != null) {
            if (client.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("client", client);
                response.sendRedirect("VoitureController");
                return;
            } else {
                request.setAttribute("msg", "Mot de passe incorrect");
                request.getRequestDispatcher("Authentification.jsp").forward(request, response);
                return;
            }
        }

        request.setAttribute("msg", "Email introuvable");
        request.getRequestDispatcher("Authentification.jsp").forward(request, response);
    }

    private void checkExistingSession(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            if (session.getAttribute("admin") != null) {
                response.sendRedirect("users.jsp");
                return;
            } else if (session.getAttribute("client") != null) {
                response.sendRedirect("VoitureController");
                return;
            }
        }
        
        response.sendRedirect("Authentification.jsp");
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
        return "Authentication Controller";
    }
}