FROM fedora:latest
LABEL maintainer "quentin@dufour.io"

RUN echo "fastestmirror=1" >> /etc/dnf/dnf.conf \
    && dnf install -y java ant git curl gcc g++ make cmake

WORKDIR /opt
RUN git clone https://github.com/shiffman/OpenKinect-for-Processing \
    && git clone https://github.com/OpenKinect/libfreenect2

RUN curl -L -o processing.tgz http://download.processing.org/processing-3.3.7-linux64.tgz \
    && tar xf processing.tgz
