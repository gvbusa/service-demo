FROM openjdk:8-jre

WORKDIR /opt/service-demo

COPY target/service-demo.jar /opt/service-demo

EXPOSE 4567

ENTRYPOINT ["java","-jar", "service-demo.jar"]