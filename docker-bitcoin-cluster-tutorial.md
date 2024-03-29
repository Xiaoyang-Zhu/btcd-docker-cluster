
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


#### Generate Genesis Block and Modify the Source Code for the Submodule Bitcoin-BIMS
In the submodule directory, Bitcoin-BIMS/genesis-block/ run the following command:

	./genesis 044e6c20a3dbb6938b6428b17628682eb3daba62849455e13e71966a6ccb576da081381e060f41e9911b4f5a7a70025be5ff787d1b4308159edc2a5075ff688fea   "27/Dec/2018 Xiaoyang, Blockchain-based Identity Management System for IoT" 486604799

Get the last three return values: Hash, Nonce, and Unix time
Modify the following two lines:

	In src/chainparams.cpp

	genesis = CreateGenesisBlock(Unix time, Nonce, 0x1d00ffff, 1, 50 * COIN);
	assert(consensus.hashGenesisBlock == uint256S("0xHash"));


#### Run Miner

Entering one container, run the miner

	docker ps

	docker exec -it node-1 bash

	cd /root/miner

	./minerd --user rpc --pass x --url http://127.0.0.1:10340/ --threads 1 --coinbase-addr 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv --coinbase-sig "BIMS coins" -a sha256d -D


#### Enabled Update Transactions Functionality
After 5 blocks, the maturity of coinbase becomes generated from immature

	docker exec -it node-1 bash

	// import the private key of predefined account: 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv
	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 importprivkey L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb

In node-1 (localhost:35001), you can send transactions in Blockchain IdP module.

#### Predefined Bitcoin Coinbase Account

This account was created for providing fees of sending identity transactions in Apiscerana Blockchain module.

		// generate params: "" legacy, the second one is for 1 prefix address, otherwise the default is p2sh with 3 prefix address
		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress "" legacy
		return value: 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv

		// dump the private key of 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv
		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 dumpprivkey 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv
		return value: L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb
