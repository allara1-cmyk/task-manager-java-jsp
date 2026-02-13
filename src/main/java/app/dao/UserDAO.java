package app.dao;

import app.config.ConexionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean createUser(String username, String rawPassword) throws Exception {
        if (existsByUsername(username)) return false;

        String sql = "INSERT INTO users(username, password_hash) VALUES (?, SHA2(?, 256))";

        try (Connection cn = ConexionDB.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, rawPassword);
            return ps.executeUpdate() == 1;
        }
    }

    

    public boolean existsByUsername(String username) throws Exception {
        String sql = "SELECT 1 FROM users WHERE username = ? LIMIT 1";
        try (Connection cn = ConexionDB.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Ejemplo de login (si no lo tienes o para validar que coincide con SHA2)
    public boolean validCredentials(String username, String rawPassword) throws Exception {
        String sql = "SELECT 1 FROM users WHERE username = ? AND password_hash = SHA2(?, 256) LIMIT 1";

        try (Connection cn = ConexionDB.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, rawPassword);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true si existe un usuario con esas credenciales
            }
        }
    }
}
