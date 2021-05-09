FROM adoptopenjdk/openjdk11:alpine

LABEL maintainer="Kulifay Zsolt"
LABEL project="storesync"

ARG JAR_FILE=./build/libs/*.jar
COPY ${JAR_FILE} app.jar

ENV SPRING_SETTINGS test

ENTRYPOINT exec java $JAVA_OPTS -Dspring.profiles.active=$SPRING_SETTINGS -jar /app.jar
