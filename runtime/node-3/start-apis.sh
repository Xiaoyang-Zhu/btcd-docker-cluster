#!/bin/bash
bitcoind -addnode=10.7.0.12:12345 -addnode=10.7.0.11:12345 -addnode=10.7.0.14:12345 -daemon -rpcuser=rpc -rpcpassword=x -rpcport=10340 --datadir=/root/start/bitcoind-bims/ -port=12345 -walletbroadcast=1
mongod --dbpath /root/start/mongostore --fork --logpath /root/start/mongostore/mongo.log
java -jar /root/apiscerana/iam-apiscerana-1.0-SNAPSHOT-fat.jar
