.PHONY: build shell flutter doctor

build:
	docker compose build

shell:
	docker compose run --rm flutter-dev bash

flutter:
	docker compose run --rm flutter-dev flutter $(ARGS)

doctor:
	docker compose run --rm flutter-dev flutter doctor
