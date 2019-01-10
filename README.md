
## How to Setup the Project

#### Download Project

	git clone --recursive https://github.com/Xiaoyang-Zhu/btcd-docker-cluster.git

#### Compile Apiscerana

Entering folder Apiscerana and following README tutorial in Apiscerana, install JAVA, Maven, Mongodb.

	mvn package

#### Build it up

Backing to the root directory of the Project and following docker-bitcoin-cluster-tutorial to 1) generate genesis, 2) modify the source code. Finally, run:

	docker-compose build
	docker-compose up

Voilà !
