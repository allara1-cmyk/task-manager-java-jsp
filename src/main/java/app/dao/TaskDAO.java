package app.dao;

import app.config.ConexionDB;
import app.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public List<Task> findAllOrdered() throws Exception {
        String sql = """
            SELECT * FROM tasks
            ORDER BY 
              CASE WHEN is_done = 0 THEN 0 ELSE 1 END,
              CASE WHEN is_done = 0 AND due_date IS NOT NULL THEN 0 ELSE 1 END,
              due_date ASC,
              id DESC
        """;

        List<Task> out = new ArrayList<>();
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) out.add(map(rs));
        }
        return out;
    }

    public Task findById(int id) throws Exception {
        String sql = "SELECT * FROM tasks WHERE id=?";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public void insert(Task t) throws Exception {
        String sql = "INSERT INTO tasks(title, description, is_done, due_date) VALUES(?,?,?,?)";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getTitle());
            ps.setString(2, t.getDescription());
            ps.setBoolean(3, t.isDone());
            if (t.getDueDate() == null) ps.setNull(4, Types.DATE);
            else ps.setDate(4, t.getDueDate());
            ps.executeUpdate();
        }
    }

    public void update(Task t) throws Exception {
        String sql = "UPDATE tasks SET title=?, description=?, is_done=?, due_date=? WHERE id=?";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getTitle());
            ps.setString(2, t.getDescription());
            ps.setBoolean(3, t.isDone());
            if (t.getDueDate() == null) ps.setNull(4, Types.DATE);
            else ps.setDate(4, t.getDueDate());
            ps.setInt(5, t.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws Exception {
        String sql = "DELETE FROM tasks WHERE id=?";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Task map(ResultSet rs) throws Exception {
        Task t = new Task();
        t.setId(rs.getInt("id"));
        t.setTitle(rs.getString("title"));
        t.setDescription(rs.getString("description"));
        t.setDone(rs.getBoolean("is_done"));
        t.setDueDate(rs.getDate("due_date"));
        t.setCreatedAt(rs.getTimestamp("created_at"));
        t.setUpdatedAt(rs.getTimestamp("updated_at"));
        return t;
    }
}
