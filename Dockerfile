FROM openjdk:8u282-jre

# When building images, use this tag
LABEL tag=xd

# Build arguments
ARG BUILD_VERSION=6.0.2-SNAPSHOT

# Create and use local user and group
RUN addgroup direct && adduser direct --ingroup direct

# Set application location
RUN mkdir -p /opt/app
RUN chown direct:direct /opt/app
ENV PROJECT_HOME /opt/app

# Set RabbitMQ properties
ENV RABBIT_MQ_HOST=localhost
ENV RABBIT_MQ_PORT=5672
ENV RABBIT_MQ_USERNAME=guest
ENV RABBIT_MQ_PASSWORD=guest
ENV SERVICE_PORT=8087
ENV WEBSERVICES_SECURITY_USERNAME=admin
ENV WEBSERVICES_SECURITY_PASSWORD=direct
ENV XD_USESTREAMS=true
ENV CONFIG_SERVICE_HOST=localhost
ENV CONFIG_SERVICE_PORT=8082


# Use local user and group
USER direct:direct

# Copy application artifact
COPY application.properties $PROJECT_HOME/application.properties
COPY target/xd-$BUILD_VERSION.war $PROJECT_HOME/xd.war

# Switching to the application location
WORKDIR $PROJECT_HOME

# Run application
CMD ["java","-jar","./xd.war"]