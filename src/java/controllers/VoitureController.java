/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;
import dao.VoitureDao;
import entities.Voiture;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author hibaa
 */

@WebServlet(name = "VoitureController", urlPatterns = {"/VoitureController"})
public class VoitureController extends HttpServlet {

    private VoitureDao voitureDao;

    @Override
    public void init() throws ServletException {
        voitureDao = new VoitureDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Voiture> listeVoitures = voitureDao.getAllVoitures();

        request.setAttribute("listeVoitures", listeVoitures);

        request.getRequestDispatcher("/clients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); 
    }
}

