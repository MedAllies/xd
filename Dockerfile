FROM azul/zulu-openjdk-alpine:8u282-jre

# Run system update
RUN apk update
RUN apk upgrade --ignore zulu8-*
RUN apk add --no-cache --upgrade bash
RUN apk add --no-cache curl && \
    rm -rf /var/cache/apk/*

# When building images, use this tag
LABEL tag=xd

# Build arguments
ARG BUILD_VERSION=8.1.0-SNAPSHOT

# Create and use local user and group
RUN addgroup -S direct && adduser -S -D direct -G direct

# Set application location
RUN mkdir -p /opt/app
RUN chown direct:direct /opt/app
ENV PROJECT_HOME /opt/app

ENV SERVICE_PORT=8087
ENV CLOUD_CONFIG=true

# Set RabbitMQ properties
ENV RABBIT_MQ_HOST=localhost
ENV RABBIT_MQ_PORT=5672
ENV RABBIT_MQ_USERNAME=guest
ENV RABBIT_MQ_PASSWORD=guest

# Set Config-Service properties
ENV CONFIG_SERVICE_USERNAME=admin
ENV CONFIG_SERVICE_PASSWORD=direct
ENV CONFIG_SERVICE_HOST=localhost
ENV CONFIG_SERVICE_PORT=8082

ENV XD_USESTREAMS=true

# Use local user and group
USER direct:direct

# Copy application artifact
COPY bootstrap.properties $PROJECT_HOME/bootstrap.properties
COPY application.properties $PROJECT_HOME/application.properties
COPY target/xd-$BUILD_VERSION.war $PROJECT_HOME/xd.war

# Switching to the application location
WORKDIR $PROJECT_HOME

# Run application
CMD ["java","-jar","./xd.war"]