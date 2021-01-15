IMAGE_NAME=docker.jw4.us/alpine-nginx-php7
IMAGE_FILE=Dockerfile
IMAGE_DIR=.

all: image

image:
	docker buildx build \
		--platform  linux/amd64,linux/arm64,linux/arm/v7 \
		-t $(IMAGE_NAME) -f $(IMAGE_FILE) $(IMAGE_DIR)

push:
	docker buildx build --push \
		--platform  linux/amd64,linux/arm64,linux/arm/v7 \
		-t $(IMAGE_NAME) -f $(IMAGE_FILE) $(IMAGE_DIR)

.PHONY: all image push
