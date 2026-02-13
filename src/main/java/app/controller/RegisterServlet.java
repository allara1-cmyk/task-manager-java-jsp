package app.controller;

import app.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirm");

        String error = validate(username, password, confirm);
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        try {
            boolean created = userDAO.createUser(username.trim(), password);

            if (!created) {
                req.setAttribute("error", "Username already exists.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            // mensaje flash y vuelve al login
            req.getSession().setAttribute("flash_success", "Account created. Please login.");
            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String validate(String username, String password, String confirm) {
        if (username == null || username.trim().length() < 3) return "Username min 3 characters.";
        if (username.length() > 50) return "Username max 50 characters.";
        if (password == null || password.length() < 6) return "Password min 6 characters.";
        if (!password.equals(confirm)) return "Passwords do not match.";
        return null;
    }
}
