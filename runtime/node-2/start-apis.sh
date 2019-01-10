#!/bin/bash
nohup mongod --dbpath /root/start/mongostore --fork --logpath ./mongostore/mongo.log
java -jar /root/apiscerana/iam-apiscerana-1.0-SNAPSHOT-fat.jar
bitcoind -addnode=10.7.0.11:12345 -addnode=10.7.0.13:12345 -addnode=10.7.0.14:12345 -rpcuser=rpc -rpcpassword=x -rpcport=10340 --datadir=/root/bitcoind-bims/ -port=12345 -walletbroadcast=1