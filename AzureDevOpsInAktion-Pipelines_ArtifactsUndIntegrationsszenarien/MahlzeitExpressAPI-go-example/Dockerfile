# Dockerfile

# Build Stage
FROM golang:1.20 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o mahlzeitexpress main.go

# Run Stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/mahlzeitexpress .
EXPOSE 8080
ENTRYPOINT ["./mahlzeitexpress"]
