# wpa-free_web

The purpose of this repository is to run the [FREE_web](https://github.com/e-lab-FREE/FREE_Web) 
Django framework in a Docker environment. It greatly simplifies the installation and configuration procedure.


## Software requirements

All python packages and libraries required to run the container are already listed in the `requirements.txt` and `packages.txt` files, so they are installed automatically while building the container for the first time. 
You will obviously need `git`, `docker` and `docker compose` installed before cloning and running the docker container. 

```bash 
# install docker:
curl -fsSL get.docker.com | sudo sh
# install git and docker compose:
sudo apt install git docker-compose-plugin
```

## Install procedure

Besides cloning this repo to a directory of your choice (e.g. /opt/docker), you will also need to clone the original FREE_Web repo to the `free-server` folder, just like this:

```bash
mkdir -p /opt/docker
cd /opt/docker
sudo git clone https://github.com/bgeneto/wpa-free_web.git
sudo chown -R $USER:$USER /opt/docker/wpa-free_web
cd wpa-free_web
git clone --recursive -b dev-unb https://github.com/e-lab-FREE/FREE_Web.git ./free-server
```

## Configure

Rename `.env.tmp` file inside the `config` folder to `.env` and change the required parameters

```bash
mv config/.env.tmp config/.env
```

If you are going to use mariadb DBMS then also rename the `.env.tmp` file (to `.env`) inside the root folder and edit its contents accordingly.
```bash
mv .env.tmp .env
```

Instead, if you are going to use sqlite3 then simply rename the template file:

```bash
mv free-server/db_template.sqlite3 free-server/db.sqlite3
```


## Build and run the container

Now you can build and run the container by simply issuing: 

```bash
docker compose up -d --build
```

## Import database initial data


If using mysql/postgres then import the initial template sql file to your db container: 

```
docker exec -i wpa-mariadb mysql --user=<freewebdbuser> --password=<freewebdbuserpasswd> freeweb < ./free-server/freeweb-mariadb-template.sql
``` 

## Debug errors

Check docker logs if debug is needed:

```bash
docker logs wpa-app
```
