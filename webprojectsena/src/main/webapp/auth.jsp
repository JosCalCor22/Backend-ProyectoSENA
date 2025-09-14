<%-- 
    Document   : registrationApp
    Created on : 11/09/2025, 12:58:40 p. m.
    Author     : joset
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Crear nuevo usuario</h1>
        <form action="./registroExitoso.jsp" method="post">
            <label for="nombre">Nombre:</label><br>
            <input type="text" id="nombre" name="nombre"><br><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email"><br><br>

            <label for="password">Contraseña:</label><br>
            <input type="password" id="password" name="password"><br><br>

            <input type="submit" value="Registrar">
        </form>
    </body>
</html>
