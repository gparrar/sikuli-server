FROM openjdk:8-slim
MAINTAINER Gonzalo Parra

ENV WORKDIR /home

WORKDIR ${WORKDIR}

  RUN apt-get update && apt-get install -y --no-install-recommends \
      python \
      python-dev \
      python-pip \
      lsb-release \
      wget \
      xvfb \
      x11-xserver-utils \
      sudo \
      libopencv-dev \
      tar \
      tesseract-ocr \
  	&& rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade virtualenv setuptools wheel \
    && pip install robotframework

# Install maven
RUN wget http://ftp.cixug.es/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xvf apache-maven-3.3.9-bin.tar.gz -C /usr/local/
RUN rm apache-maven-3.3.9-bin.tar.gz

COPY ./robotframework-SikuliLibrary/ ${WORKDIR}

# Compile and install robot framework sikuli library
RUN /usr/local/apache-maven-3.3.9/bin/mvn clean package
RUN python setup.py install

COPY start.sh ${WORKDIR}
CMD ["./start.sh"]
