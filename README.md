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

Rename both `.env.tmp` files inside the root and the `config` folders to `.env` and change several parameters like `MYSQL_HOST`, `MYSQL_USER`, `FREE_SECRET`, `FREE_ALLOWED_HOSTS` etc...

```bash
mv .env.tmp .env
mv config/.env.tmp config/.env
```
Build and run the container
Now we can build and run the container by simply issuing: 

```bash
docker compose up -d
```

Check docker logs if debug is needed:

```bash
docker logs webapp
```
