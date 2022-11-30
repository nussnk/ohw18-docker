# docker

### Cоздаем Dockerfile
В нем описываем процедуру подготовки образа: на образ alpine ставитcя nginx, подготавливается среда (установка нужных пакетов, создание пользователя, папок, файлов и т.п.).
Запускается nginx

Для проверки запустим контейнер 
```
docker run -it -d -P mynginx:v1.16
```
Посмотрим результат:
```
root@kim-test:/home/nikolay/otus/ohw18-docker# docker ps -a
CONTAINER ID   IMAGE           COMMAND                  CREATED             STATUS                         PORTS                                     NAMES
b1f778f6b621   mynginx:v1.16   "nginx -g 'daemon of…"   21 minutes ago      Up 21 minutes                  0.0.0.0:49156->80/tcp, :::49156->80/tcp   strange_nightingale
```
Видим, что на хост сервере слушается порт 49156. Запросим страницу
```
root@kim-test:/home/nikolay/otus/ohw18-docker# curl localhost:49156
<!DOCTYPE html>
<html lang="en">
        <head>
                    <meta charset="utf-8" />
                        <title>HTML5</title>
        </head>
        <body>
                    Server is online
        </body>
</html>
```
### Заливка образа на docker hub
Авторизуемся на hub.docker.com
```
root@kim-test:/home/nikolay/otus/ohw18-docker# docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: nussnk
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```
Зададим тег нашему образу и зальем на docker hub
```
docker image tag mynginx:v1.16 nussnk/alpine-nginx-otus:1.0
docker image push nussnk/alpine-nginx-otus:1.0
```
### Проверка домашнего задания
Для проверки домашнего задания необходимо выкачать образ из хаба и создать+запустить контейнер
```
docker pull nussnk/alpine-nginx-otus:1.0
docker run -it -d -P nussnk/alpine-nginx-otus:1.0
```
Через docker ps проверяем на каком порту висит контейнер и запускаем curl
```
root@kim-test:~# docker ps
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS                                     NAMES
60465711cc4b   nussnk/alpine-nginx-otus:1.0   "nginx -g 'daemon of…"   5 minutes ago   Up 5 minutes   0.0.0.0:49158->80/tcp, :::49158->80/tcp   amazing_leakey
root@kim-test:~# curl localhost:49158
<!DOCTYPE html>
<html lang="en">
        <head>
                    <meta charset="utf-8" />
                        <title>HTML5</title>
        </head>
        <body>
                    Server is online
        </body>
</html>
```

### К вопросу в чем разница менжду образом и контейнером
Образ - основа, шаблон. Контейнеры - сущности созданные из образа. 

