ARG base_image

FROM ${base_image}

LABEL maintainer="Chandresh Rajkumar Manonmani <cs1193@gmail.com> (chandreshrm.name)"

RUN set -eux

WORKDIR /tmp

ENV ZOOKEEPER_VERSION 3.6.1
RUN wget -O "apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz" "https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"
RUN wget -O "apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc" "https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc"
RUN wget -O KEYS "https://downloads.apache.org/zookeeper/KEYS"
RUN export GNUPGHOME="$(mktemp -d)"
RUN gpg --import KEYS
RUN gpg --batch --verify "apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc" "apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"
RUN command -v gpgconf && gpgconf --kill all || :
RUN tar -xvzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt
RUN mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/zookeeper
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
RUN rm -rf "$GNUPGHOME" "apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
