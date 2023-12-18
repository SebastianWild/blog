# Define variables
BUILDER_NAME=multiarch-builder
IMAGE_NAME=sebaswild/blog
TAG?=latest
PLATFORMS=linux/amd64,linux/arm64

#all: build push

# Development
run:
	@echo "Running development server..."
	@docker compose up

# Create buildx builder
create:
	@echo "Creating a new buildx builder..."
	@docker buildx create --name $(BUILDER_NAME) --driver=docker-container --use
	@docker buildx inspect $(BUILDER_NAME) --bootstrap

# Build the multi-platform image
# Below is broken due to https://github.com/docker/buildx/issues/59
#build:
#	@echo "Building the multi-platform Docker image $(IMAGE_NAME):$(TAG)..."
#	@docker buildx build --platform $(PLATFORMS) -t $(IMAGE_NAME):$(TAG) --load .

# Push the multi-platform image
push:
	@echo "Building & pushing the Docker image $(IMAGE_NAME):$(TAG)..."
	@docker buildx build --builder=$(BUILDER_NAME) --platform $(PLATFORMS) -t $(IMAGE_NAME):$(TAG) --push .

# Clean up
clean:
	@echo "Removing buildx builder..."
	@docker buildx rm $(BUILDER_NAME)
