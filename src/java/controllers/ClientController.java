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
import services.ClientService;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "ClientController", urlPatterns = {"/ClientController"})
public class ClientController extends HttpServlet {

    private ClientService cs;

    @Override
    public void init() throws ServletException {
        super.init();
        cs = new ClientService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null) {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                cs.create(new Client(cin, nom, prenom, email, password));
                response.sendRedirect("clients.jsp");
            } else {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                Client c = new Client(cin, nom, prenom, email, password);
                c.setId(Integer.parseInt(id));
                cs.update(c);

                request.setAttribute("id", c.getId());
                request.setAttribute("cin", c.getCin());
                request.setAttribute("nom", c.getNom());
                request.setAttribute("prenom", c.getPrenom());
                request.setAttribute("email", c.getEmail());

                request.getRequestDispatcher("/clients.jsp").forward(request, response);  
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            cs.delete(cs.findById(Integer.parseInt(id)));

            response.sendRedirect("clients.jsp");
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Client c = cs.findById(Integer.parseInt(id));

            request.setAttribute("id", c.getId());
            request.setAttribute("nom", c.getNom());
            request.setAttribute("cin", c.getCin());
            request.setAttribute("prenom", c.getPrenom());
            request.setAttribute("email", c.getEmail());

            request.getRequestDispatcher("/clients.jsp").forward(request, response);
        }
    }
}

