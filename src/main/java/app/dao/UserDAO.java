package app.dao;

import app.config.ConexionDB;
import app.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User findByCredentials(String username, String passwordPlain) throws Exception {
        String sql = "SELECT id, username FROM users WHERE username=? AND password_hash = SHA2(?, 256)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, passwordPlain);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("id"), rs.getString("username"));
                }
                return null;
            }
        }
    }
}
