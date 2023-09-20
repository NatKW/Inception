# Introdution to "Inception" project 

Docker is a wonderful platform that solves a major problem encountered by developpers: missing or incorrect application dependencies from one OS to another. This project allows us to understand how Docker works and what are the main functionalities it offers to solve this major problem. 

Requirements
=================================
1. set up a small infrastructure composed of different services under specific rules. **The whole project has to be done in a virtual machine**. You
have to use docker compose.

2. Each Docker image must have the same name as its corresponding service.

3. Each service has to run in a dedicated container. For performance matters, the containers must be built either from the penultimate stable
version of Alpine or Debian. The choice is yours.

4. **Write your own Dockerfiles, one per service**. The Dockerfiles must be called in your docker-compose.yml by your Makefile.
It means you have to build yourself the Docker images of your project. It is then forbidden to pull ready-made Docker images, as well as using services such as DockerHub (Alpine/Debian being excluded from this rule).
You then have to set up:
• A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
• A Docker container that contains WordPress + php-fpm (it must be installed and
configured) only without nginx.
• A Docker container that contains MariaDB only without nginx.
• A volume that contains your WordPress database.
• A second volume that contains your WordPress website files.
• A docker-network that establishes the connection between your containers.
Your containers have to restart in case of a crash.


Main difficulties.
=================================

  1. Undestanding Docker environement 
  2. Many error msges due to configuration file :
  3. Understanding difference between Dockerfile and Docker-Compose 
  4. Understanding while writing a Docker-compose, the difference between Expose and Ports
  5. What is TCP ? TLS ? SSL ? 
  6. How to get our specific name and tag for an image ( while building, nginx:for_inception)
  7.What is www-data user in nginx?
  8. What is front-tier Network ?
  9. Why launching Nginx in the foreground and not background ? What's the purpose ?
  10.  PID 1 zombie reaping problem.

  **Errors encountered for mariaDB**

  1. "“Error response from daemon: Container $$$$ is restarting, wait until the container is running.”
    
  *Solution* : /* docker logs --details CONTAINER_ID */ made me understand, that the pb came from INNODB: unknown/unstarted service. INNODB is a storage engine for Mysql and Mariadb. This made me, obviously, think about "Volumes". Effectively, i checked my file supposed to host my data from mariadb and it was suppressed so i recreated. Everything worked fine then.
  
  2. Feels like the script written to do configs in mariaDB isn't read so passwords, users and dbs are not created.
     
     **Solution** : 
        - Launched the mariaDB terminal
        - checked if the script was created in the directory i configured and launched it 
        Error encountered : " mysqld: Got error 'Could not get an exclusive lock; file is probably in use by another process' when trying to use aria control file '/var/lib/mysql/aria_log_control' "

# SUMMARY

### 1. [DEFINITIONS](https://github.com/elkamina/42_Inception/blob/main/README.md#definitions)
### 2. [DOCKER COMMANDS](https://github.com/elkamina/42_Inception/blob/main/README.md#docker commands)

# Definitions
## What is a docker ?
Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.
Docker provides the ability to package and run an application in a loosely isolated environment called a container.

