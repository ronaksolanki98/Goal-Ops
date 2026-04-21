FROM golang:1.22.5-alpine AS builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY main.go ./
COPY kodata ./kodata

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/devops-project .

FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /app

ENV KO_DATA_PATH=/app/kodata

COPY --from=builder /out/devops-project /app/devops-project
COPY --from=builder /src/kodata /app/kodata

EXPOSE 8080

ENTRYPOINT ["/app/devops-project"]
