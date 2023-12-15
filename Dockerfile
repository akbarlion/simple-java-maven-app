FROM eclipse-temurin:latest
RUN mkdir /app
COPY target/submission-app-1.0-SNAPSHOT.jar /app
CMD ["java", "-jar", "/app/submission-app-1.0-SNAPSHOT.jar"]