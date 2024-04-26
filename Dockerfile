# Use the official Maven image as the builder stage
FROM maven:3.8.4-openjdk-17-slim AS builder

# Set the working directory in the builder stage
WORKDIR /app

# Copy the Maven project file to the builder stage
COPY pom.xml .

# Download dependencies for caching
RUN mvn dependency:go-offline

# Copy the source code to the builder stage
COPY src ./src

# Build the application
RUN mvn package

# Use a lightweight JDK image for the final stage
FROM adoptopenjdk:17-jre-hotspot-slim

# Set the working directory in the final stage
WORKDIR /app

# Copy the JAR file built in the builder stage to the final stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]

