<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // --- INICIO: VERIFICACIÓN DE SESIÓN (SEGURIDAD) ---
    // Esto es crucial para proteger el dashboard
    HttpSession userSession = request.getSession(false);
    String userEmail = null;
    String userRole = null;
    boolean isLoggedIn = false;

    if (userSession != null) {
        userEmail = (String) userSession.getAttribute("user");
        userRole = (String) userSession.getAttribute("role");
        isLoggedIn = (userSession.getAttribute("isLoggedIn") != null) && (Boolean) userSession.getAttribute("isLoggedIn");
    }

    if (!isLoggedIn || userEmail == null || userRole == null) {
        // Si no hay sesión, o falta el email o el rol,
        // lo enviamos de vuelta a la página de login.
        response.sendRedirect(request.getContextPath() + "/auth/login");
        return; // Detener la ejecución del JSP
    }
    // --- FIN: VERIFICACIÓN DE SESIÓN ---
    

    // --- INICIO: LÓGICA DE VISTA POR ROL ---
    String welcomeTitle = "";
    String welcomeMessage = "Has iniciado sesión exitosamente como:";
    String roleSpecificClass = ""; // Clase CSS para el body
    String roleIcon = ""; // Ícono de FontAwesome
    
    if (userRole.equals("docente")) {
        welcomeTitle = "¡Bienvenido, Docente!";
        roleSpecificClass = "role-docente";
        roleIcon = "fas fa-chalkboard-teacher";
    } else { // Asumimos "estudiante"
        welcomeTitle = "¡Bienvenido, Estudiante!";
        roleSpecificClass = "role-estudiante";
        roleIcon = "fas fa-user-graduate";
    }
    // --- FIN: LÓGICA DE VISTA POR ROL ---
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sistema</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* --- INICIO: ESTILOS DINÁMICOS POR ROL --- */
        :root {
            /* Colores por defecto (Docente) */
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            --welcome-gradient: linear-gradient(135deg, #007bff 0%, #6610f2 100%);
            --stats-icon-color: #667eea;
        }

        .role-estudiante {
            /* Colores para Estudiante */
            --primary-gradient: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            --secondary-gradient: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
            --welcome-gradient: linear-gradient(135deg, #20c997 0%, #17a2b8 100%);
            --stats-icon-color: #28a745;
        }
        /* --- FIN: ESTILOS DINÁMICOS POR ROL --- */

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .dashboard-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
            max-width: 800px;
            overflow: hidden;
        }
        
        .dashboard-header {
            background: var(--primary-gradient);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .dashboard-content {
            padding: 40px;
        }
        
        .welcome-card {
            background: var(--welcome-gradient); /* Aplicada variable */
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .stats-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .stats-card i {
            font-size: 48px;
            color: var(--stats-icon-color); /* Aplicada variable */
            margin-bottom: 15px;
        }
        
        .btn-logout {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            color: white;
            font-weight: 500;
            transition: transform 0.2s ease;
        }
        
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            color: white;
        }
        
        .activity-card {
            background: var(--secondary-gradient); /* Aplicada variable */
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .session-info {
            background: var(--secondary-gradient); /* Aplicada variable */
            opacity: 0.9;
            color: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<!-- APLICAMOS LA CLASE DE ROL AQUÍ -->
<body class="<%= roleSpecificClass %>">
    <div class="container">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1><i class="fas fa-tachometer-alt"></i> Dashboard del Sistema</h1>
                <p class="mb-0">Panel de control principal</p>
            </div>
            
            <div class="dashboard-content">
                <!-- Mensaje de éxito si viene del login -->
                <%-- 
                    Nota: Este mensaje no se mostrará porque usamos
                    response.sendRedirect() en el servlet, lo cual
                    pierde los atributos del 'request'.
                    Si quieres un mensaje "flash", debe guardarse
                    en la sesión y borrarse después de mostrarse.
                --%>
                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <!-- Tarjeta de bienvenida (ACTUALIZADA) -->
                <div class="welcome-card pulse">
                    <h2><i class="<%= roleIcon %> me-2"></i><%= welcomeTitle %></h2>
                    <p class="mb-0"><%= welcomeMessage %></p>
                    <h4 class="mt-2"><%= userEmail %></h4>
                </div>
                
                <!-- Información de sesión -->
                <div class="session-info">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h6><i class="fas fa-calendar me-2"></i>Sesión iniciada</h6>
                            <p class="mb-0" id="loginTime">Calculando...</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h6><i class="fas fa-server me-2"></i>Estado del servidor</h6>
                            <span class="badge bg-success">En línea</span>
                        </div>
                    </div>
                </div>
                
                <!-- Estadísticas del sistema -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-shield-alt"></i>
                            <h5>Sesión Segura</h5>
                            <p class="text-muted">Tu sesión está protegida</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-clock"></i>
                            <h5>Tiempo de Sesión</h5>
                            <p class="text-muted" id="sessionTime">Calculando...</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-check-circle"></i>
                            <h5>Estado</h5>
                            <p class="text-success"><strong>Conectado</strong></p>
                        </div>
                    </div>
                </div>
                
                <!-- Información del sistema -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Información del Sistema</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Validaciones Implementadas:</h6>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">✅ Registro Exitoso</li>
                                    <li class="list-group-item">✅ Correo Electrónico Inválido</li>
                                    <li class="list-group-item">✅ Campos Vacíos</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Funcionalidades:</h6>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">✅ Contraseña Muy Corta</li>
                                    <li class="list-group-item">✅ Sesión Exitosa</li>
                                    <li class="list-group-item">✅ Credenciales Incorrectas</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Actividad reciente -->
                <div class="activity-card">
                    <h5><i class="fas fa-history me-2"></i>Actividad Reciente</h5>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <p><i class="fas fa-sign-in-alt me-2"></i>Inicio de sesión exitoso</p>
                            <small id="lastLogin">Hace unos segundos</small>
                        </div>
                        <div class="col-md-6">
                            <p><i class="fas fa-shield-check me-2"></i>Autenticación verificada</p>
                            <small>Sistema seguro</small>
                        </div>
                    </div>
                </div>
                
                <!-- Botón de cerrar sesión (ACTUALIZADO) -->
                <div class="text-center mt-4">
                    <!-- Este botón AHORA abre el modal -->
                    <button type="button" class="btn btn-logout" data-bs-toggle="modal" data-bs-target="#logoutConfirmModal">
                        <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- INICIO: MODAL DE CONFIRMACIÓN DE CIERRE DE SESIÓN -->
    <!-- Esto reemplaza el 'confirm()' que bloquea el navegador -->
    <div class="modal fade" id="logoutConfirmModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="logoutModalLabel"><i class="fas fa-exclamation-triangle text-danger me-2"></i>Confirmar Cierre de Sesión</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            ¿Estás seguro de que deseas cerrar sesión?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <!-- Este enlace SÍ realiza el logout. Usamos getContextPath() para la URL absoluta -->
            <a href="<%= request.getContextPath() %>/auth?action=logout" class="btn btn-danger">Cerrar Sesión</a>
          </div>
        </div>
      </div>
    </div>
    <!-- FIN: MODAL -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Mostrar tiempo de sesión y hora de login
        let startTime = new Date();
        
        // Mostrar hora de login
        document.getElementById('loginTime').textContent = startTime.toLocaleString('es-ES', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        
        function updateSessionTime() {
            const now = new Date();
            const elapsed = Math.floor((now - startTime) / 1000);
            const hours = Math.floor(elapsed / 3600);
            const minutes = Math.floor((elapsed % 3600) / 60);
            const seconds = elapsed % 60;
            
            let timeString = '';
            if (hours > 0) {
                timeString += hours + 'h ';
            }
            if (minutes > 0 || hours > 0) {
                timeString += minutes + 'm ';
            }
            timeString += seconds + 's';
            
            document.getElementById('sessionTime').textContent = timeString;
            
            // Actualizar última actividad
            const elapsedMinutes = Math.floor(elapsed / 60);
            if (elapsedMinutes === 0) {
                document.getElementById('lastLogin').textContent = 'Hace unos segundos';
            } else if (elapsedMinutes === 1) {
                document.getElementById('lastLogin').textContent = 'Hace 1 minuto';
            } else {
                document.getElementById('lastLogin').textContent = 'Hace ' + elapsedMinutes + ' minutos';
            }
        }
        
        // Actualizar cada segundo
        setInterval(updateSessionTime, 1000);
        
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // ELIMINADO: El 'confirm()' de JS
        // El modal de Bootstrap ahora maneja esto.
        
        // Mostrar notificación de bienvenida
        window.addEventListener('load', function() {
            setTimeout(function() {
                if ('Notification' in window && Notification.permission === 'granted') {
                    // Mensaje dinámico en la notificación
                    const welcomeNote = '<%= userRole.equals("docente") ? "Bienvenido, Docente" : "Bienvenido, Estudiante" %>';
                    new Notification(welcomeNote, {
                        body: 'Has iniciado sesión en el sistema',
                        icon: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="%23667eea" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>'
                    });
                }
            }, 1000);
        });
        
        // Solicitar permisos de notificación si no están concedidos
        if ('Notification' in window && Notification.permission === 'default') {
            Notification.requestPermission();
        }
    </script>
</body>
</html>