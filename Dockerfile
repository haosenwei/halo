FROM adoptopenjdk/openjdk8-openj9
VOLUME /tmp

#ARG JAR_FILE=target/halo-1.4.0-beta.2.jar
ARG TIME_ZONE=Asia/Shanghai

ENV TZ=${TIME_ZONE}
ENV JAVA_OPTS="-Xms256m -Xmx256m"

#COPY ${JAR_FILE} halo.jar
RUN curl -L https://github.com/halo-dev/halo/releases/download/v1.3.2/halo-1.3.2.jar --output halo.jar

ENTRYPOINT java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -server -jar halo.jar
