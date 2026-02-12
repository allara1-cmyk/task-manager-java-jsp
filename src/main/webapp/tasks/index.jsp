<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="app.model.Task" %>

<%
  String flashSuccess = (String) session.getAttribute("flash_success");
  String flashError = (String) session.getAttribute("flash_error");
  session.removeAttribute("flash_success");
  session.removeAttribute("flash_error");
%>

<!DOCTYPE html>
<html>
<head><title>Tasks</title></head>
<body>
  <h2>Tasks</h2>
  <p><a href="<%= request.getContextPath() %>/logout">Logout</a></p>

  <% if (flashSuccess != null) { %><p style="color:green;"><%= flashSuccess %></p><% } %>
  <% if (flashError != null) { %><p style="color:red;"><%= flashError %></p><% } %>

  <p><a href="<%= request.getContextPath() %>/tasks/new">Create task</a></p>

  <table border="1" cellpadding="6">
    <tr>
      <th>Title</th>
      <th>Status</th>
      <th>Due date</th>
      <th>Actions</th>
    </tr>

    <c:forEach var="t" items="${tasks}">
      <%
        Task tt = (Task) pageContext.getAttribute("t");
        boolean overdue = false;
        if (tt != null && !tt.isDone() && tt.getDueDate() != null) {
          overdue = tt.getDueDate().toLocalDate().isBefore(LocalDate.now());
        }
        pageContext.setAttribute("overdue", overdue);
      %>
      <tr>
        <td><c:out value="${t.title}"/></td>
        <td>
          <c:choose>
            <c:when test="${overdue}">Overdue</c:when>
            <c:when test="${t.done}">Completed</c:when>
            <c:otherwise>Pending</c:otherwise>
          </c:choose>
        </td>
        <td><c:out value="${t.dueDate}"/></td>
        <td>
          <a href="<%= request.getContextPath() %>/tasks/edit?id=${t.id}">Edit</a>

          <form method="post" action="<%= request.getContextPath() %>/tasks/delete" style="display:inline;">
            <input type="hidden" name="id" value="${t.id}">
            <button type="submit" onclick="return confirm('Delete?');">Delete</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </table>
</body>
</html>
