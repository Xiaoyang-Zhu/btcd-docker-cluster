# Set the base image to Ubuntu

FROM ubuntu:18.04

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
