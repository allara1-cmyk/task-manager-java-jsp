package app.controller;

import app.dao.UserDAO;
import app.model.User;
import app.util.Flash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class AuthServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User u = userDAO.findByCredentials(username, password);
            if (u == null) {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("user", u.getUsername());
            Flash.success(session, "Welcome, " + u.getUsername() + ".");
            resp.sendRedirect(req.getContextPath() + "/tasks"); // PRG
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
