/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
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
@WebServlet(name = "InscriptionController", urlPatterns = {"/InscriptionController"})
public class InscriptionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ClientService cs = new ClientService();

        String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("mdp");
                cs.create(new Client(cin, nom, prenom, email, password));
                response.sendRedirect("Authentification.jsp");
            } else {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("mdp");
                Client u = new Client(cin, nom, prenom, email, password);
                u.setId(Integer.parseInt(id));
                cs.update(u);
                response.sendRedirect("users.jsp");
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            cs.delete(cs.findById(Integer.parseInt(id)));
            response.sendRedirect("users.jsp");
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Client u = cs.findById(Integer.parseInt(id));
            response.sendRedirect("Authentification.jsp?id=" + u.getId() + "&nom=" + u.getNom() + "&prenom=" + u.getPrenom() + "&email=" + u.getEmail() + "&mdp=" + u.getPassword());
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
