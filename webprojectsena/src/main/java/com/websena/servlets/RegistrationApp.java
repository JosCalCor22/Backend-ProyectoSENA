/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.websena.servlets;

import User.User;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author joset
 */
// Código en RegistroServlet.java
@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistrationApp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Cifrado de la contraseña (simulación)
        String passwordHash = generarHash(password);
        
        // Creación de una instancia de Usuario
        User nuevoUsuario = new User(nombre, request.getParameter("apellido"), email, passwordHash);
        
        // Lógica para guardar en la base de datos (luego la implementaremos)
        
        // Redirección
        response.sendRedirect("registroExitoso.jsp");
    }
    
    // Método simulado para generar el hash de la contraseña
    private String generarHash(String password) {
        // En un proyecto real, usarías librerías de seguridad para esto (ej. BCrypt)
        return "hash_" + password; 
    }
}