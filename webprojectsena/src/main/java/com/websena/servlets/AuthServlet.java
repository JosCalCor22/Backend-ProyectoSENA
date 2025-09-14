/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.websena.servlets;

import User.User;
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

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {
    
    // Simulamos una base de datos simple con usuarios válidos
    private static final Map<String, String> validUsers = new HashMap<>();
    private static final String VALID_EMAIL = "admin@example.com";
    private static final String VALID_PASSWORD = "123456789";
    
    static {
        validUsers.put(VALID_EMAIL, VALID_PASSWORD);
        // Puedes agregar más usuarios aquí
        validUsers.put("usuario@test.com", "password123");
    }
    
    // Patrón para validar email
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (null != action) switch (action) {
            case "login" -> handleLogin(request, response);
            case "register" -> handleRegister(request, response);
            case "logout" -> handleLogout(request, response);
            default -> {
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            // Mostrar la página de login por defecto
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validar campos vacíos
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.setAttribute("errorType", "empty_fields");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar formato de email
        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            request.setAttribute("error", "El formato del correo electrónico es inválido");
            request.setAttribute("errorType", "invalid_email");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar credenciales
        if (!validUsers.containsKey(email.trim()) || 
            !validUsers.get(email.trim()).equals(password)) {
            
            request.setAttribute("error", "Credenciales incorrectas");
            request.setAttribute("errorType", "invalid_credentials");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Login exitoso
        HttpSession session = request.getSession();
        session.setAttribute("user", email.trim());
        session.setAttribute("isLoggedIn", true);
        
        request.setAttribute("success", "Sesión iniciada correctamente");
        request.setAttribute("successType", "login_success");
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("regEmail");
        String password = request.getParameter("regPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validar campos vacíos
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.setAttribute("errorType", "empty_fields");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar formato de email
        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            request.setAttribute("error", "El formato del correo electrónico es inválido");
            request.setAttribute("errorType", "invalid_email");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar que solo el correo preexistente puede registrarse
        if (!VALID_EMAIL.equals(email.trim())) {
            request.setAttribute("error", "Este correo electrónico no está autorizado para el registro");
            request.setAttribute("errorType", "invalid_email");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar longitud de contraseña
        if (password.length() < 8) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres");
            request.setAttribute("errorType", "short_password");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Validar que las contraseñas coincidan
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.setAttribute("errorType", "password_mismatch");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
            return;
        }
        
        // Registro exitoso (en un caso real, aquí guardarías en base de datos)
        validUsers.put(email.trim(), password);
        
        request.setAttribute("success", "Registro exitoso. Ya puedes iniciar sesión");
        request.setAttribute("successType", "register_success");
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
        request.getRequestDispatcher("/auth.jsp").forward(request, response);
    }
}