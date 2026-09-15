NAME := Terraria-Server
DOCKER := docker
COMPOSE := docker compose
CONTAINERS := terraria terraria-playit-1

all: up log

log:
	@sh run-logs.sh

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

clean:
	$(DOCKER) rm $(CONTAINERS)

re: clean all

rm-world:
	@read -p "Enter World Name: " world; \
	$(DOCKER) run -v "./Terraria/Worlds/:/Worlds" alpine:latest sh -c "rm -rf /Worlds/$$world.wld*"

.PHONY: all up down clean re rm-world
