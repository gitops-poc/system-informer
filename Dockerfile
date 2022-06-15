FROM openjdk:11-jdk-slim-bullseye AS build
COPY . /app
WORKDIR /app
RUN ./gradlew test
RUN ./gradlew unpack

FROM gcr.io/distroless/java11-debian11:nonroot
ARG DEPENDENCY=/app/build/dependency
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build --chown=nonroot:nonroot ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE 8080
ENTRYPOINT ["java","-cp","/app:/app/lib/*","systeminformer.SystemInformerApplication"]
