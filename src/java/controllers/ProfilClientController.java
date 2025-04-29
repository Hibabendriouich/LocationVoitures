package controllers;

import dao.LocationDao;
import entities.Client;
import entities.Location;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ProfilClientController", urlPatterns = {"/ProfilClientController"})
public class ProfilClientController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("client");

        if (client != null) {
            LocationDao locationDao = new LocationDao();
            List<Location> locations = locationDao.getLocationsByClient(client.getId());

            request.setAttribute("locations", locations);
            request.getRequestDispatcher("profil.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Session expirée");
            request.getRequestDispatcher("Authentification.jsp").forward(request, response);
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
}
