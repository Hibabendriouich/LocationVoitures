package controllers;

import com.google.gson.Gson;
import dao.LocationDao;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LocationTypeStatController", urlPatterns = {"/LocationTypeStatController"})
public class LocationTypeStatController extends HttpServlet {

    private final LocationDao dao = new LocationDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Object[]> resultats = dao.countLocationsByType();
            List<Map<String, Object>> stats = new ArrayList<>();

            for (Object[] ligne : resultats) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("typeVoiture", ligne[0]);
                stat.put("locationCount", ligne[1]);
                stats.add(stat);
            }

            String json = new Gson().toJson(stats);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
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