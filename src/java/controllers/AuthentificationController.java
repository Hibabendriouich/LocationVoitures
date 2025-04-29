/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Admin;
import entities.Client;
import entities.User;
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

/**
 *
 * @author hibaa
 */
@WebServlet(name = "AuthentificationController", urlPatterns = {"/AuthentificationController"})
public class AuthentificationController extends HttpServlet {

    private UserService us;
    private AdminService as;
    private ClientService cs;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        as = new AdminService();
        cs = new ClientService();

        Admin admin = as.findAdminByEmail(email);
        if (admin != null) {
            if (admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                request.getRequestDispatcher("users.jsp").forward(request, response);
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
                request.getRequestDispatcher("VoitureController").forward(request, response);
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
        return "Short description";
    }
}
