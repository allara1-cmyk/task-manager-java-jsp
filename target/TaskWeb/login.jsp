<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
  String flashSuccess = (String) session.getAttribute("flash_success");
  String flashError = (String) session.getAttribute("flash_error");
  session.removeAttribute("flash_success");
  session.removeAttribute("flash_error");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - TaskWeb</title>
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
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .login-container {
      background: white;
      border-radius: 16px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 420px;
      padding: 40px;
    }

    .logo {
      text-align: center;
      margin-bottom: 32px;
    }

    .logo-icon {
      width: 64px;
      height: 64px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 16px;
    }

    .logo-icon .material-icons {
      color: white;
      font-size: 36px;
    }

    h1 {
      font-size: 28px;
      font-weight: 500;
      color: #1f2937;
      margin-bottom: 8px;
      text-align: center;
    }

    .subtitle {
      color: #6b7280;
      font-size: 14px;
      text-align: center;
      margin-bottom: 32px;
    }

    /* Alerts */
    .alert {
      padding: 12px 16px;
      border-radius: 8px;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 14px;
      animation: slideDown 0.3s ease;
    }

    .alert .material-icons {
      font-size: 20px;
    }

    .alert-success {
      background: #d1fae5;
      color: #065f46;
      border-left: 4px solid #10b981;
    }

    .alert-error {
      background: #fee2e2;
      color: #991b1b;
      border-left: 4px solid #ef4444;
    }

    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Form */
    .form-group {
      margin-bottom: 24px;
      position: relative;
    }

    .input-wrapper {
      position: relative;
      display: flex;
      align-items: center;
    }

    .input-icon {
      position: absolute;
      left: 14px;
      color: #9ca3af;
      pointer-events: none;
    }

    input {
      width: 100%;
      padding: 14px 14px 14px 48px;
      border: 2px solid #e5e7eb;
      border-radius: 8px;
      font-size: 15px;
      font-family: 'Roboto', sans-serif;
      transition: all 0.3s ease;
      background: #f9fafb;
    }

    input:focus {
      outline: none;
      border-color: #667eea;
      background: white;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    input:hover {
      border-color: #d1d5db;
    }

    /* Button */
    .btn {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin-bottom: 16px;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    }

    .btn:active {
      transform: translateY(0);
    }

    .btn .material-icons {
      font-size: 20px;
    }

    /* Divider */
    .divider {
      display: flex;
      align-items: center;
      text-align: center;
      margin: 24px 0;
      color: #9ca3af;
      font-size: 14px;
    }

    .divider::before,
    .divider::after {
      content: '';
      flex: 1;
      border-bottom: 1px solid #e5e7eb;
    }

    .divider span {
      padding: 0 16px;
    }

    /* Create account link */
    .create-account {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 14px;
      border: 2px solid #e5e7eb;
      border-radius: 8px;
      text-decoration: none;
      color: #667eea;
      font-weight: 500;
      transition: all 0.3s ease;
      background: white;
    }

    .create-account:hover {
      background: #f9fafb;
      border-color: #667eea;
    }

    .create-account .material-icons {
      font-size: 20px;
    }

    /* Footer */
    .footer {
      text-align: center;
      margin-top: 24px;
      color: #6b7280;
      font-size: 12px;
    }

    /* Responsive */
    @media (max-width: 480px) {
      .login-container {
        padding: 24px;
      }

      h1 {
        font-size: 24px;
      }
    }
  </style>
</head>
<body>
  <div class="login-container">
    <div class="logo">
      <div class="logo-icon">
        <span class="material-icons">task_alt</span>
      </div>
      <h1>Welcome Back</h1>
      <p class="subtitle">Sign in to manage your tasks</p>
    </div>

    <% if (flashSuccess != null) { %>
      <div class="alert alert-success">
        <span class="material-icons">check_circle</span>
        <%= flashSuccess %>
      </div>
    <% } %>

    <% if (flashError != null) { %>
      <div class="alert alert-error">
        <span class="material-icons">error</span>
        <%= flashError %>
      </div>
    <% } %>

    <% if (error != null) { %>
      <div class="alert alert-error">
        <span class="material-icons">error</span>
        <%= error %>
      </div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/login">
      <div class="form-group">
        <div class="input-wrapper">
          <span class="material-icons input-icon">person</span>
          <input 
            type="text" 
            name="username" 
            placeholder="Username" 
            required
            autocomplete="username">
        </div>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <span class="material-icons input-icon">lock</span>
          <input 
            type="password" 
            name="password" 
            placeholder="Password" 
            required
            autocomplete="current-password">
        </div>
      </div>

      <button type="submit" class="btn">
        <span class="material-icons">login</span>
        Sign In
      </button>
    </form>

    <div class="divider">
      <span>or</span>
    </div>

    <a href="<%= request.getContextPath() %>/register" class="create-account">
      <span class="material-icons">person_add</span>
      Create New Account
    </a>

    <div class="footer">
      TaskWeb © 2026 - Manage your tasks efficiently
    </div>
  </div>
</body>
</html>
