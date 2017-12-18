IMAGE_NAME=docker.jw4.us/alpine-nginx-php7
IMAGE_FILE=Dockerfile
IMAGE_DIR=.

all: image

image:
	docker build -t $(IMAGE_NAME) -f $(IMAGE_FILE) $(IMAGE_DIR)

push:
	docker push $(IMAGE_NAME)

.PHONY: all image push
