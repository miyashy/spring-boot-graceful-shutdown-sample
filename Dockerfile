FROM eclipse-temurin:8-jdk-focal AS builder

WORKDIR /usr/src
COPY ./ ./
RUN ./gradlew bootRepackage

FROM eclipse-temurin:8-jre-focal

RUN sed -i -r 's/^#?networkaddress.cache.ttl=[-0-9]*$/networkaddress.cache.ttl=0/g' $JAVA_HOME/lib/security/java.security

ENV LANG="ja_JP.UTF-8"
ENV TZ=Asia/Tokyo

RUN groupadd -r nonroot && \
    useradd -r -g nonroot nonroot
USER nonroot

WORKDIR /
COPY --chown=nonroot:nonroot --from=builder /usr/src/build/libs/application.jar /usr/application.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/application.jar"]

