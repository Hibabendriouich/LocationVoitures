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
import util.Util;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "AuthentificationController", urlPatterns = {"/AuthentificationController"})
public class AuthentificationController extends HttpServlet {

    private UserService us;
    private AdminService adminService;
    private ClientService clientService;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminService as = new AdminService();
        ClientService cs = new ClientService();

        Admin admin = as.findAdminByEmail(email);
        if (admin != null) {
            if (admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                response.sendRedirect("users.jsp");
                return;
            } else {
                response.sendRedirect("Authentification.jsp?msg=Mot de passe incorrect");
                return;
            }
        }

        Client client = cs.findClientByEmail(email);
        if (client != null) {
            if (client.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("client", client);
                response.sendRedirect("clients.jsp");
                return;
            } else {
                response.sendRedirect("Authentification.jsp?msg=Mot de passe incorrect");
                return;
            }
        }

        response.sendRedirect("Authentification.jsp?msg=Email introuvable");
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
