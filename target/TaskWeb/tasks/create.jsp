<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  java.util.Map errors = (java.util.Map) request.getAttribute("errors");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Task - TaskWeb</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 20px;
    }

    .container {
      max-width: 700px;
      margin: 0 auto;
    }

    .navbar {
      background: white;
      padding: 15px 20px;
      border-radius: 12px;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .navbar a {
      text-decoration: none;
      color: #667eea;
      display: flex;
      align-items: center;
      gap: 5px;
      font-weight: 500;
      transition: all 0.3s;
    }

    .navbar a:hover {
      color: #5568d3;
    }

    .card {
      background: white;
      border-radius: 16px;
      padding: 40px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    }

    .card-header {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 32px;
    }

    .header-icon {
      width: 48px;
      height: 48px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .header-icon .material-icons {
      color: white;
      font-size: 28px;
    }

    h1 {
      font-size: 28px;
      font-weight: 500;
      color: #1f2937;
    }

    .form-group {
      margin-bottom: 24px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #374151;
      font-weight: 500;
      font-size: 14px;
    }

    .required::after {
      content: " *";
      color: #ef4444;
    }

    input[type="text"],
    input[type="date"],
    textarea {
      width: 100%;
      padding: 12px 16px;
      border: 2px solid #e5e7eb;
      border-radius: 8px;
      font-size: 15px;
      font-family: 'Roboto', sans-serif;
      transition: all 0.3s ease;
      background: #f9fafb;
    }

    input:focus,
    textarea:focus {
      outline: none;
      border-color: #667eea;
      background: white;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    input.error,
    textarea.error {
      border-color: #ef4444;
      background: #fef2f2;
    }

    textarea {
      min-height: 120px;
      resize: vertical;
    }

    .error-message {
      color: #ef4444;
      font-size: 13px;
      margin-top: 6px;
      display: flex;
      align-items: center;
      gap: 4px;
    }

    .error-message .material-icons {
      font-size: 16px;
    }

    .helper-text {
      color: #6b7280;
      font-size: 12px;
      margin-top: 4px;
    }

    /* Checkbox custom */
    .checkbox-wrapper {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 16px;
      background: #f9fafb;
      border: 2px solid #e5e7eb;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.3s;
    }

    .checkbox-wrapper:hover {
      background: #f3f4f6;
      border-color: #d1d5db;
    }

    .checkbox-wrapper input[type="checkbox"] {
      width: 20px;
      height: 20px;
      cursor: pointer;
      accent-color: #667eea;
    }

    .checkbox-label {
      font-size: 15px;
      color: #374151;
      font-weight: 500;
      cursor: pointer;
      user-select: none;
    }

    /* Buttons */
    .form-actions {
      display: flex;
      gap: 12px;
      margin-top: 32px;
    }

    .btn {
      padding: 14px 28px;
      border: none;
      border-radius: 8px;
      font-size: 15px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 8px;
      text-decoration: none;
      justify-content: center;
    }

    .btn-primary {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      flex: 1;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    }

    .btn-secondary {
      background: white;
      color: #374151;
      border: 2px solid #e5e7eb;
      flex: 1;
    }

    .btn-secondary:hover {
      background: #f9fafb;
      border-color: #d1d5db;
    }

    .btn .material-icons {
      font-size: 20px;
    }

    @media (max-width: 640px) {
      .card {
        padding: 24px;
      }

      .form-actions {
        flex-direction: column-reverse;
      }

      .btn {
        width: 100%;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="navbar">
      <a href="<%= request.getContextPath() %>/tasks">
        <span class="material-icons">arrow_back</span>
        Back to Tasks
      </a>
      <a href="<%= request.getContextPath() %>/profile">
        <span class="material-icons">account_circle</span>
      </a>
    </div>

    <div class="card">
      <div class="card-header">
        <div class="header-icon">
          <span class="material-icons">add_task</span>
        </div>
        <h1>Create New Task</h1>
      </div>

      <form method="post" action="<%= request.getContextPath() %>/tasks/create">
        <div class="form-group">
          <label for="title" class="required">Title</label>
          <input 
            type="text" 
            id="title" 
            name="title" 
            placeholder="Enter task title..."
            value="<c:out value='${v_title}'/>"
            class="<c:if test='${errors != null && errors.title != null}'>error</c:if>"
            required>
          <c:if test="${errors != null && errors.title != null}">
            <div class="error-message">
              <span class="material-icons">error</span>
              <c:out value="${errors.title}"/>
            </div>
          </c:if>
        </div>

        <div class="form-group">
          <label for="description">Description</label>
          <textarea 
            id="description" 
            name="description" 
            placeholder="Add more details about your task..."><c:out value="${v_description}"/></textarea>
          <div class="helper-text">Optional - Provide additional context or notes</div>
        </div>

        <div class="form-group">
          <label for="due_date">Due Date</label>
          <input 
            type="date" 
            id="due_date" 
            name="due_date" 
            value="<c:out value='${v_due_date}'/>"
            class="<c:if test='${errors != null && errors.due_date != null}'>error</c:if>">
          <c:if test="${errors != null && errors.due_date != null}">
            <div class="error-message">
              <span class="material-icons">error</span>
              <c:out value="${errors.due_date}"/>
            </div>
          </c:if>
          <div class="helper-text">Optional - Set a deadline for this task</div>
        </div>

        <div class="form-group">
          <label class="checkbox-wrapper">
            <input 
              type="checkbox" 
              name="is_done" 
              id="is_done"
              <c:if test="${v_is_done}">checked</c:if>>
            <span class="checkbox-label">Mark as completed</span>
          </label>
        </div>

        <div class="form-actions">
          <a href="<%= request.getContextPath() %>/tasks" class="btn btn-secondary">
            <span class="material-icons">cancel</span>
            Cancel
          </a>
          <button type="submit" class="btn btn-primary">
            <span class="material-icons">save</span>
            Create Task
          </button>
        </div>
      </form>
    </div>
  </div>

  <script>
    // Auto-focus en el campo de título
    document.getElementById('title').focus();

    // Establecer fecha mínima como hoy
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('due_date').setAttribute('min', today);
  </script>
</body>
</html>
