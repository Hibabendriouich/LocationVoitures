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
        ClientService cl = new ClientService();
        
        if (password.equals(passwordcnf)) {
            HttpSession session = request.getSession();
            Client c = (Client) session.getAttribute("client");
            c.setPassword(Util.md5(password));
            cl.update(c);
            
            request.setAttribute("email", c.getEmail());
            request.getRequestDispatcher("Authentification.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Mot de passe incorrect");
            request.getRequestDispatcher("updateMotdePasse.jsp").forward(request, response);
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