# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update package lists and install OpenJDK
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Set the working directory
WORKDIR /app

# Add the Java source file
ADD HelloWorld.java .

# Compile the Java source file
RUN javac -source 8 -target 8 HelloWorld.java -d .

# Define the command to run the Java application
CMD ["java", "HelloWorld"]

