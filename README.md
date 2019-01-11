
## How to Setup the Project

#### Download Project

	git clone --recursive https://github.com/Xiaoyang-Zhu/btcd-docker-cluster.git

#### Compile Apiscerana

Entering folder Apiscerana and following README tutorial in Apiscerana, install JAVA, Maven, Mongodb.

	mvn package

#### Build it up

Backing to the root directory of the Project and following docker-bitcoin-cluster-tutorial to 1) install docker and docker-compose, 2) generate genesis, 3) modify the source code. Finally, run:

	docker-compose build
	docker-compose up

Check the services through:
Dashboard http://localhost:5000
Node-1 http://localhost:35001
Node-2 http://localhost:35002
Node-3 http://localhost:35003
Node-4 http://localhost:35004

Voilà !

Note: How to setup miners? It could be found in  docker-bitcoin-cluster-tutorial.
