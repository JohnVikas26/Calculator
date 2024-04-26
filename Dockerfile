# Use Ubuntu 22.04 as the base image for the builder stage
FROM ubuntu:22.04 AS builder

# Update package lists and install OpenJDK
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Set the working directory
WORKDIR /app

# Add the Java source file
ADD HelloWorld.java .

# Compile the Java source file
RUN javac -source 8 -target 8 HelloWorld.java -d .

# Switch to a different base image for the final stage
FROM ubuntu:22.04

# Set the working directory
WORKDIR /

# Copy the compiled class file from the builder stage
COPY --from=builder /app/HelloWorld.class .

# Define the command to run the Java application
CMD ["java", "HelloWorld"]



