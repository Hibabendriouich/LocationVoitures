package controllers;

import dao.LocationDao;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entities.Location;
import entities.Client;
import services.LocationService;

@WebServlet(name = "LocationController", urlPatterns = {"/LocationController"})
public class LocationController extends HttpServlet {

    private LocationService locationService;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if(action != null && action.equals("historique")) {
            afficherHistorique(request, response);
        } else {
            response.sendRedirect("clients.jsp");
        }
    }

    private void afficherHistorique(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("client");
        
        if (client == null) {
            response.sendRedirect("Authentification.jsp");
            return;
        }
        
        LocationDao locationDao = new LocationDao();
            List<Location> locations = locationDao.getLocationsByClient(client.getId());
        
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("/historiqueLocations.jsp").forward(request, response);
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