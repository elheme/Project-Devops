FROM tomcat:8.0.20-jre8
 
COPY target/projectjava*.war /usr/local/tomcat/webapps/projectjava.war
