FROM openjdk:11-jdk-slim-bullseye AS build
COPY . /app
WORKDIR /app
RUN ./gradlew test
# hadolint ignore=DL3059
RUN ./gradlew unpack

FROM gcr.io/distroless/java11-debian11:nonroot@sha256:ff2282b40081bfc6ab002d5f47ca510f6c0d08bbb8a27dae7f2391f4995ae515
LABEL org.opencontainers.image.source="https://github.com/gitops-poc/systeminformer"
LABEL org.opencontainers.image.description="Java proof of concept project for gitops"
LABEL maintainer="alexandre.bd@tutanota.com"
ARG DEPENDENCY=/app/build/dependency
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE 8080
ENTRYPOINT ["java","-cp","/app:/app/lib/*","systeminformer.SystemInformerApplication"]
