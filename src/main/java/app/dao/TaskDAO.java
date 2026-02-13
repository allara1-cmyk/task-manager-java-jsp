package app.dao;

import app.config.ConexionDB;
import app.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    // Método existente - listar todas ordenadas
    public List<Task> findAllOrdered() throws SQLException {
        String sql = "SELECT * FROM tasks ORDER BY is_done ASC, due_date ASC, id DESC";
        List<Task> tasks = new ArrayList<>();
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        }
        return tasks;
    }

    // NUEVO - Buscar tareas por título o descripción
    public List<Task> searchTasks(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE title LIKE ? OR description LIKE ? " +
                     "ORDER BY is_done ASC, due_date ASC, id DESC";
        List<Task> tasks = new ArrayList<>();
        String searchPattern = "%" + searchTerm + "%";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(mapTask(rs));
                }
            }
        }
        return tasks;
    }

    // Método existente - buscar por ID
    public Task findById(int id) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE id = ?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapTask(rs);
                }
            }
        }
        return null;
    }

    // Método existente - insertar tarea
    public void insert(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (title, description, is_done, due_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setBoolean(3, task.isDone());
            stmt.setDate(4, task.getDueDate());
            
            stmt.executeUpdate();
        }
    }

    // Método existente - actualizar tarea
    public void update(Task task) throws SQLException {
        String sql = "UPDATE tasks SET title = ?, description = ?, is_done = ?, due_date = ? WHERE id = ?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setBoolean(3, task.isDone());
            stmt.setDate(4, task.getDueDate());
            stmt.setInt(5, task.getId());
            
            stmt.executeUpdate();
        }
    }

    // Método existente - eliminar tarea
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id = ?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Helper method para mapear ResultSet a Task
    private Task mapTask(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setId(rs.getInt("id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setDone(rs.getBoolean("is_done"));
        task.setDueDate(rs.getDate("due_date"));
        return task;
    }
}