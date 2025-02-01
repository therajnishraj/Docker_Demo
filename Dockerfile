# Stage 1: Build the application with Maven and OpenJDK 17
FROM maven:3.9.7-eclipse-temurin-17 AS build


# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src/ ./src/

# Build the project (this will generate the target directory with the JAR file)
RUN mvn clean install


# Stage 2: Run the application using OpenJDK 17
FROM eclipse-temurin:17-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build container to the runtime container
COPY --from=build /app/target/docker-service.jar dockerdemo.jar

# Command to run the application
CMD ["java", "-jar", "dockerdemo.jar"]
