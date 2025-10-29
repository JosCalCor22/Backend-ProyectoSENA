
# Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
# Click nbfs://nbhost/SystemFileSystem/Templates/Other/Dockerfile to edit this template

FROM alpine:latest

CMD ["/bin/sh"]

# --- Fase 1: Construcción (Build) ---
# Usamos una imagen de Maven con Java (JDK) para compilar tu proyecto
# Asegúrate de usar la versión de Java correcta (ej. 17)
FROM maven:3.8.5-openjdk-17 AS build

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos de definición del proyecto
COPY pom.xml .

# Descargamos las dependencias (esto se cachea para ir más rápido)
RUN mvn dependency:go-offline

# Copiamos todo el código fuente
COPY src/ /app/src/

# Compilamos el proyecto y generamos el .WAR
# Esto ejecuta tus tests, si quieres saltarlos usa: mvn package -DskipTests
RUN mvn package

# --- Fase 2: Ejecución (Runtime) ---
# Ahora usamos la imagen oficial de Payara Server
# Elige la versión de Payara que sea compatible con tu versión de Jakarta EE
FROM payara/server-full:6.2024.5-jdk17

# Por defecto, Payara usa el puerto 8080 (HTTP) y 4848 (Admin)
# Render necesita saber qué puerto exponer.
EXPOSE 8080

# Copiamos el archivo .WAR que compilamos en la Fase 1
# Lo copiamos a la carpeta 'autodeploy' de Payara.
# Payara automáticamente desplegará cualquier .WAR que pongas ahí.
COPY --from=build /app/target/*.war ${DEPLOY_DIR}

# El comando para iniciar Payara ya está incluido en la imagen base,
# así que no necesitamos un CMD o ENTRYPOINT.
