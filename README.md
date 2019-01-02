
## How to Setup Docker Bitcoin Cluster

#### Install Docker
OS Environment: Ubuntu 18.04

Guide: How To Install and Use Docker on Ubuntu 18.04 https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04


	sudo apt update

	sudo apt install apt-transport-https ca-certificates curl software-properties-common

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

	sudo apt update

	apt-cache policy docker-ce

	sudo apt install docker-ce

	// Executing the Docker Command Without Sudo
	sudo usermod -aG docker username


#### Install Docker Compose
Guide: Install Docker Compose
https://docs.docker.com/compose/install/#master-builds

	sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	sudo chmod +x /usr/local/bin/docker-compose

	sudo cp /usr/local/bin/docker-compose /usr/bin/

#### Download Docker Cluster Project

	git clone --recursive https://github.com/Xiaoyang-Zhu/btcd-docker-cluster.git

#### Generate Genesis Block and Modify the Source Code for the Submodule Bitcoin-BIMS
In the submodule directory, Bitcoin-BIMS/genesis-block/ run the following command:

	./genesis 044e6c20a3dbb6938b6428b17628682eb3daba62849455e13e71966a6ccb576da081381e060f41e9911b4f5a7a70025be5ff787d1b4308159edc2a5075ff688fea   "27/Dec/2018 Xiaoyang, Blockchain-based Identity Management System for IoT" 486604799

Get the last three return values: Hash, Nonce, and Unix time
Modify the following two lines:

	In src/chainparams.cpp

	genesis = CreateGenesisBlock(Unix time, Nonce, 0x1d00ffff, 1, 50 * COIN);
	assert(consensus.hashGenesisBlock == uint256S("0xHash"));

#### Build and Run Docker Instances
Enter the btcd-docker-cluster directory, build and run the cluster

	docker-compose build

	docker-compose up

#### Run Miner

Entering one container, run the miner

	docker ps

	docker exec -it node-1 bash

	// generate params: "" legacy, the second one is for 1 prefix address, otherwise the default is p2sh with 3 prefix address
	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress "" legacy
	return value: 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv

	./minerd --user rpc --pass x --url http://127.0.0.1:10340/ --threads 1 --coinbase-addr 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv --coinbase-sig "BIMS coins" -a sha256d -D



//TESTNET

	bitcoin-cli -testnet -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress  "" legacy
	msbSfGZd9HuiRY5UQQ4cRcD9WNCnzEPgha
	./minerd --user rpc --pass x --url http://127.0.0.1:10340/ --threads 1 --coinbase-addr msbSfGZd9HuiRY5UQQ4cRcD9WNCnzEPgha --coinbase-sig "BIMS coins" -a sha256d -D



#### Send Coins
After 5 blocks, the maturity of coinbase becomes generate from immature

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress "" legacy
	return value: 19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 sendtoaddress 19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w 20

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getrawmempool


	//TESTNET

		bitcoin-cli -testnet -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress
		n17CqhzzNDdxXMitYCm1PesYQqWuqf3ud5


		bitcoin-cli -testnet -rpcuser=rpc -rpcpassword=x -rpcport=10340 sendtoaddress n17CqhzzNDdxXMitYCm1PesYQqWuqf3ud5 20

		bitcoin-cli -testnet -rpcuser=rpc -rpcpassword=x -rpcport=10340 getrawmempool

#### Bitcoin Operations List

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getbalance

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 listtransactions

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getblockchaininfo

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 sendrawtransaction

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getrawmempool

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 importprivkey L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb

Two addresses and their dumped private keys in the previous examples

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 dumpprivkey 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv
	return value: L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 dumpprivkey 19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w
	return value: KzfsUGsbnkc48uDMwfivZJkfFgu2kBADFZ8RMzWue7efGfmv9dXQ

#### Docker Operations List

	// List all images
	docker images -a

	// Remove an image
	docker rmi -f 1b55d2b96cc7

	// List all containers
	docker-compose ps

	// Remove all containers
	docker-compose rm

	// copy file from a docker to local machine
	docker cp 063ce742fd98:/root/bitcoind-bims/wallet.dat ./
