<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%
  @SuppressWarnings("unchecked")
  Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
  String vUsername = (String) request.getAttribute("v_username");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account - TaskWeb</title>
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

    .register-container {
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

    /* Form */
    .form-group {
      margin-bottom: 20px;
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

    input.error {
      border-color: #ef4444;
      background: #fef2f2;
    }

    input.error:focus {
      border-color: #ef4444;
      box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
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

    /* Password strength */
    .password-requirements {
      margin-top: 8px;
      padding: 12px;
      background: #f9fafb;
      border-radius: 6px;
      font-size: 12px;
    }

    .requirement {
      display: flex;
      align-items: center;
      gap: 6px;
      margin-bottom: 4px;
      color: #6b7280;
    }

    .requirement:last-child {
      margin-bottom: 0;
    }

    .requirement .material-icons {
      font-size: 16px;
    }

    .requirement.valid {
      color: #10b981;
    }

    .requirement.valid .material-icons {
      color: #10b981;
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

    /* Back to login link */
    .back-link {
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

    .back-link:hover {
      background: #f9fafb;
      border-color: #667eea;
    }

    .back-link .material-icons {
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
      .register-container {
        padding: 24px;
      }

      h1 {
        font-size: 24px;
      }
    }
  </style>
</head>
<body>
  <div class="register-container">
    <div class="logo">
      <div class="logo-icon">
        <span class="material-icons">person_add</span>
      </div>
      <h1>Create Account</h1>
      <p class="subtitle">Join TaskWeb to manage your tasks efficiently</p>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/register" id="registerForm">
      <div class="form-group">
        <div class="input-wrapper">
          <span class="material-icons input-icon">person</span>
          <input 
            type="text" 
            name="username" 
            id="username"
            placeholder="Username" 
            required 
            minlength="3" 
            maxlength="50"
            value="<%= vUsername != null ? vUsername : "" %>"
            class="<%= errors != null && errors.containsKey("username") ? "error" : "" %>">
        </div>
        <% if (errors != null && errors.containsKey("username")) { %>
          <div class="error-message">
            <span class="material-icons">error</span>
            <%= errors.get("username") %>
          </div>
        <% } else { %>
          <div class="helper-text">3-50 characters, letters and numbers only</div>
        <% } %>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <span class="material-icons input-icon">lock</span>
          <input 
            type="password" 
            name="password" 
            id="password"
            placeholder="Password" 
            required 
            minlength="6"
            class="<%= errors != null && errors.containsKey("password") ? "error" : "" %>">
        </div>
        <% if (errors != null && errors.containsKey("password")) { %>
          <div class="error-message">
            <span class="material-icons">error</span>
            <%= errors.get("password") %>
          </div>
        <% } %>
        <div class="password-requirements">
          <div class="requirement" id="req-length">
            <span class="material-icons">radio_button_unchecked</span>
            At least 6 characters
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <span class="material-icons input-icon">lock_outline</span>
          <input 
            type="password" 
            name="confirm_password" 
            id="confirmPassword"
            placeholder="Confirm Password" 
            required 
            minlength="6"
            class="<%= errors != null && errors.containsKey("confirm_password") ? "error" : "" %>">
        </div>
        <% if (errors != null && errors.containsKey("confirm_password")) { %>
          <div class="error-message">
            <span class="material-icons">error</span>
            <%= errors.get("confirm_password") %>
          </div>
        <% } %>
        <div class="helper-text" id="matchHelper">Passwords must match</div>
      </div>

      <button type="submit" class="btn">
        <span class="material-icons">how_to_reg</span>
        Create Account
      </button>
    </form>

    <div class="divider">
      <span>Already have an account?</span>
    </div>

    <a href="<%= request.getContextPath() %>/login" class="back-link">
      <span class="material-icons">login</span>
      Sign In
    </a>

    <div class="footer">
      TaskWeb © 2026 - Manage your tasks efficiently
    </div>
  </div>

  <script>
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const reqLength = document.getElementById('req-length');
    const matchHelper = document.getElementById('matchHelper');

    // Password validation
    password.addEventListener('input', function() {
      const value = this.value;
      
      // Check length
      if (value.length >= 6) {
        reqLength.classList.add('valid');
        reqLength.querySelector('.material-icons').textContent = 'check_circle';
      } else {
        reqLength.classList.remove('valid');
        reqLength.querySelector('.material-icons').textContent = 'radio_button_unchecked';
      }
      
      // Check match
      checkPasswordMatch();
    });

    confirmPassword.addEventListener('input', checkPasswordMatch);

    function checkPasswordMatch() {
      if (confirmPassword.value.length > 0) {
        if (password.value === confirmPassword.value) {
          matchHelper.style.color = '#10b981';
          matchHelper.textContent = '✓ Passwords match';
        } else {
          matchHelper.style.color = '#ef4444';
          matchHelper.textContent = '✗ Passwords do not match';
        }
      } else {
        matchHelper.style.color = '#6b7280';
        matchHelper.textContent = 'Passwords must match';
      }
    }
  </script>
</body>
</html>
