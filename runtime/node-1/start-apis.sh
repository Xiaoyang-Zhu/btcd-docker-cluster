#!/bin/bash
bitcoind -addnode=10.7.0.12:12345 -addnode=10.7.0.13:12345 -addnode=10.7.0.14:12345 -daemon -rpcuser=rpc -rpcpassword=x -rpcport=10340  --datadir=/root/start/bitcoind-bims/ -port=12345 -walletbroadcast=1 -txindex=1 -server=1 -rest=1 -zmqpubhashtx=tcp://127.0.0.1:28332 -zmqpubhashblock=tcp://127.0.0.1:28332 -zmqpubrawblock=tcp://127.0.0.1:28332 -zmqpubrawtx=tcp://127.0.0.1:28332
mongod --dbpath /root/start/mongostore --fork --logpath /root/start/mongostore/mongo.log
nohup java -jar /root/apiscerana/iam-apiscerana-1.0-SNAPSHOT-fat.jar &
cd /root/dashboard/
./start-dashboard.sh
