
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o kbot .

FROM alpine:3.20

WORKDIR /app

# builder
COPY --from=builder /app/kbot .

# Kubernetes Secret
ENV TELE_TOKEN=""

# start bot
CMD ["./kbot"]
