package app.util;

import jakarta.servlet.http.HttpSession;

public class Flash {
    public static void success(HttpSession session, String msg) {
        session.setAttribute("flash_success", msg);
    }
    public static void error(HttpSession session, String msg) {
        session.setAttribute("flash_error", msg);
    }
}
