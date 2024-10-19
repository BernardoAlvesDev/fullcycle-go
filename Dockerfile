# Build stage
FROM golang:alpine as builder

WORKDIR /app

# Copie o código Go para o diretório de trabalho
COPY . .

# Compile o programa com opções de redução de tamanho
RUN go mod tidy
RUN go build -ldflags="-s -w" -o fullcycle

# Final stage
FROM scratch

# Copie o binário compilado da fase anterior
COPY --from=builder /app/fullcycle /fullcycle

# Defina o binário como ponto de entrada
ENTRYPOINT ["/fullcycle"]
