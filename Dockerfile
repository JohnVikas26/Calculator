FROM ubuntu:22.04 AS builder

# Install Java JDK
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Set the working directory
WORKDIR /app

# Add the Java source file
ADD src/HelloWorld.java .

# Compile the Java source file
RUN javac -source 8 -target 8 HelloWorld.java -d .

# Second stage of the build
FROM ubuntu/jre:8-22.04_edge

# Set the working directory
WORKDIR /

# Copy the compiled class file from the builder stage
COPY --from=builder /app/HelloWorld.class .

# Set the command to run when the container starts
CMD [ "HelloWorld" ]

