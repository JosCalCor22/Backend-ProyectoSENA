/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.websena.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

// Captura /auth, /auth/login, /auth/signup, etc.
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth/*"})
public class AuthServlet extends HttpServlet {
    
    // (Tu código de simulación de base de datos permanece igual)
    private static final Map<String, String> validUsers = new HashMap<>();
    private static final Map<String, String> userRoles = new HashMap<>(); // Simulación de roles
    
    private static final String VALID_EMAIL = "admin@example.com";
    private static final String VALID_PASSWORD = "123456789";
    
    static {
        validUsers.put(VALID_EMAIL, VALID_PASSWORD);
        userRoles.put(VALID_EMAIL, "docente"); 
        
        validUsers.put("usuario@test.com", "password123");
        userRoles.put("usuario@test.com", "estudiante");
    }
    
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );
    
    // El método doPost permanece igual, apuntan correctamente a /auth (gracias al getContextPath())
    // y la lógica de 'action' sigue funcionando.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (null != action) switch (action) {
            case "login" -> handleLogin(request, response);
            case "register" -> handleRegister(request, response);
            case "logout" -> handleLogout(request, response);
            default -> {
                response.sendRedirect(request.getContextPath() + "/auth/login");
            }
        }
    }
    

    // Este método maneja las recargas de página (peticiones GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            handleLogout(request, response);
            return; // Importante: Salir después de manejar el logout
        } 
        
        // Nueva lógica para manejar las rutas /auth/login y /auth/signup
        String pathInfo = request.getPathInfo(); // Obtiene la parte de la URL después de /auth
        
        String activeTab = "login"; // Pestaña por defecto
        
        if (pathInfo != null) {
            if (pathInfo.equals("/signup")) {
                activeTab = "register";
            }
            // Si es /login o cualquier otra cosa, se queda como "login"
        }
        
        // Establecemos la pestaña activa y mostramos el JSP
        request.setAttribute("activeTab", activeTab);
        request.getRequestDispatcher("/auth.jsp").forward(request, response);
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // (Validaciones de campos vacíos y formato de email...)
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.setAttribute("errorType", "empty_fields");
            request.setAttribute("activeTab", "login"); // Asegurar pestaña
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            request.setAttribute("error", "El formato del correo electrónico es inválido");
            request.setAttribute("errorType", "invalid_email");
            request.setAttribute("activeTab", "login"); // Asegurar pestaña
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // (Validación de credenciales...)
        if (!validUsers.containsKey(email.trim()) || 
            !validUsers.get(email.trim()).equals(password)) {
            
            request.setAttribute("error", "Credenciales incorrectas");
            request.setAttribute("errorType", "invalid_credentials");
            request.setAttribute("activeTab", "login"); // Asegurar pestaña
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Login exitoso
        HttpSession session = request.getSession();
        session.setAttribute("user", email.trim());
        session.setAttribute("isLoggedIn", true);
        String role = userRoles.get(email.trim()); 
        session.setAttribute("role", role); 
        
        // Usamos sendRedirect para el patrón PRG
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("regEmail");
        String password = request.getParameter("regPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        
        // (Todas tus validaciones de registro permanecen igual)
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.setAttribute("errorType", "empty_fields");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            request.setAttribute("error", "El formato del correo electrónico es inválido");
            request.setAttribute("errorType", "invalid_email");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        if (!VALID_EMAIL.equals(email.trim())) {
            request.setAttribute("error", "Este correo electrónico no está autorizado para el registro");
            request.setAttribute("errorType", "invalid_email");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }

        if (!"estudiante".equals(role) && !"docente".equals(role)) {
            request.setAttribute("error", "El tipo de usuario no es válido");
            request.setAttribute("errorType", "invalid_role");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 8) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres");
            request.setAttribute("errorType", "short_password");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.setAttribute("errorType", "password_mismatch");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Registro exitoso
        validUsers.put(email.trim(), password);
        userRoles.put(email.trim(), role); 
        
        request.setAttribute("success", "Registro exitoso. Ya puedes iniciar sesión");
        request.setAttribute("successType", "register_success");
        request.setAttribute("activeTab", "login"); 
        request.getRequestDispatcher("/auth.jsp").forward(request, response);
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        request.setAttribute("success", "Sesión cerrada correctamente");
        request.setAttribute("successType", "logout_success");
        request.setAttribute("activeTab", "login"); // Al cerrar sesión, mostrar login
        request.getRequestDispatcher("/auth.jsp").forward(request, response);
    }
}