FROM golang:alpine as builder

WORKDIR /app

COPY . .

RUN go mod tidy
RUN go build -ldflags="-s -w" -o fullcycle

FROM scratch

COPY --from=builder /app/fullcycle /fullcycle

ENTRYPOINT ["/fullcycle"]
