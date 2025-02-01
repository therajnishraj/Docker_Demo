# Use Maven with OpenJDK 17 as the base image for building
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src/ ./src/

# Build the project (this will generate the target directory with the JAR file)
RUN mvn clean install

# Use OpenJDK 17 as the base image for the runtime
FROM openjdk:17

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build container to the runtime container
COPY --from=build /app/target/docker-service.jar dockerdemo.jar

# Command to run the application
CMD ["java", "-jar", "dockerdemo.jar"]
