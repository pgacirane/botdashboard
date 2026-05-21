# Stage 1: Build
FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM tomcat:9.0-jdk11-openjdk

RUN sed -i 's/port="8080"/port="7860"/' /usr/local/tomcat/conf/server.xml
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

COPY --from=build /app/target/BOTGATEWAY-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Self-ping to prevent HF 30-min inactivity sleep
RUN printf '#!/bin/bash\nwhile true; do\n  sleep 1500\n  curl -s http://localhost:7860/ > /dev/null\ndone\n' \
    > /usr/local/bin/keep_alive.sh && chmod +x /usr/local/bin/keep_alive.sh

EXPOSE 7865
ENV PORT 7865

CMD bash -c "/usr/local/bin/keep_alive.sh & catalina.sh run"