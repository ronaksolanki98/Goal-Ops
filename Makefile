APP_NAME=devops-project

.PHONY: help test run docker-build stack-up stack-down stack-logs

help:
	@echo "Available targets:"
	@echo "  test         Run Go tests"
	@echo "  run          Run the app locally"
	@echo "  docker-build Build the app image"
	@echo "  stack-up     Start app, Postgres, Prometheus, and Grafana"
	@echo "  stack-down   Stop the local stack"
	@echo "  stack-logs   Tail logs from the local stack"

test:
	go test ./...

run:
	go run .

docker-build:
	docker build -t $(APP_NAME):local .

stack-up:
	docker compose up --build -d

stack-down:
	docker compose down -v

stack-logs:
	docker compose logs -f
