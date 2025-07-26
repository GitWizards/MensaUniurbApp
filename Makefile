# Makefile for Docker Compose-based Flutter/Android development workflow

# Build the Docker image using docker compose
build:
	docker compose build

# Start an interactive shell in the container with the project mounted
shell:
	docker compose run --rm flutter-dev bash

# Run a Flutter command in the container (e.g., make flutter ARGS="pub get")
flutter:
	docker compose run --rm flutter-dev flutter $(ARGS)

# Run a Flutter doctor in the container
doctor:
	docker compose run --rm flutter-dev flutter doctor

# (Optional) Run with X11 forwarding for Android emulator (host must allow X11)
android-emulator:
	docker compose run --rm flutter-dev bash

.PHONY: build shell flutter doctor android-emulator flutter
