FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

FROM ubuntu/jre:8-22.04_edge
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 9090
CMD ["java", "-jar", "app.jar"]

