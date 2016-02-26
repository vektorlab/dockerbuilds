FROM vektorlab/base:latest

RUN apk --no-cache add openjdk7-jre bash wget curl ttf-dejavu openssh

ENV JENKINS_VERSION latest
ENV JENKINS_HOME /jenkins

ADD http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war /opt/jenkins.war
RUN adduser -D -h ${JENKINS_HOME} -s "/bin/false" jenkins && \
    chmod 644 /opt/jenkins.war

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
