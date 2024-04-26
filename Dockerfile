# Use Ubuntu 22.04 as the builder stage
FROM ubuntu:22.04 AS builder
RUN apt-get update && apt-get install -y openjdk-8-jdk maven
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

# Use Ubuntu 22.04 as the final base image
FROM ubuntu:22.04
WORKDIR /app
# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar
# Install OpenJDK in the final image
RUN apt-get update && apt-get install -y openjdk-8-jdk
# Expose port 9090
EXPOSE 9090
# Set the command to run the application
CMD ["java", "-jar", "app.jar"]

