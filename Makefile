IMAGE_NAME=jwss/alpine-nginx-php
IMAGE_FILE=Dockerfile
IMAGE_DIR=.

all: image

image:
	docker build -t $(IMAGE_NAME) -f $(IMAGE_FILE) $(IMAGE_DIR)

.PHONY: all image
