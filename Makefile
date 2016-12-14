IMAGE_NAME=docker.jw4.us/alpine-nginx-php
IMAGE_NAME_2=jwss/alpine-nginx-php
IMAGE_FILE=Dockerfile
IMAGE_DIR=.

all: image

image:
	docker build -t $(IMAGE_NAME) -t $(IMAGE_NAME_2) -f $(IMAGE_FILE) $(IMAGE_DIR)

push:
	docker push $(IMAGE_NAME)
	docker push $(IMAGE_NAME_2)

.PHONY: all image push
