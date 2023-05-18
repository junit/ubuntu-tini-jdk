FROM krallin/ubuntu-tini:bionic

MAINTAINER Yiwen.lu <yiwen.lu@tuso.net>

# Install basic software support
RUN apt-get update && \
    apt-get install -y software-properties-common

# Add the JDK 8 and accept licenses (mandatory)
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ts.sch.gr/ppa && \
    apt-get update

# Install Java 8
RUN (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && \
    (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections) && \
    apt-get install -y oracle-java8-installer oracle-java8-set-default && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    apt-get autoclean

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $JAVA_HOME/bin:$PATH

ENTRYPOINT ["/usr/bin/tini", "--"]
