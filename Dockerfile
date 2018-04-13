FROM fedora:latest
LABEL maintainer "quentin@dufour.io"

RUN echo "fastestmirror=1" >> /etc/dnf/dnf.conf \
    && dnf install -y java ant git curl

WORKDIR /opt
RUN git clone https://github.com/shiffman/OpenKinect-for-Processing
# creates /root/OpenKinect-for-Processing

#    dnf group install -y "C Development Tools and Libraries" \
#    && git clone https://github.com/OpenKinect/libfreenect2
#         /root/libfreenect2

RUN curl -L -o processing.tgz http://download.processing.org/processing-3.3.7-linux64.tgz \
    && tar xf processing.tgz
# creates /root/processing-3.3.7
RUN chmod 777 -R /opt
