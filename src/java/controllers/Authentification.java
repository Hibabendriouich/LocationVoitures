/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Client;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.ClientService;
import services.UserService;
import util.Util;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "Authentification", urlPatterns = {"/Authentification"})
public class Authentification extends HttpServlet {
    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init(); 
        us = new UserService();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        ClientService cs = new ClientService();
        Client c = cs.findClientByEmail(email);
        
        if (c != null) {
            if (c.getPassword().equals(Util.md5(password))) {
                HttpSession session = request.getSession();
                session.setAttribute("client", c);
                cs.update(c);
                response.sendRedirect("welcome.jsp");
            } else {
                response.sendRedirect("Authentification.jsp?msg=mot de passe incorrect");
            }
        } else {
            response.sendRedirect("Authentification.jsp?msg=Email introvable");
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
        return "Short description";
    }

}
