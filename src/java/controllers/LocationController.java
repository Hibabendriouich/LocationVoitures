package controllers;

import dao.LocationDao;
import entities.Client;
import entities.Location;
import entities.LocationPK;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LocationController", urlPatterns = {"/LocationController"})
public class LocationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int voiture = Integer.parseInt(request.getParameter("voiture"));
    String dateDebut = request.getParameter("dateDebut");
    String dateFin = request.getParameter("dateFin");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if(action != null && action.equals("historique")) {
            afficherHistorique(request, response);
        } else {
            creerLocation(request, response);
        }
    }

    private void afficherHistorique(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    Client client = (Client) session.getAttribute("client");
    
    if (client == null) {
        response.sendRedirect(request.getContextPath() + "/Authentification.jsp");
        return;
    }
    
    try {
        LocationDao locationDao = new LocationDao();
        List<Location> locations = locationDao.getLocationsByClient(client.getId());
        
        request.setAttribute("locations", locations);
        request.getRequestDispatcher(request.getContextPath() + "/historiqueLocations.jsp")
               .forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    }
}

    private void creerLocation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("client");
        
        if (client == null) {
            response.sendRedirect(request.getContextPath() + "/Authentification.jsp");
            return;
        }
        
        try {
            int voiture = Integer.parseInt(request.getParameter("voiture"));
            Date dateDebut = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateDebut"));
            Date dateFin = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateFin"));
            
            if (dateFin.before(dateDebut)) {
                session.setAttribute("error", "La date de fin doit être après la date de début");
                response.sendRedirect("profil.jsp");

                return;
            }
            
            LocationDao locationDao = new LocationDao();
            if (locationDao.isCarAvailable(voiture, dateDebut, dateFin)) {
                LocationPK pk = new LocationPK(client.getId(), voiture, dateDebut);
                Location location = new Location(pk, dateFin);
                
                if (locationDao.create(location)) {
                    session.setAttribute("success", "Location effectuée avec succès!");
                } else {
                    session.setAttribute("error", "Erreur lors de la création de la location");
                }
            } else {
                session.setAttribute("error", "La voiture n'est pas disponible pour cette période");
            }
            
            response.sendRedirect("profil.jsp");

            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Erreur technique: " + e.getMessage());
            response.sendRedirect("profil.jsp");

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
        return "Location Controller";
    }
}