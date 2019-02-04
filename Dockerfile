FROM openjdk:8-jre-alpine
VOLUME /tmp

USER root
RUN mkdir -m 777 -p /deployments

ADD target/tomcat-maven-1.0.jar /deployments/app.jar
ADD conf /deployments/conf
ADD webapps /deployments/webapps

ADD jmx_prometheus_javaagent-0.11.0.jar /opt/prometheus/prometheus.jar

WORKDIR /deployments

ARG namespace=myproject
ENV KUBERNETES_NAMESPACE=$namespace
EXPOSE 8080
EXPOSE 9090

RUN sh -c 'touch app.jar'

ENV JAVA_OPTS="-javaagent:/opt/prometheus/prometheus.jar=9090:conf/config.yaml -Dcatalina.base=. -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties -Djava.security.egd=file:/dev/urandom"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar app.jar" ]