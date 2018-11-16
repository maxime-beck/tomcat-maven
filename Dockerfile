FROM openjdk:8-jre-alpine
VOLUME /tmp

USER root
RUN mkdir -m 777 -p /deployments

ARG war
RUN echo $war
ADD target/tomcat-maven-1.0.jar /deployments/app.jar
ADD $war/ /deployments/webapp.war
ADD conf /deployments/conf

WORKDIR /deployments

ARG registry_id
ENV KUBERNETES_NAMESPACE $registry_id

RUN sh -c 'touch app.jar'
ENV JAVA_OPTS="-Dcatalina.base=. -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties -Djava.security.egd=file:/dev/urandom"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar app.jar --war /deployments/webapp.war" ]
