<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sistema</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .dashboard-content {
            padding: 40px;
        }
        
        .welcome-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
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
            color: #667eea;
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
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
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
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
            color: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1><i class="fas fa-tachometer-alt"></i> Dashboard del Sistema</h1>
                <p class="mb-0">Panel de control principal</p>
            </div>
            
            <div class="dashboard-content">
                <!-- Mensaje de éxito si viene del login -->
                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <!-- Tarjeta de bienvenida -->
                <div class="welcome-card pulse">
                    <h2><i class="fas fa-user-circle me-2"></i>¡Bienvenido!</h2>
                    <p class="mb-0">Has iniciado sesión exitosamente como:</p>
                    <h4 class="mt-2"></h4>
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
                
                <!-- Botón de cerrar sesión -->
                <div class="text-center mt-4">
                    <a href="auth?action=logout" class="btn btn-logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                    </a>
                </div>
            </div>
        </div>
    </div>

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
        
        // Confirmar antes de cerrar sesión
        document.querySelector('.btn-logout').addEventListener('click', function(e) {
            if (!confirm('¿Estás seguro de que deseas cerrar sesión?')) {
                e.preventDefault();
            }
        });
        
        // Mostrar notificación de bienvenida
        window.addEventListener('load', function() {
            setTimeout(function() {
                if ('Notification' in window && Notification.permission === 'granted') {
                    new Notification('Sesión iniciada', {
                        body: 'Bienvenido al sistema de autenticación',
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