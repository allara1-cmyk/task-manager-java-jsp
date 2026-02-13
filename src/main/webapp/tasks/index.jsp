<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="app.model.Task" %>
<%
    @SuppressWarnings("unchecked")
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    String searchTerm = (String) request.getAttribute("searchTerm");
    String flashMessage = (String) session.getAttribute("flash_message");
    String flashType = (String) session.getAttribute("flash_type");
    
    if (flashMessage != null) {
        session.removeAttribute("flash_message");
        session.removeAttribute("flash_type");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tasks</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .header h1 {
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .header-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .search-box button {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .search-box button:hover {
            background: #5568d3;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }
        
        .btn-danger {
            background: #ef4444;
            color: white;
        }
        
        .btn-danger:hover {
            background: #dc2626;
        }
        
        .btn-logout {
            background: #6b7280;
            color: white;
        }
        
        .btn-logout:hover {
            background: #4b5563;
        }
        
        .flash {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .flash.success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #34d399;
        }
        
        .flash.error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #f87171;
        }
        
        .search-info {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .task-grid {
            display: grid;
            gap: 15px;
        }
        
        .task-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s;
            border-left: 4px solid #667eea;
        }
        
        .task-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .task-card.done {
            opacity: 0.7;
            border-left-color: #10b981;
        }
        
        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 12px;
        }
        
        .task-title {
            font-size: 18px;
            font-weight: 600;
            color: #1f2937;
            flex: 1;
        }
        
        .task-card.done .task-title {
            text-decoration: line-through;
            color: #6b7280;
        }
        
        .task-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }
        
        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }
        
        .status-done {
            background: #d1fae5;
            color: #065f46;
        }
        
        .task-description {
            color: #6b7280;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .task-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            color: #6b7280;
            font-size: 14px;
        }
        
        .task-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .btn-small {
            padding: 8px 16px;
            font-size: 13px;
        }
        
        .btn-info {
            background: #3b82f6;
            color: white;
        }
        
        .btn-info:hover {
            background: #2563eb;
        }
        
        .btn-warning {
            background: #f59e0b;
            color: white;
        }
        
        .btn-warning:hover {
            background: #d97706;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .empty-state h2 {
            color: #6b7280;
            margin-bottom: 10px;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            animation: fadeIn 0.3s;
        }
        
        .modal.active {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 16px;
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
            animation: slideUp 0.3s;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }
        
        .modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #f3f4f6;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 20px;
            color: #6b7280;
            transition: all 0.2s;
        }
        
        .modal-close:hover {
            background: #e5e7eb;
            color: #1f2937;
        }
        
        .modal-title {
            font-size: 24px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 20px;
            padding-right: 40px;
        }
        
        .detail-row {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-size: 12px;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }
        
        .detail-value {
            font-size: 16px;
            color: #1f2937;
            line-height: 1.6;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        @media (max-width: 768px) {
            .header-actions {
                flex-direction: column;
            }
            
            .search-box {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 My Tasks</h1>
            <div class="header-actions">
                <form action="<%= request.getContextPath() %>/tasks/search" method="get" class="search-box">
                    <input type="text" 
                           name="q" 
                           placeholder="Search tasks..." 
                           value="<%= searchTerm != null ? searchTerm : "" %>">
                    <button type="submit">🔍</button>
                </form>
                <a href="<%= request.getContextPath() %>/tasks/new" class="btn btn-primary">+ New Task</a>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-logout">Logout</a>
            </div>
        </div>
        
        <% if (flashMessage != null) { %>
            <div class="flash <%= flashType %>">
                <%= flashMessage %>
            </div>
        <% } %>
        
        <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
            <div class="search-info">
                <span>🔍 Search results for "<strong><%= searchTerm %></strong>" (<%= tasks != null ? tasks.size() : 0 %> found)</span>
                <a href="<%= request.getContextPath() %>/tasks" class="btn btn-small btn-primary">Clear search</a>
            </div>
        <% } %>
        
        <div class="task-grid">
            <% if (tasks != null && !tasks.isEmpty()) {
                for (Task task : tasks) { %>
                    <div class="task-card <%= task.isDone() ? "done" : "" %>">
                        <div class="task-header">
                            <h2 class="task-title"><%= task.getTitle() %></h2>
                            <span class="task-status <%= task.isDone() ? "status-done" : "status-pending" %>">
                                <%= task.isDone() ? "✓ Done" : "Pending" %>
                            </span>
                        </div>
                        
                        <% if (task.getDescription() != null && !task.getDescription().isEmpty()) { %>
                            <p class="task-description">
                                <%= task.getDescription().length() > 100 
                                    ? task.getDescription().substring(0, 100) + "..." 
                                    : task.getDescription() %>
                            </p>
                        <% } %>
                        
                        <div class="task-meta">
                            <span>📅 Due: <%= task.getDueDate() != null ? task.getDueDate() : "No deadline" %></span>
                        </div>
                        
                        <div class="task-actions">
                            <button onclick="showDetails(<%= task.getId() %>, 
                                '<%= task.getTitle().replace("'", "\\'") %>', 
                                '<%= task.getDescription() != null ? task.getDescription().replace("'", "\\'").replace("\n", "\\n") : "" %>', 
                                '<%= task.getDueDate() != null ? task.getDueDate() : "No deadline" %>', 
                                <%= task.isDone() %>)" 
                                class="btn btn-small btn-info">
                                👁️ View Details
                            </button>
                            <a href="<%= request.getContextPath() %>/tasks/edit?id=<%= task.getId() %>" 
                               class="btn btn-small btn-warning">
                                ✏️ Edit
                            </a>
                            <form action="<%= request.getContextPath() %>/tasks/delete" 
                                  method="post" 
                                  style="display: inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this task?');">
                                <input type="hidden" name="id" value="<%= task.getId() %>">
                                <button type="submit" class="btn btn-small btn-danger">🗑️ Delete</button>
                            </form>
                        </div>
                    </div>
                <% }
            } else { %>
                <div class="empty-state">
                    <h2>📭 <%= searchTerm != null && !searchTerm.isEmpty() ? "No tasks found" : "No tasks yet" %></h2>
                    <p style="color: #9ca3af; margin-bottom: 20px;">
                        <%= searchTerm != null && !searchTerm.isEmpty() 
                            ? "Try a different search term" 
                            : "Create your first task to get started!" %>
                    </p>
                    <% if (searchTerm == null || searchTerm.isEmpty()) { %>
                        <a href="<%= request.getContextPath() %>/tasks/new" class="btn btn-primary">+ Create Task</a>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/tasks" class="btn btn-primary">View All Tasks</a>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
    
    <!-- Modal para ver detalles -->
    <div id="detailModal" class="modal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal()">×</button>
            <h2 class="modal-title" id="modalTitle"></h2>
            
            <div class="detail-row">
                <div class="detail-label">Status</div>
                <div class="detail-value" id="modalStatus"></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Description</div>
                <div class="detail-value" id="modalDescription"></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Due Date</div>
                <div class="detail-value" id="modalDueDate"></div>
            </div>
            
            <div class="detail-row" style="border-bottom: none;">
                <div class="detail-label">Task ID</div>
                <div class="detail-value" id="modalId"></div>
            </div>
        </div>
    </div>
    
    <script>
        function showDetails(id, title, description, dueDate, isDone) {
            document.getElementById('modalId').textContent = '#' + id;
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalDescription').textContent = description || 'No description provided';
            document.getElementById('modalDueDate').textContent = dueDate;
            document.getElementById('modalStatus').innerHTML = isDone 
                ? '<span class="task-status status-done">✓ Done</span>' 
                : '<span class="task-status status-pending">Pending</span>';
            
            document.getElementById('detailModal').classList.add('active');
        }
        
        function closeModal() {
            document.getElementById('detailModal').classList.remove('active');
        }
        
        // Cerrar modal al hacer clic fuera
        document.getElementById('detailModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
        
        // Cerrar modal con tecla ESC
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });
    </script>
</body>
</html>
