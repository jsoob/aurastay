FROM openjdk:17-alpine AS builder

# Tomcat 다운로드 및 압축 해제
ARG TOMCAT_VERSION=10.1.39
WORKDIR /usr/local
RUN wget -q https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz   && tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz  && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz    && mv apache-tomcat-${TOMCAT_VERSION} tomcat

# 실행용 가벼운 base 이미지
FROM openjdk:17-alpine

# Tomcat 복사 및 환경 변수 설정
ENV CATALINA_HOME=/usr/local/tomcat
WORKDIR ${CATALINA_HOME}
COPY --from=builder /usr/local/tomcat ${CATALINA_HOME}
RUN rm -f ${CATALINA_HOME}/webapps/ROOT.war && rm -rf ${CATALINA_HOME}/webapps/ROOT
COPY aurastay-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
COPY upload/ /usr/local/upload/
RUN chmod +x ${CATALINA_HOME}/bin/*.sh

# Tomcat 포트 설정
EXPOSE 8080

# Tomcat 실행
CMD ["sh", "-c", "${CATALINA_HOME}/bin/catalina.sh run"]
