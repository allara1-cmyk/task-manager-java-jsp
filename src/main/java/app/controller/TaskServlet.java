package app.controller;

import app.dao.TaskDAO;
import app.model.Task;
import app.util.Flash;
import app.util.Validation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

@WebServlet(urlPatterns = {
        "/tasks",
        "/tasks/new",
        "/tasks/create",
        "/tasks/edit",
        "/tasks/update",
        "/tasks/delete"
})
public class TaskServlet extends HttpServlet {

    private final TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if ("/tasks".equals(path)) {
                req.setAttribute("tasks", taskDAO.findAllOrdered());
                req.getRequestDispatcher("/tasks/index.jsp").forward(req, resp);
                return;
            }

            if ("/tasks/new".equals(path)) {
                req.getRequestDispatcher("/tasks/create.jsp").forward(req, resp);
                return;
            }

            if ("/tasks/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Task t = taskDAO.findById(id);
                if (t == null) {
                    Flash.error(req.getSession(), "Task not found.");
                    resp.sendRedirect(req.getContextPath() + "/tasks");
                    return;
                }
                req.setAttribute("task", t);
                req.getRequestDispatcher("/tasks/edit.jsp").forward(req, resp);
                return;
            }

            resp.sendError(404);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if ("/tasks/create".equals(path)) {
                handleCreate(req, resp);
                return;
            }
            if ("/tasks/update".equals(path)) {
                handleUpdate(req, resp);
                return;
            }
            if ("/tasks/delete".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                taskDAO.delete(id);
                Flash.success(req.getSession(), "Task deleted.");
                resp.sendRedirect(req.getContextPath() + "/tasks"); // PRG
                return;
            }

            resp.sendError(404);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String dueDateStr = req.getParameter("due_date");
        boolean isDone = req.getParameter("is_done") != null; // checkbox rule :contentReference[oaicite:11]{index=11}

        Map<String, String> errors = Validation.validateTask(title, dueDateStr);
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("v_title", title);
            req.setAttribute("v_description", description);
            req.setAttribute("v_due_date", dueDateStr);
            req.setAttribute("v_is_done", isDone);
            req.getRequestDispatcher("/tasks/create.jsp").forward(req, resp);
            return;
        }

        Task t = new Task();
        t.setTitle(title.trim());
        t.setDescription(description == null ? null : description.trim());
        t.setDone(isDone);
        t.setDueDate(parseDateOrNull(dueDateStr));

        taskDAO.insert(t);
        Flash.success(req.getSession(), "Task created.");
        resp.sendRedirect(req.getContextPath() + "/tasks"); // PRG :contentReference[oaicite:12]{index=12}
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String dueDateStr = req.getParameter("due_date");
        boolean isDone = req.getParameter("is_done") != null;

        Map<String, String> errors = Validation.validateTask(title, dueDateStr);
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);

            Task t = new Task();
            t.setId(id);
            t.setTitle(title);
            t.setDescription(description);
            t.setDone(isDone);
            t.setDueDate(parseDateOrNull(dueDateStr));

            req.setAttribute("task", t);
            req.getRequestDispatcher("/tasks/edit.jsp").forward(req, resp);
            return;
        }

        Task t = new Task();
        t.setId(id);
        t.setTitle(title.trim());
        t.setDescription(description == null ? null : description.trim());
        t.setDone(isDone);
        t.setDueDate(parseDateOrNull(dueDateStr));

        taskDAO.update(t);
        Flash.success(req.getSession(), "Task updated.");
        resp.sendRedirect(req.getContextPath() + "/tasks"); // PRG
    }

    private Date parseDateOrNull(String s) {
        if (s == null || s.trim().isEmpty()) return null;
        LocalDate ld = LocalDate.parse(s.trim());
        return Date.valueOf(ld);
    }
}
