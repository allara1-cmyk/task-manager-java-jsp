package app.config;

import java.sql.Connection;
// NO hace falta import app.config.ConexionDB si están en el mismo paquete, pero lo puedes dejar.

public class MainTest {
    public static void main(String[] args) {
        try (Connection conn = ConexionDB.getConnection()) {
            System.out.println("Conexion OK a MySQL");
        } catch (Exception e) {
            System.err.println("Fallo la conexion:");
            e.printStackTrace();
        }
    }
}
