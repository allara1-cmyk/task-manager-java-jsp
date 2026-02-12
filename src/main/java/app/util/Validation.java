package app.util;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class Validation {

    public static Map<String, String> validateTask(String title, String dueDateStr) {
        Map<String, String> errors = new HashMap<>();

        if (title == null || title.trim().length() < 3) {
            errors.put("title", "Title is required (min 3 chars).");
        }

        if (dueDateStr != null && !dueDateStr.trim().isEmpty()) {
            try {
                LocalDate.parse(dueDateStr.trim());
            } catch (Exception e) {
                errors.put("due_date", "Due date must be a valid date (YYYY-MM-DD).");
            }
        }
        return errors;
    }
}
