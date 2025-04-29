/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.AdminService;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    private AdminService as;

    @Override
    public void init() throws ServletException {
        super.init();
        as = new AdminService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null) {
                String matricule = request.getParameter("matricule");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                as.create(new Admin(matricule, nom, prenom, email, password));

                request.getRequestDispatcher("admins/page.jsp").forward(request, response);
            } else {
                String matricule = request.getParameter("matricule");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                Admin a = new Admin(matricule, nom, prenom, email, password);
                a.setId(Integer.parseInt(id));
                as.update(a);

                request.getRequestDispatcher("admins/page.jsp").forward(request, response);
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            as.delete(as.findById(Integer.parseInt(id)));

            request.getRequestDispatcher("admins/page.jsp").forward(request, response);
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Admin a = as.findById(Integer.parseInt(id));

            request.setAttribute("id", a.getId());
            request.setAttribute("matricule", a.getMatricule());
            request.setAttribute("nom", a.getNom());

            request.getRequestDispatcher("admins/page.jsp").forward(request, response);
        }

    }
}
