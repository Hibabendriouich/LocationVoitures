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
import services.SendMail;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "Mdob", urlPatterns = {"/Mdob"})
public class Mdob extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        ClientService cl = new ClientService();
        Client c = cl.findClientByEmail(email);
        
        if (c != null) {
            String code = String.format("%06d", (int) (Math.random() * 1000000));

            HttpSession session = request.getSession();
            session.setAttribute("client", c);
            session.setAttribute("code_verification", code);

            SendMail sed = new SendMail();
            sed.send(code, email);

            response.sendRedirect("verification.jsp");
        } else {
            response.sendRedirect("forgotPassword.jsp?msg=Email n’existe pas");
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
