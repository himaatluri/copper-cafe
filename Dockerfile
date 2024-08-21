FROM maven:3.9.2-eclipse-temurin-20-alpine as build

WORKDIR /home/app

COPY src src/

COPY pom.xml .

RUN mvn -e -X clean package

FROM openjdk:20-jdk-oraclelinux7

COPY --from=build /home/app/target/copper-cafe-0.1.0.jar /usr/local/lib/copper-cafe.jar

EXPOSE 8080

ENTRYPOINT [ \
    "java",  \
    "-jar",  \
    "/usr/local/lib/copper-cafe.jar" ]