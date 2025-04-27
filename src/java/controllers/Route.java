/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Admin;
import entities.Client;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.AdminService;
import services.ClientService;
import services.UserService;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "Route", urlPatterns = {"/Route"})
public class Route extends HttpServlet {

    UserService us;
    ClientService cs;
    AdminService as;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        us = new UserService();
        cs = new ClientService();
        as = new AdminService();
        String page = request.getParameter("page");
        switch (page) {
            case "clients":
                List<Client> client = cs.findAll();
                request.setAttribute("client", client);
                request.getRequestDispatcher("clients.jsp").forward(request, response);
                break;
            case "admin":
                List<Admin> admin = as.findAll();
                request.setAttribute("admin", admin);
                request.getRequestDispatcher("users.jsp").forward(request, response);
                break;
            case "authentification":
                request.getRequestDispatcher("Authentification.jsp").forward(request, response);
                break;
        }
    }
}
