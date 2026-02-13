<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
</head>
<body>
  <h2>Register</h2>

  <% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
  <% } %>

  <form method="post" action="<%= request.getContextPath() %>/register">
    <label>Username:</label>
    <input name="username" required minlength="3" maxlength="50">
    <br>

    <label>Password:</label>
    <input name="password" type="password" required minlength="6">
    <br>

    <label>Confirm:</label>
    <input name="confirm" type="password" required minlength="6">
    <br>

    <button type="submit">Create account</button>
    <a href="<%= request.getContextPath() %>/login">Back to login</a>
  </form>
</body>
</html>
