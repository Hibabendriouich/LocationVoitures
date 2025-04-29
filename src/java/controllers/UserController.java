/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.UserService;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        String id = request.getParameter("id");

        if (op == null) {
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String pwd = request.getParameter("pwd");

            if (id == null || id.isEmpty()) {
                if (nom != null && prenom != null && email != null && pwd != null
                        && !nom.isEmpty() && !prenom.isEmpty() && !email.isEmpty() && !pwd.isEmpty()) {
                    us.create(new User(nom, prenom, email, pwd));
                    String source = request.getParameter("source");

                    if ("admin".equals(source)) {
                        response.sendRedirect("users.jsp");
                    } else {
                        response.sendRedirect("Authentification.jsp");
                    }

                } else {
                    request.getRequestDispatcher("Inscription.jsp").forward(request, response);
                }
            } else {
                User u = new User(nom, prenom, email, pwd);
                u.setId(Integer.parseInt(id));
                us.update(u);
                request.getRequestDispatcher("users.jsp").forward(request, response);
            }

        } else if ("delete".equals(op)) {
            if (id != null && !id.isEmpty()) {
                us.delete(us.findById(Integer.parseInt(id)));
            }
            request.getRequestDispatcher("users.jsp").forward(request, response);

        } else if ("update".equals(op)) {
            if (id != null && !id.isEmpty()) {
                User u = us.findById(Integer.parseInt(id));
                request.setAttribute("user", u);
                request.getRequestDispatcher("updateUser.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("users.jsp").forward(request, response);
            }

        } else {
            request.getRequestDispatcher("users.jsp").forward(request, response);
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
        return "User Controller Servlet";
    }
}
