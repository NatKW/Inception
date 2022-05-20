SRC = /srcs/docker-compose.yml

NAME = inception

all:$(NAME)

$(NAME):
	mkdir -p /home/nade-la-/data/website
	mkdir -p /home/nade-la-/data/data
	sudo chmod 777 /var/run/docker.sock
	echo "127.0.0.1 nade-la-.42.fr" | sudo tee -a /etc/hosts

	#lancer docker-compose
	docker-compose -f $(SRC) up -d --build

stop: #stopper les containers
	docker-compose -f $(SRC) stop

clean:	stop
	#stop et supprimer les containers
	docker-compose -f $(SRC) down --rmi all --volumes
	sed -i 's/nade-la-.42.fr/127.0.0.1/g' /etc/hosts
prune:
	#effacer tous les images
	docker image prune -a -f
