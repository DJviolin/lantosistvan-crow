# lantosistvan-crow

My next personal static photography portfolio website built on Node.js, Express, Handlebars.

## Prerequisites

1. Linux
2. 1GB Ram
3. 20GB disk size (preferably fixed size in virtual machines)
4. Git
5. Docker Client
6. Systemd
7. Docker-compose

## Installation

Basic install script provided. `curl` the following code to your machine and follow the instructions in the script! You doesn't even need to clone this repo (the script will do it anyway), just only download this file to your host:

```shell
$ curl -H 'Cache-Control: no-cache' -L https://raw.github.com/DJviolin/lantosistvan-crow/master/install.sh > $HOME/install-lantosistvan-crow.sh && chmod +x $HOME/install-lantosistvan-crow.sh && cd $HOME && ./install-lantosistvan-crow.sh && rm -rf $HOME/install-lantosistvan-crow.sh
```

## Usage

Run docker-compose with:

```shell
$ docker-compose --file $HOME/www/lantosistvan/docker/docker-compose.yml build
```
