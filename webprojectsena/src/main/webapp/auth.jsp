<%-- 
    Document   : registrationApp
    Created on : 11/09/2025, 12:58:40 p. m.
    Author     : joset
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Verificar si ya hay una sesión activa
    HttpSession userSession = request.getSession(false);
    if (userSession != null && userSession.getAttribute("isLoggedIn") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    String activeTab = (String) request.getAttribute("activeTab");
    if (activeTab == null) {
        activeTab = "login";
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Autenticación - Sistema</title>
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

            .auth-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                width: 100%;
                max-width: 450px;
                margin: 20px;
            }

            .auth-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .auth-header h2 {
                margin: 0;
                font-weight: 300;
                font-size: 28px;
            }

            .nav-tabs {
                border-bottom: none;
                justify-content: center;
                background: #f8f9fa;
            }

            .nav-tabs .nav-link {
                border: none;
                color: #6c757d;
                font-weight: 500;
                padding: 15px 30px;
                border-radius: 0;
            }

            .nav-tabs .nav-link.active {
                background: white;
                color: #667eea;
                border-bottom: 3px solid #667eea;
            }

            .tab-content {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 12px 15px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 10px;
                padding: 12px;
                font-weight: 500;
                width: 100%;
                transition: transform 0.2s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            }

            .alert {
                border-radius: 10px;
                border: none;
                margin-bottom: 20px;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
            }

            .alert-success {
                background-color: #d1eddd;
                color: #155724;
            }

            .input-group-text {
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-right: none;
                color: #6c757d;
            }

            .input-group .form-control,
            .input-group .form-select {
                border-left: none;
            }

            .password-requirements {
                font-size: 12px;
                color: #6c757d;
                margin-top: 5px;
            }

            .requirement {
                margin-bottom: 3px;
            }

            .requirement.valid {
                color: #28a745;
            }

            .requirement.invalid {
                color: #dc3545;
            }
        </style>
    </head>
    <body>
        <div class="auth-container">
            <div class="auth-header">
                <h2><i class="fas fa-shield-alt"></i> Sistema de Autenticación</h2>
            </div>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <%= request.getAttribute("error")%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (request.getAttribute("success") != null) {%>
            <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <%= request.getAttribute("success")%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% }%>


            <ul class="nav nav-tabs" id="authTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= activeTab.equals("login") ? "active" : ""%>" 
                            id="login-tab" data-bs-toggle="tab" data-bs-target="#login" 
                            type="button" role="tab">
                        <i class="fas fa-sign-in-alt me-2"></i>Iniciar Sesión
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= activeTab.equals("register") ? "active" : ""%>" 
                            id="register-tab" data-bs-toggle="tab" data-bs-target="#register" 
                            type="button" role="tab">
                        <i class="fas fa-user-plus me-2"></i>Registrarse
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="authTabsContent">
                <div class="tab-pane fade <%= activeTab.equals("login") ? "show active" : ""%>" 
                     id="login" role="tabpanel">
                    <form action="<%= request.getContextPath() %>/auth" method="post" id="loginForm">
                        <input type="hidden" name="action" value="login">

                        <div class="form-group">
                            <label for="email" class="form-label">Correo Electrónico</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="ejemplo@correo.com" value="<%= request.getParameter("email") != null ? request.getParameter("email") : ""%>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label">Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Ingresa tu contraseña">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Iniciar Sesión
                        </button>

                        <div class="text-center mt-3">
                            <small class="text-muted">
                                <i class="fas fa-info-circle"></i> 
                                Usa: <strong>admin@example.com</strong> para probar el sistema
                            </small>
                        </div>
                    </form>
                </div>

                <div class="tab-pane fade <%= activeTab.equals("register") ? "show active" : ""%>" 
                     id="register" role="tabpanel">
                    <a href="../java/com/websena/servlets/AuthServlet.java"></a>
                    <form action="<%= request.getContextPath() %>/auth" method="post" id="registerForm">
                        <input type="hidden" name="action" value="register">

                        <div class="form-group">
                            <label for="regEmail" class="form-label">Correo Electrónico</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                                <input type="email" class="form-control" id="regEmail" name="regEmail" 
                                       placeholder="ejemplo@correo.com" value="<%= request.getParameter("regEmail") != null ? request.getParameter("regEmail") : ""%>">
                            </div>
                            <div class="password-requirements">
                                <i class="fas fa-info-circle"></i> Solo se permite el registro con: <strong>admin@example.com</strong>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="regPassword" class="form-label">Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="regPassword" name="regPassword" 
                                       placeholder="Crea una contraseña segura">
                            </div>
                            <div class="password-requirements" id="passwordRequirements">
                                <div class="requirement" id="lengthReq">
                                    <i class="fas fa-times text-danger"></i> Al menos 8 caracteres
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword" class="form-label">Confirmar Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirma tu contraseña">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="role" class="form-label">Tipo de Usuario</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user-tag"></i>
                                </span>
                                <select class="form-select" id="role" name="role">
                                    <option value="" selected disabled>Selecciona tu rol...</option>
                                    <option value="estudiante">Estudiante</option>
                                    <option value="docente">Docente</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-user-plus me-2"></i>Registrarse
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

        <script>
            // --- INICIO: LÓGICA DE CAMBIO DE URL ---
            (function () {
                // Obtener la ruta base de la aplicación (ej: /miApp o "" si está en la raíz)
                const contextPath = '<%= request.getContextPath()%>';

                const loginTabBtn = document.getElementById('login-tab');
                const registerTabBtn = document.getElementById('register-tab');
                const currentActiveTab = '<%= activeTab%>';

                // 1. Establecer la URL inicial al cargar la página
                if (currentActiveTab === 'login') {
                    // MODIFICADO: Se añade contextPath y una / al inicio
                    history.replaceState({tab: 'login'}, '', contextPath + '/auth/login');
                } else if (currentActiveTab === 'register') {
                    // MODIFICADO: Se añade contextPath y una / al inicio
                    history.replaceState({tab: 'register'}, '', contextPath + '/auth/signup');
                }

                // 2. Escuchar clics en las pestañas para cambiar la URL
                loginTabBtn.addEventListener('show.bs.tab', function (event) {
                    // MODIFICADO: Se añade contextPath y una / al inicio
                    history.pushState({tab: 'login'}, '', contextPath + '/auth/login');
                });

                registerTabBtn.addEventListener('show.bs.tab', function (event) {
                    // MODIFICADO: Se añade contextPath y una / al inicio
                    history.pushState({tab: 'register'}, '', contextPath + '/auth/signup');
                });

                // 3. Manejar botones de atrás/adelante del navegador
                window.addEventListener('popstate', function (event) {
                    let tabToActivate;
                    if (event.state && event.state.tab === 'register') {
                        tabToActivate = registerTabBtn;
                    } else {
                        // Por defecto, o si es login
                        tabToActivate = loginTabBtn;
                    }
                    new bootstrap.Tab(tabToActivate).show();
                });
            })();
            // --- FIN: LÓGICA DE CAMBIO DE URL ---

            const PASSWORD = "Hola1234@";
            const EMAIL = "admin@example.com";

            // Validación en tiempo real de la contraseña
            document.getElementById('regPassword').addEventListener('input', function () {
                const password = this.value;
                const lengthReq = document.getElementById('lengthReq');

                if (password.length >= 8) {
                    lengthReq.classList.remove('invalid');
                    lengthReq.classList.add('valid');
                    lengthReq.innerHTML = '<i class="fas fa-check text-success"></i> Al menos 8 caracteres';
                } else {
                    lengthReq.classList.remove('valid');
                    lengthReq.classList.add('invalid');
                    lengthReq.innerHTML = '<i class="fas fa-times text-danger"></i> Al menos 8 caracteres';
                }
            });

            // Validación de campos vacíos
            document.getElementById('loginForm').addEventListener('submit', function (e) {
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value.trim();

                if (email === EMAIL && password === PASSWORD) {
                    // Nota: Esto es lógica de cliente, la redirección real
                    // debería ocurrir en el backend tras el login exitoso.
                    // Esta línea probablemente no haga lo que esperas.
                    // window.location.href = "dashboard.jsp"; // Corregido
                }

                if (!email || !password) {
                    e.preventDefault();
                    alert('Todos los campos son obligatorios');
                    return false;
                }
            });

            document.getElementById('registerForm').addEventListener('submit', function (e) {
                const email = document.getElementById('regEmail').value.trim();
                const password = document.getElementById('regPassword').value.trim();
                const confirmPassword = document.getElementById('confirmPassword').value.trim();
                // MODIFICADO: Se obtiene el valor del nuevo campo
                const role = document.getElementById('role').value;

                // MODIFICADO: Se añade !role a la validación
                if (!email || !password || !confirmPassword || !role) {
                    e.preventDefault();
                    alert('Todos los campos son obligatorios');
                    return false;
                }

                if (password.length < 8) {
                    e.preventDefault();
                    alert('La contraseña debe tener al menos 8 caracteres');
                    return false;
                }

                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Las contraseñas no coinciden');
                    return false;
                }
            });

            // Auto-dismiss alerts after 5 seconds
            setTimeout(function () {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function (alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </body>
</html>