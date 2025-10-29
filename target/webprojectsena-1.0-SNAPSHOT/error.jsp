<%-- 
    Document   : error
    Created on : 14/09/2025, 2:40:52 p. m.
    Author     : joset
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Sistema</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .error-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 50px;
            text-align: center;
            max-width: 500px;
            margin: 20px;
        }
        
        .error-icon {
            font-size: 72px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 500;
            transition: transform 0.2s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-triangle error-icon"></i>
        <h1 class="mb-3">¡Oops! Algo salió mal</h1>
        
        <% 
            Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
            String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
            
            if (statusCode != null) {
                if (statusCode == 404) {
        %>
                    <p class="text-muted mb-4">La página que buscas no existe o ha sido movida.</p>
        <%      } else if (statusCode == 500) { %>
                    <p class="text-muted mb-4">Ha ocurrido un error interno del servidor. Por favor, intenta más tarde.</p>
        <%      } else { %>
                    <p class="text-muted mb-4">Error <%= statusCode %>: <%= errorMessage != null ? errorMessage : "Error desconocido" %></p>
        <%      }
            } else { %>
                <p class="text-muted mb-4">Ha ocurrido un error inesperado.</p>
        <% } %>
        
        <div class="mt-4">
            <a href="dashboard.jsp" class="btn btn-primary me-3">
                <i class="fas fa-home me-2"></i>Ir al Inicio
            </a>
            <button onclick="history.back()" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Volver
            </button>
        </div>
    </div>
</body>
</html>