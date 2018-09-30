FROM consol/centos-xfce-vnc
LABEL maintainer="konstantin.sobolev@gmail.com"

ARG YJP_VERSION=2018.04
ARG YJP_BUILD=83
ARG JAVA_PACKAGE=java-1.8.0-openjdk

ENV VNC_RESOLUTION 1400x768
ENV VNC_PW vnc

USER 0
RUN curl -fsSL https://www.yourkit.com/download/YourKit-JavaProfiler-$YJP_VERSION-b$YJP_BUILD.zip > /tmp/yourkit.zip && \
    yum install -y $JAVA_PACKAGE unzip &&\
    unzip -o -d /usr/local /tmp/yourkit.zip  && \
    rm /tmp/yourkit.zip && \
    ln -sf /usr/local/YourKit-JavaProfiler-$YJP_VERSION /usr/local/yjp

COPY --chown=1000:root files/ /headless/

USER 1000

