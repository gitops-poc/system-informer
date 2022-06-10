FROM azul/zulu-openjdk-alpine:11
RUN addgroup -g 12001 -S appuser && adduser -u 12000 -S appuser -G appuser
ARG DEPENDENCY=build/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
RUN chown -R appuser:appuser /app
EXPOSE 8080
USER appuser
ENTRYPOINT exec java $JAVA_OPTS -cp app:app/lib/* systeminformer.SystemInformerApplication
