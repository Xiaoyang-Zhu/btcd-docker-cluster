# Set the base image to Ubuntu

FROM ubuntu:18.04

# Install JAVA11
RUN apt-get update && \
            apt-get install -y software-properties-common apt-utils && \
            echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | debconf-set-selections && \
            add-apt-repository -y ppa:linuxuprising/java && \
            apt-get update && \
            apt-get install -y oracle-java11-installer && \
            rm -rf /var/lib/apt/lists/* && \
            rm -rf /var/cache/oracle-jdk11-installer

# Set Timezone for Mongodb
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Mongodb
RUN apt-get update && \
    apt-get install -y gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
    apt-get update && \
    apt-get install -y mongodb-org

# Construct the dependencies of compiling and installing bitcoin client

RUN apt-get update \
    && apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev software-properties-common -y \
    && add-apt-repository ppa:bitcoin/bitcoin \
    && apt-get install libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev -y

# Compile and install bitcoin client

WORKDIR /home/Bitcoin-BIMS
COPY ./Bitcoin-BIMS .
RUN ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && mkdir -p /root/bitcoind-bims/

WORKDIR /root/start
