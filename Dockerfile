FROM tomcat:8.0.20-jre8
# Define environment variables for Nexus repository and the artifact to download
ENV NEXUS_REPO_URL="http://3.88.157.32:8081/repository/nexus/"
ENV ARTIFACT_PATH="in/javahome/hiring/4.0.0/hiring-4.0.0.war"

# Download the WAR file from Nexus and copy it to the Tomcat webapps directory
ADD $NEXUS_REPO_URL$ARTIFACT_PATH /usr/local/tomcat/webapps/hiring.war

# Expose port 8080 (Tomcat's default port)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
