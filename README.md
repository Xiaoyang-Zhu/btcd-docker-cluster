
## How to Setup Docker Bitcoin Cluster

#### Install Docker
OS Environment: Ubuntu 18.04

Guide: How To Install and Use Docker on Ubuntu 18.04 https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04


	$ sudo apt update

	$ sudo apt install apt-transport-https ca-certificates curl software-properties-common

	$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

	$ sudo apt update

	$ apt-cache policy docker-ce

	$ sudo apt install docker-ce

	// Executing the Docker Command Without Sudo
	$ sudo usermod -aG docker username


####  docker


	sudo docker-compose build

	sudo docker-compose up

	sudo docker ps

Entering one, run the miner

	sudo docker exec -it btcddockercluster_node1_1 bash

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getbalance

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getblockchaininfo

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 sendrawtransaction

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getrawmempool

	// generate params: "" legacy, the second one is for 1 prefix address, otherwise the default is p2sh with 3 prefix address
	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress "" legacy
	return value: 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 dumpprivkey 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv
	return value: L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb

	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 importprivkey L5nBDMzHzTHvR3fKa5VGT8r9cYdVSn9WJU3puoUGcN93SeqT7nrb

	./minerd --user rpc --pass x --url http://127.0.0.1:10340/ --threads 1 --coinbase-addr 1Ez1ZNPLPb8rotecEBZWtNWNx8oijzwxQv --coinbase-sig "BIMS coins" -a sha256d -D



#### Send coins

		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getnewaddress "" legacy
		19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w

		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 dumpprivkey 19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w
		return value: KzfsUGsbnkc48uDMwfivZJkfFgu2kBADFZ8RMzWue7efGfmv9dXQ

		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 sendtoaddress 19zgqVoZWrZoWDgfXNyujgZK2dnrNq1T9w 20

		bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 getrawmempool



	bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 listtransactions



	$ bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 createrawtransaction '[{"txid":"e4cad933221f4fea4edc747d664c543fcb47cab127d3fccc6b79658932c2eaa5","vout":0}]' '{"3C9oBT51t6gv2nTm9eg6od2ePbGWjeebvV":49.95}'

	$ bitcoin-cli -rpcuser=rpc -rpcpassword=x -rpcport=10340 signrawtransaction "0200000001a5eac2328965796bccfcd327b1ca47cb3f544c667d74dc4eea4f1f2233d9cae40000000000ffffffff01c0a6b9290100000017a91472c1d9fb72a48f626f93a504206b6e813d2a52338700000000" '[{"txid":"e4cad933221f4fea4edc747d664c543fcb47cab127d3fccc6b79658932c2eaa5","vout":0,"scriptPubKey":"a914247f89b252fea20722409dc24fb2e8b58969375587"}]' '["L4edR6AdgJvfMSL4hYV4KMbzK5tEqk7Dt9yKfyFHmusUUfKrakzB"]' "ALL"

	$ bitcoin-cli -regtest sendrawtransaction 0200000001fefd3443c00f3772a28c3da60fee0fa7a460d181b4e068fbe72248ed59e27276010000008a4730440220309181fec13f4f9696ab6030546a125dcd04b148d0c316fe76c96ec5fd809d8d02204ad03c1a1ef9363b894abcbc63d5b4b14871841963743b76a1fc44ee6454ac65014104a434aa7ac19a69558243772914f79281b555ffed2f825a78006ef6f51b1ed6f48add6538e56d067f7d4f6d4cb9efb59d6e83ff26e40a0559bd0c1e53456c1617ffffffff018033023b0000000017a914feb1a122b740e102e1dbae1cbb0cb83550909ea88700000000









Docker Operations


sudo docker images -a

sudo docker rmi -f 1b55d2b96cc7

docker-compose ps

docker-compose rm

// copy file from a docker to local machine
sudo docker cp 063ce742fd98:/root/bitcoind-bims/wallet.dat ./
