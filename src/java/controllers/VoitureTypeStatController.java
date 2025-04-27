/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.google.gson.Gson;
import dao.VoitureDao;
import entities.TypeVoiture;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mapper.TypeVoitureCount;

/**
 *
 * @author hibaa
 */

@WebServlet(name = "VoitureTypeStatController", urlPatterns = {"/VoitureTypeStatController"})
public class VoitureTypeStatController extends HttpServlet {

    private final VoitureDao dao = new VoitureDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Object[]> resultats = dao.countByType();
        List<TypeVoitureCount> stats = new ArrayList<>();

        for (Object[] ligne : resultats) {
           String typeVoiture = ((TypeVoiture) ligne[0]).getNom();
            Long count = (Long) ligne[1];
            stats.add(new TypeVoitureCount(typeVoiture, count));
        }

        String json = new Gson().toJson(stats);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
}
