FROM openjdk:11-jdk-slim-bullseye AS build
COPY . /app
WORKDIR /app
RUN ./gradlew test
# hadolint ignore=DL3059
RUN ./gradlew unpack

FROM gcr.io/distroless/java11-debian11:nonroot@sha256:24b9bab03bc10fe156f373966eef8294f755525bd7dc437849a77f850216a3db
LABEL org.opencontainers.image.source="https://github.com/gitops-poc/system-informer"
LABEL org.opencontainers.image.description="Java proof of concept project for gitops"
LABEL maintainer="alexandre.bd@tutanota.com"
ARG DEPENDENCY=/app/build/dependency
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE 8080
ENTRYPOINT ["java","-cp","/app:/app/lib/*","systeminformer.SystemInformerApplication"]
