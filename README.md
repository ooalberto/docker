# Comandos

```bash
docker build -t albertomoreira:v6 .

docker run -d -p 8000:80 --name webserv albertomoreira:v6

Docker
log docker 
 docker logs 427470c345ce

fazer espelamento do volume na maquina

 docker run -d -p 8084:80 -v /C/Complementos/docker/:/usr/share/nginx/html --name demanda1 nginx

docker run -d -p 8088:80 -v  /c/Users/Default/Documents/html:/usr/share/nginx/html --name demanda8 nginx

duplicando o caontainer com outro nome 
 docker run -d -p 8089:80 --volumes-from demanda8 --name demanda9 nginx

http://localhost:8084/

docker ps
docker ps -a (all)
docker rm $(docker ps -a -q) -- apagar todos os contaniner pausados
docker inspect image (mostra dados e volume, olha em amounts)

# logar o aplicativo do windows no doker online com oalberto@gmail.com
docker run hello-world = executar o template do contauner
docker run -it ubunto bash --> executa o imagem e entra no bash
docker ps ver todos containers em execucao
docker ps -a
docker rmi (cdigo do container) parar apare
https://hub.docker.com/ busca 
app.DockerFile

# criando image mysql 
docker run --name dbserver-mysql -e MYSQL_DATABASE=wordpress -e MYSQL_ROOT_PASSWORD=179334 -d mysql:5.7

docker ps  (ve os container em execucao pegao o ID )
docker stop 4ca21ecbc551 
docker run --help (escolher opcao)
docker run -d nginx (executa em blackroud)
descobrir ip do container
docker inspect <containerNameOrId> | grep '"IPAddress"' | head -n 1
entrar no terminal
docker exec -t web5 bin/bash

# startar image com nome  (-d em blackground,  -p porta)
docker run -d -p 8080:80 --name webserver nginx
navegador: http://localhost:8080/

# sempre que dar stop apagauar
docker stop <containerNameOrId>
docker rm <containerNameOrId>

# Rodar comando dentro do container usa o exec:
docker exec webserver ls
criando direitorio 

docker exec webserver2 mkdir /tmp/docker

# entrar no shell 
docker exec -it webserve /bin/bash

 winpty docker run -it ubuntu

# assim funfou sem o barra raiz
winpty docker run -it nginx bin/bash

# roda no terminal pra isntalar os pacotes
 apt-get update

apt-install nano, vim

cd /usr/share/nginx/html/
start com porta e bash 
winty docker run -p 8080:80 -it nginx bin/bash
 
# clona o container com suas alteracoes e torna-lo imagem
docker commit distracted_robinson webservdefault:v1
 
# para executar tem q colocar a coluna tag v1
 docker run -d -p 8080:80 webservdefault:v1

# o CONTAINER TEM UM CICLO DE VIDA, então tem que separar o clico de vida dos dados, persistir.

# Para que não sejam destruidos com o circulo de vida do cotainer
-v /data cria um volume não se perde com container
 winpty docker run -it -v /data --name webpersis nginx bin/bash

docker ps - a mostra todos os containers stopado ou não 
docker rm $(docker ps -a -q) remove todos os container 

# baixando o mysql do docker hub depois linkando o wordpress


MARAVILHA WORDPRESS COM BANCO
docker run --name dbserver-mysql -e MYSQL_DATABASE=wordpress -e MYSQL_ROOT_PASSWORD=179334 -d mysql:5.7



# subindo wordpress e conectando no container mysql acima
docker run --name wordpress --link dbserver-mysql:mysql -d -p 8088:80 wordpress

docker exec -it wordpress bash

 cat /etc/hosts
ver q o host ta confugurado como mysql 

pra acessar o db do outro container
apt-get install mariadb-client

 mysql -uroot -h mysql -p
1793334

show databases

(ao acesssar atentar pro user q é root senha 179334

# CONSTRUINDO IMAGEM PERSONALIZADA! 
___________________________ construindo o Dockerfile
FROM ubuntu
MAINTAINER Alberto Moreira Soares
RUN apt-get update
RUN apt-get install -y nginx && apt-get clean
RUN rm -v /etc/nginx/nginx.conf
ADD ./configs/nginx.conf /etc/nginx/
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 8000

COPY ./index.html /var/www/html/

CMD ["/usr/sbin/nginx"]



# _________________________________ arquivo do add ./configs/nginx.conf
http {
    server {

        root /var/www/html;

        location / {
            index index.html;
        }
    }
}
events {
    worker_connections 1024;
}


# ________________________ rodando o Dockerfile     - docker build --help                                

docker build -t albertomoreira/nginx .

 docker run -d -p 8000:80 albertomoreira/nginx:v6

___________http://localhost:8000/________________
docker-composer.yml (AUTOMATIZADOR DE TAREFAS)
https://github.com/schoolofnetcom/iniciando-com-docker
 docker-compose.exe up -d

# _______________________docker-compose.exe up -d  (roda)
docker-compose.yml

version: '2'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: somewordpress
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8010:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
volumes:
    db_data:
```