<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  java.util.Map errors = (java.util.Map) request.getAttribute("errors");
%>
<!DOCTYPE html>
<html>
<head><title>Edit</title></head>
<body>
  <h2>Edit task</h2>
  <p><a href="<%= request.getContextPath() %>/tasks">Back</a></p>

  <form method="post" action="<%= request.getContextPath() %>/tasks/update">
    <input type="hidden" name="id" value="${task.id}">

    <label>Title</label><br>
    <input name="title" value="<c:out value='${task.title}'/>">
    <c:if test="${errors != null && errors.title != null}">
      <span style="color:red;"><c:out value="${errors.title}"/></span>
    </c:if>
    <br><br>

    <label>Description</label><br>
    <textarea name="description"><c:out value="${task.description}"/></textarea>
    <br><br>

    <label>Due date</label><br>
    <input name="due_date" placeholder="YYYY-MM-DD" value="<c:out value='${task.dueDate}'/>">
    <c:if test="${errors != null && errors.due_date != null}">
      <span style="color:red;"><c:out value="${errors.due_date}"/></span>
    </c:if>
    <br><br>

    <label>
      <input type="checkbox" name="is_done" <c:if test="${task.done}">checked</c:if>>
      Done
    </label>
    <br><br>

    <button type="submit">Update</button>
  </form>
</body>
</html>
