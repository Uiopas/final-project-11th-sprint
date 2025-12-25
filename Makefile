IMAGE_NAME=tracker
CONTAINER_NAME=tracker

.PHONY: build run clean

## Собрать Docker-образ
build:
	docker build -t $(IMAGE_NAME) .

## Запустить контейнер
run: build
	docker run --rm \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME)

## Удалить контейнер и образ
clean:
	docker rm -f $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true
