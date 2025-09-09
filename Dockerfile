# Etapa 1: Compilar el proyecto con Maven
FROM maven:3.9-eclipse-temurin-21 AS builder

# Crear directorio de trabajo
WORKDIR /build

# Copiar archivos del proyecto
COPY . .

# Compilar el proyecto y generar el JAR (sin ejecutar tests)
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final para ejecución
FROM eclipse-temurin:21-jdk-alpine

# Crear directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el JAR desde la etapa anterior
COPY --from=builder /build/target/*.jar app.jar

# Exponer el puerto del microservicio (ajusta si usas otro)
EXPOSE 8761

# Comando para arrancar el microservicio
ENTRYPOINT ["java", "-jar", "/app/app.jar"]