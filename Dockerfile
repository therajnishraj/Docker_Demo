# Use OpenJDK as the base image
FROM openjdk:17

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/docker-service.jar dockerdemo.jar

# Command to run the application
CMD ["java", "-jar", "dockerdemo.jar"]
