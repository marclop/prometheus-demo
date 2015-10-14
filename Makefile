PARAMETERS = app/config/parameters-tpl.yml
COMPONENT ?= prometeus
VERSION ?= $(shell cat VERSION)

all: build-deps init test package
tests: test

init: deps
	@echo '--> Installing dependencies'
	@sudo pip install -r requirements.txt

build-deps:
	@./scripts/deps.sh build

deps:
	@./scripts/deps.sh

dev:
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml up -d
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml logs

nodev:
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml kill
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml rm -f
	-@docker rmi prometeus_incrementer

stop:
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml kill

logs:
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml logs

ps:
	@docker-compose -p ${COMPONENT} -f ops/docker/docker-compose.yml ps

gauge:
	@./scripts/callincrementer.sh 192.168.99.100:5000 gauge

counter:
	@./scripts/callincrementer.sh 192.168.99.100:5000 counter

.PHONY: test docs logs
