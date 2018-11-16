# Building

Maven:
mvn clean; mvn package

Docker:
docker build -t apache/tomcat-maven:1.0 -f ./Dockerfile .

# Configuration changes over Tomcat

Configuration is located in conf/server.xml, conf/web.xml, conf/logging.properties, etc
Service element should set utilityThreadsAsDaemon="false"

# Running

Add a webapp as folder mywebapp (for this example, or specify another path), or a path a configured Host would autodeploy

--path: Specify a path the wepapp will use
--war: Add the spcified path (directory or war) as a webapp (if no path has been specified, it will be the root webapp)

The JULI logging configuration is optional but makes logging more readable and configurable:
-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties
The default JULI configuration uses catalina.base, so specifying it with -Dcatalina.base=. is also useful.

Command line example with a single root webapp:
java -Dcatalina.base=. -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties -jar target/tomcat-maven-1.0.jar --war myrootwebapp

Command line example with three webapps:
java -Dcatalina.base=. -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=conf/logging.properties -jar target/tomcat-maven-1.0.jar --war myrootwebapp --path /path1 --war mywebapp1 --path /path2 --war mywebapp2


