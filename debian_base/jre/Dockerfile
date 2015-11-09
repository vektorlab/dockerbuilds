FROM docker.internal.vektor.nyc/core/base:latest

ENV JAVA_VERSION=7 JAVA_UPDATE=72 JAVA_BUILD=14 JAVA_HOME=/usr/lib/java

ENV PATH=$PATH:${JAVA_HOME}/bin
ENV JRE_URL="http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz"

#JRE Install
RUN wget --quiet \
         --no-cookies \
         --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         -O /tmp/jre.tgz $JRE_URL && \
    tar xzf /tmp/jre.tgz -C /tmp && \
    rm /tmp/jre.tgz && \
    mv /tmp/jre1* $JAVA_HOME && \
    update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 9999 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 9999 && \
    chmod a+x /usr/bin/java /usr/bin/javaws
