# Use official Tomcat with Java 11 or 17
FROM tomcat:9.0-jdk17

# Remove the default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your manually built WAR file into Tomcat
COPY dist/SKINPAIRS_1.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
