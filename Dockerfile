FROM eclipse-temurin:17-jdk-jammy as build
WORKDIR /workspace/app

RUN --mount=type=cache,target=/root/.gradle \
        --mount=type=bind,source=gradlew,target=gradlew \
        --mount=type=bind,source=build.gradle,target=build.gradle \
        --mount=type=bind,source=settings.gradle,target=settings.gradle \
        --mount=type=bind,source=gradle,target=gradle \
        --mount=type=bind,source=src,target=src \
        ./gradlew clean build -x test
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*-SNAPSHOT.jar)


FROM eclipse-temurin:17-jdk-alpine
# RUN useradd -m -u 999 -U -s /bin/sh -d /app appuser
RUN adduser --system --uid 999 --shell /bin/sh --home /app appuser 
ARG DEPENDENCY=/workspace/app/build/dependency
COPY --chown=appuser:appuser --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --chown=appuser:appuser --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --chown=appuser:appuser --from=build ${DEPENDENCY}/BOOT-INF/classes /app
# Switch to the non-root user
USER appuser
# Change ownership of the app directory to appuser
ENTRYPOINT ["java","-cp","app:app/lib/*","org.springframework.samples.petclinic.PetClinicApplication"]

