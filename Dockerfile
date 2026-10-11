# Base container with amazon corretto
FROM amazoncorretto:25-alpine

# Copy jar (as app.jar, version-independent). You need to replace the jar from the
# assets dir after a new build - buildAndLaunchContainer.sh will do it for you.
#
# Note: Since Spring Boot 4 / Spring Framework 7 the Spring Boot Maven plugin no longer
# supports building "fully executable" jars (embedded launch script). The jar is a
# regular jar now and is started via "java -jar" below.

COPY assets/ /

# nobody (99)
RUN chown -R 99:99 /opt ; \
    chmod 644 /opt/app.jar

# http port
EXPOSE 8042
# hazelcast communication
EXPOSE 5701

# Run as Nobody
USER nobody

WORKDIR /opt
ENTRYPOINT ["/usr/bin/java", "-jar", "/opt/app.jar"]
