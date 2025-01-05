# Use the official Debian base image
FROM debian:bullseye

# Set the working directory inside the container
WORKDIR /app

# Update and fix repository sources, then install tools
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    apt-get update && \
    apt-get install -y \
    openjdk-17-jdk \
    maven \
    git \
    curl \
    nmap \
    sudo \
    netdiscover \
    net-tools \
    && apt-get clean

# Clone your Spring Boot app from GitHub
RUN git clone https://github.com/arbibelgacem/pentest1.git /app

# Verify repository contents
#RUN ls -la /app

# Build the Spring Boot application
RUN mvn -f backend/pentestTools/pom.xml clean package -DskipTests
#
RUN ls -la backend/pentestTools/target/

# Expose the application port
EXPOSE 8080
USER root
# Set the entry point to run your Spring Boot JAR file
ENTRYPOINT ["java", "-jar", "backend/pentestTools/target/pentestTools-0.0.1-SNAPSHOT.jar"]
