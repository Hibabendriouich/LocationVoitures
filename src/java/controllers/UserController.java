package controllers;

import entities.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.UserService;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session validation
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("admin") == null && session.getAttribute("client") == null)) {
            response.sendRedirect("Authentification.jsp");
            return;
        }

        String op = request.getParameter("op");
        String id = request.getParameter("id");

        if (op == null) {
            handleCreateOrUpdate(request, response);
        } else {
            switch (op) {
                case "delete":
                    handleDelete(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                default:
                    request.getRequestDispatcher("users.jsp").forward(request, response);
            }
        }
    }

    private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            if (validateUserInput(nom, prenom, email, pwd)) {
                us.create(new User(nom, prenom, email, pwd));
                String source = request.getParameter("source");
                response.sendRedirect("admin".equals(source) ? "users.jsp" : "Authentification.jsp");
            } else {
                request.getRequestDispatcher("Inscription.jsp").forward(request, response);
            }
        } else {
            User u = new User(nom, prenom, email, pwd);
            u.setId(Integer.parseInt(id));
            us.update(u);
            request.getRequestDispatcher("users.jsp").forward(request, response);
        }
    }

    private boolean validateUserInput(String nom, String prenom, String email, String pwd) {
        return nom != null && prenom != null && email != null && pwd != null
                && !nom.isEmpty() && !prenom.isEmpty() && !email.isEmpty() && !pwd.isEmpty();
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            us.delete(us.findById(Integer.parseInt(id)));
        }
        request.getRequestDispatcher("users.jsp").forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            User u = us.findById(Integer.parseInt(id));
            request.setAttribute("user", u);
            request.getRequestDispatcher("updateUser.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("users.jsp").forward(request, response);
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
        return "User Controller";
    }
}