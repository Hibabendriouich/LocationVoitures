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

@WebServlet(name = "InscriptionController", urlPatterns = {"/InscriptionController"})
public class InscriptionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ClientService cs = new ClientService();

        String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("pwd");

                Client nouvelUtilisateur = new Client(cin, nom, prenom, email, password);
                cs.create(nouvelUtilisateur);

                String source = request.getParameter("source");
                if ("admin".equals(source)) {
                    request.getRequestDispatcher("users.jsp").forward(request, response);
                } else {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", nouvelUtilisateur);
                    response.sendRedirect("Authentification.jsp");
                }

            } else {
                String cin = request.getParameter("cin");
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("pwd");
                Client u = new Client(cin, nom, prenom, email, password);
                u.setId(Integer.parseInt(id));
                cs.update(u);
                request.getRequestDispatcher("users.jsp").forward(request, response);
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            cs.delete(cs.findById(Integer.parseInt(id)));
            request.getRequestDispatcher("users.jsp").forward(request, response);
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Client u = cs.findById(Integer.parseInt(id));
            request.setAttribute("user", u);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
