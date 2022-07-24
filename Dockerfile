FROM openjdk:11-jdk-slim-bullseye AS build
COPY . /app
WORKDIR /app
RUN ./gradlew test
# hadolint ignore=DL3059
RUN ./gradlew unpack

FROM gcr.io/distroless/java11-debian11:nonroot@sha256:7c9506a8ef3e916d5391fe8ae95b6f215067a938e0bdfca7986d1fc03bc340dd
LABEL org.opencontainers.image.source="https://github.com/gitops-poc/systeminformer"
LABEL org.opencontainers.image.description="Java proof of concept project for gitops"
LABEL maintainer="alexandre.bd@tutanota.com"
ARG DEPENDENCY=/app/build/dependency
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE 8080
ENTRYPOINT ["java","-cp","/app:/app/lib/*","systeminformer.SystemInformerApplication"]
