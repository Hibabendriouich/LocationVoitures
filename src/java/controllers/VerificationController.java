/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

/**
 *
 * @author hibaa
 */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VerificationController", urlPatterns = {"/Verfier"})
public class VerificationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        HttpSession session = request.getSession();
        String codeStocke = (String) session.getAttribute("code_verification");
        String codeSaisi = request.getParameter("code");

        if (codeStocke != null && codeStocke.equals(codeSaisi)) {
            response.sendRedirect("updateMotdePasse.jsp");
        } else {
            request.setAttribute("msg", "Code de vérification incorrect");
            request.getRequestDispatcher("verification.jsp").forward(request, response);
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
        return "Contrôleur de vérification du code de réinitialisation";
    }
}
