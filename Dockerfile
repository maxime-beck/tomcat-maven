FROM openjdk:8-jre-alpine
VOLUME /tmp

USER root
RUN mkdir -m 777 -p /deployments

ADD target/tomcat-maven-1.0.jar /deployments/app.jar
ADD conf /deployments/conf
ADD webapps /deployments/webapps

WORKDIR /deployments

ARG namespace=myproject
ENV KUBERNETES_NAMESPACE=$namespace
ARG port=8080
EXPOSE $port

RUN sh -c 'touch app.jar'
ENV JAVA_OPTS="-Dcatalina.base=. -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties -Djava.security.egd=file:/dev/urandom"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar app.jar" ]
