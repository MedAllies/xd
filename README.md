# XD

XD Web App based on Direct Java RI8

## Build Component
This project is using maven pom.xml file for the build lifecyle.

`mvn clean install`

## Running Component
To run this project locally with default configuration:

`java -jar xd-<version>.war`

For a custom configuration please use externalized `application.properties` along with the WAR file.


## Microservice containerization

Microservice application should be built and ready to deploy using `mvn clean isntall` command or full package built form `direct-ri-build-microsrvcs` project.

To create docker image or `xd` run command below:

`docker build -t xd:latest .`

When running created image containerized microservice will start on default port `8087` with default RabbitMQ `guest` user and `guest` password.

## Dependencies

Need RabbitMQ instance running with specified connection to it in the `Dockerfile`