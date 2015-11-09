FROM docker.internal.vektor.nyc/core/base:latest

ENV JAVA_VERSION=7 JAVA_UPDATE=79 JAVA_BUILD=15 JAVA_HOME=/usr/local/lib/java
ENV PATH=$PATH:${JRE_HOME}/bin
ENV JDK_URL="http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz"

#JDK Install
RUN wget --quiet \
         --no-cookies \
         --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         -O /tmp/jdk.tar.gz $JDK_URL && \
    tar xzf /tmp/jdk.tar.gz -C /tmp && \
    rm /tmp/jdk.tar.gz && \
    mv /tmp/jdk1* $JAVA_HOME && \
    update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 9999 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 9999 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 9999 && \
    chmod a+x /usr/bin/java /usr/bin/javaws /usr/bin/javac
