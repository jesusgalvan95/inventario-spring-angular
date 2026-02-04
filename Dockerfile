# ====== BUILD ======
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copiamos solo el backend para compilar
COPY backend/pom.xml backend/pom.xml
COPY backend/.mvn backend/.mvn
COPY backend/mvnw backend/mvnw
COPY backend/mvnw.cmd backend/mvnw.cmd

# Descargar dependencias (cache)
WORKDIR /app/backend
RUN mvn -DskipTests dependency:go-offline

# Copiamos el código y compilamos
COPY backend/src src
RUN mvn -DskipTests package

# ====== RUN ======
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/backend/target/*.jar app.jar

# Render usa PORT, Spring debe escuchar ese puerto
ENV PORT=8080
EXPOSE 8080
CMD ["sh","-c","java -jar app.jar --server.port=${PORT}"]