## What is a docker-compose ?
[What is docker in general](https://www.educative.io/blog/docker-compose-tutorial)
[What is docker network](https://www.aquasec.com/cloud-native-academy/docker-container/docker-networking/)
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## What is a docker-file ?
Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.


# Docker commands
| Command | Purpose |
|:--------------|:----------------|
| **docker build** | For building images |
| **docker run**  | For running a container from an image |
| **docker pull** | For pulling a Docker image from the Docker repository|
| **docker push** | For updating an image in Docker repo |
| **docker ps** | Listing all active containers (PS : referring to Processes) |
| **docker container ls -a** | Listing all active and non active containers |
| **docker rmi -f IMAGE_ID** | Forcing the delete of a certain image |
| **docker rm -f CONTAINER_ID** | Forcing the delete of a certain container |
| **docker images** | Listing all images |
| **docker compose up** | Launching docker-compose.yml |
| **docker stop CONTAINER_ID** | Stoping a container  |
| **docker start CONTAINER_ID** | Restarting a container  |
| **docker image -prune** | Removing all unused images  |
| **docker exec -it nginx sh** | Launching a shell from a container|
| **docker volume ls** | lists all the volumes created by the container|
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|
| **docker network ls** | All networks created and existing in Docker |
| **docker exec CONTAINER_NAME ps -eaf** | print out the processes running |
| **docker system prune** | Remove all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.  |
| **docker logs ** | print out the processes running |


Links that helped
-----------
| Subject | Link |
|:--------------|:----------------|
| Tutorial about inception : | https://tuto.grademe.fr/inception/|
| Building Nginx Container from scratch | https://medium.com/@sudarshan_10/building-nginx-web-server-from-scratch-docker-image-53165b7dc130|
| Docker Documentation  |https://docs.docker.com/|
| Difference between ENTRYPOINT & CMD in Dockerfile  |https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/|
| Didnt get everything but will make sens maybe later |https://stackoverflow.com/questions/57554703/why-use-nginx-with-daemon-off-in-background-with-docker|
| CMD in Dockerfiles |https://nickjanetakis.com/blog/docker-tip-63-difference-between-an-array-and-string-based-cmd |
| MariaDb Documentation | https://dev.mysql.com/doc/refman/5.6/en/mysql-install-db.html |
| MariaDb Script to launch : Inspo from Docker Hub| https://github.com/yobasystems/alpine-mariadb/blob/master/alpine-mariadb-amd64/Dockerfile |
| Volumes on Docker| https://medium.com/techmormo/how-do-docker-volumes-enable-persistence-for-containers-docker-made-easy-4-2093a1783b87 |
| Commands in Docker | Default parameters that cannot be overridden when Docker Containers run with CLI parameters.|
| PID 1 | https://hasgeek.com/rootconf/2017/sub/what-should-be-pid-1-in-a-container-JQ6nkBv13XeZzR6zAiFsip  && https://man7.org/linux/man-pages/man1/init.1.html && https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/ && https://daveiscoding.com/why-do-you-need-an-init-process-inside-your-docker-container-pid-1 |  
| docker-compose.yaml specifications | https://github.com/compose-spec/compose-spec/blob/master/spec.md |
| Tuto pour WP from scratch | [https://github.com/compose-spec/compose-spec/blob/master/spec.md](https://codingwithmanny.medium.com/custom-wordpress-docker-setup-8851e98e6b8) |

Sideways:
-----------
Some cool new command line learnt : 
  - ps -ef | grep -i nginx => *to know which user is used by the server nginx*
  
  - apk list : to launch inside the container terminal to list all the packages installed
  

Intersting concepts to develop :
----------
1a. Load Balancing

2a. Reverse proxy

3a. CGI script : CGI stands for Common Gateway Interface and provides an interface between the HTTP server and programs generating web content. These programs are better known as CGI scripts. They are written in a scripting language.

4a. /!\ *docker stop* command sends a SIGTERM to the init process and then SIGKILL

Glossary
----------

**Daemon** : is a program that runs continuously as a background process and wakes up to handle periodic service requests, which often come from remote processes. The daemon program is alerted to the request by the operating system (OS), and it either responds to the request itself or forwards the request to another program or process as appropriate.

**mysqld** : is the mysql server.

**data directory** : contains databases and tables. It is also the default location for other information such as log files and status files.

**InnoDB** : is a storage engine for MySql and Mariadb. It stores the data on a disk or keeps it in the main memory for quick access.

**Bridge networks** : a bridge network is a Link Layer device which forwards traffic between network segments. A bridge can be a hardware device or a software device running within a host machine’s kernel. In terms of Docker, a bridge network uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.Bridge networks apply to containers running on the same Docker daemon host. TO MAKE COMMUNICATIONS BETWEEN CONTAINERS not belongign to the same network, we use OVERLAY network
/!\ When you start Docker, a default bridge network (also called bridge) is created automatically, and newly-started containers connect to it unless otherwise specified. You can also create user-defined custom bridge networks. User-defined bridge networks are superior to the default bridge network.

**Reaping a process **
  Process of eliminating zombie processes. /!\ Using has caveats : it blocks parent process if the child hasn`t terminated


Existencial questions 
----------
1. What is the difference between Docker run and Docker exec ?

*Answer* : 
  In short, docker run is the command you use to create a new container from an image, whilst docker exec lets you run commands on an already running container

2. What is the use of "--no-cache" in Dockerfiles (someetimes replaced by rm /var/cache/apk/*.) ?

*Answer* : 
  Briefly, to have the packages available during boot, apk can keep **a cache** of installed packages on a local disk. Added packages can then be automatically (re-)installed from local media into RAM when booting, without requiring, and even before there is a network connection.
The APKINDEX file is a text file containing records for each package in the repository in a text-based format. Each record is separated by a newline.
So, the option "--no-cache" allow us to not cache the index locally, which is useful for keeping containers small.

*https://stackoverflow.com/questions/49118579/alpine-dockerfile-advantages-of-no-cache-vs-rm-var-cache-apk#:~:text=The%20%2D%2Dno%2Dcache%20option,add%20nginx%20WARNING%3A%20Ignoring%20APKINDEX.*

3. Why do we need **volumes** ?

*Answer* : 
 The data living through a container doesn't have durability. So, we need volumes to store data in a perennial way.

4. Difference between ENTRYPOINT and CMD ?

*Answer* : 
  **CMD**         : Sets default parameters that can be overridden from the Docker Command Line Interface (CLI) when a container is running
  **ENTRYPOINT**  : Default parameters that cannot be overridden when Docker Containers run with CLI parameters.
  
5. What is PID=1 in containers (look to sysvinit) ?

*Answer*
  Usually, PID 1 is the init/systemd process. But what is systemd process and init ?
  It's a system designed for Linux Kernel and is the first process with PID = 1, which gets executed in user space during the Linux start-up process.
  *Sysvinit* : is the first process started by the kernel when you boot up any Linux or Unix computer. This means that all the other processes are their    child in one way or the other. Systemd replaced Sysvinit which became a bit obsolete for modern day-computer.
  
 6. What is the difference between EXPOSE and PORTS in DOCKERFILE ?
 
 **The expose section** allows us to expose specific ports from our container only to other services on the same network. We can do this simply by specifying the container ports.

**The ports** section also exposes specified ports from containers. Unlike the previous section, ports are open not only for other services on the same network, but also to the host. The configuration is a bit more complex, where we can configure the exposed port, local binding address, and restricted protocol.
