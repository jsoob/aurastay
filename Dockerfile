FROM tomcat:10.1.39-jdk21-temurin-jammy
CMD ["chmod", "+x", "gradlew"]
CMD ["./gradlew", "clean", "build"]
#ARG JAR_FILE_PATH=target/*.jar
ARG JAR_FILE_PATH=build/libs/*-SNAPSHOT.war
COPY ${JAR_FILE_PATH} app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]