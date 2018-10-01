FROM consol/centos-xfce-vnc

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="konstantin.sobolev@gmail.com" \
      org.label-schema.name="yourkit" \
      org.label-schema.description="YourKit Java profiler with XFCE desktop and VNC support" \
      org.label-schema.url="https://github.com/eprst/yourkit_docker" \
      org.label-schema.version="0.1" \
      org.label-schema.docker-cmd="docker run -p 5901:5901 -p 6901:6901 ksobolev/yourkit" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/eprst/yourkit_docker.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

ARG YJP_VERSION=2018.04
ARG YJP_BUILD=86
ARG JAVA_PACKAGE=java-1.8.0-openjdk

ENV VNC_RESOLUTION 1400x768
ENV VNC_PW vnc

USER 0
RUN curl -fsSL https://www.yourkit.com/download/YourKit-JavaProfiler-$YJP_VERSION-b$YJP_BUILD.zip > /tmp/yourkit.zip && \
    yum install -y $JAVA_PACKAGE unzip &&\
    unzip -o -d /usr/local /tmp/yourkit.zip  && \
    rm /tmp/yourkit.zip && \
    mv /usr/local/YourKit-JavaProfiler-$YJP_VERSION /usr/local/yjp && \
    chown -R 1000 /usr/local/yjp

COPY --chown=1000:root files/ /headless/

USER 1000

