# Use OpenJDK as the base image
FROM openjdk:17 AS build

# Install Maven (to run Maven build inside the container)
RUN apt-get update && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src/ ./src/

# Build the project (this will generate the target directory with the JAR file)
RUN mvn clean install

# Now, create the runtime container
FROM openjdk:17

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build container to the runtime container
COPY --from=build /app/target/docker-service.jar dockerdemo.jar

# Command to run the application
CMD ["java", "-jar", "dockerdemo.jar"]
