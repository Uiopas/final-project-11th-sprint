FROM golang:1.22.2-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o tracker

FROM gcr.io/distroless/base-debian12:nonroot
WORKDIR /app
COPY --from=builder /app/tracker /app/tracker
COPY tracker.db /app/tracker.db
USER nonroot:nonroot
ENTRYPOINT ["/app/tracker"]