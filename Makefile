DOCKER_PATH := .
CURRENT_DATETIME := $(shell date +%F_%H-%M)

#current user id
UID := $(shell id -u)
GUID := $(shell id -g)
export USER_ID=$(UID)
export GROUP_ID=$(GUID)

build: # build containers
	@ docker-compose -f docker-compose.yml build

start: # start containers
	@ docker-compose -f docker-compose.yml start

up: # create and start containers
	@ docker-compose -f docker-compose.yml up -d

stop: # stop containers
	@ docker-compose -f docker-compose.yml stop

down: # down all data
	@echo "This command will delete all data, including the database. Do you want to continue? (print 'yes' for continue): "
	@read accept && if [ "$$accept" = "yes" ]; then \
		docker-compose -f docker-compose.yml down -v --remove-orphans; \
	else \
		echo "aborting"; \
	fi

chown: ## chown all to local user
	@sudo chown -R $(USER_ID):$(GROUP_ID) .

wordpress: ## shell php-fpm container
	@docker-compose exec wordpress sh -c 'bash'

restart: stop start
