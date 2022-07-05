SRC = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env
NAME = inception

all:$(NAME)

$(NAME):
	mkdir -p /home/nade-la-/data/website
	mkdir -p /home/nade-la-/data/database
	#lancer docker-compose
	docker-compose -f $(SRC) up -d --build
	sudo chmod 777 /var/run/docker.sock

ip:
	sudo sed -i "s|127.0.0.1	localhost|127.0.0.1	localhost nade-la-.42.fr|g" /etc/hosts
	
stop: #stopper les containers
	docker-compose -f $(SRC) stop 
	sudo sed -i "s|127.0.0.1	localhost nade-la-.42.fr|127.0.0.1	localhost|g" /etc/hosts

clean:	stop
	#stop et supprime les containers
	docker-compose -f $(SRC) down --rmi all --volumes
	
datarm:
	sudo rm -rf /home/nade-la-/data

prune:  clean
	#effacer tous les containers inutilises
	docker system prune -a -f
		
re: 	prune all

.PHONY: all clean fclean re setup
