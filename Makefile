SRC = ./srcs/docker-compose.yml

NAME = inception

all:$(NAME)

$(NAME):
	mkdir -p /home/nade-la-/data/website
	mkdir -p /home/nade-la-/data/database
	#lancer docker-compose
	docker-compose -f $(SRC) up -d --build
set_up:
	sudo chmod 777 /var/run/docker.sock
	echo "127.0.0.1 nade-la-.42.fr" | sudo tee -a /etc/hosts
	
stop: #stopper les containers
	docker-compose -f $(SRC) stop 

clean:	stop
	#stop et supprime les containers
	docker-compose -f $(SRC) down --rmi all --volumes

prune:  clean
	#effacer tous les containers inutilises
	docker system prune -a -f
		

	
