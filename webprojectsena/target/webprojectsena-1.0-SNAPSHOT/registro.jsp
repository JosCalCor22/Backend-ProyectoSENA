<%-- 
    Document   : registro
    Created on : 10/09/2025, 10:17:39 a. m.
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
        <form action="RegistroServlet" method="post">
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
