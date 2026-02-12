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
<head><title>Login</title></head>
<body>
  <h2>Login</h2>

  <% if (flashSuccess != null) { %><p style="color:green;"><%= flashSuccess %></p><% } %>
  <% if (flashError != null) { %><p style="color:red;"><%= flashError %></p><% } %>
  <% if (error != null) { %><p style="color:red;"><%= error %></p><% } %>

  <form method="post" action="<%= request.getContextPath() %>/login">
    <label>Username:</label>
    <input name="username" required>
    <br>
    <label>Password:</label>
    <input name="password" type="password" required>
    <br>
    <button type="submit">Sign in</button>
  </form>
</body>
</html>
