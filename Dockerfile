FROM openjdk:8
ADD target/my-app-1.0-SNAPSHOT.jar my-e2e-app.jar
ENTRYPOINT ["java","-jar","/my-app-1.0-SNAPSHOT.jar"]
